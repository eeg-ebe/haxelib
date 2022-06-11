/**
 * Copyright (c) 2019 Université libre de Bruxelles, eeg-ebe Department, Yann Spöri
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package haxelib.bio.phylo;

import haxe.ds.Vector;
import haxelib.ds.set.StringSet;
import haxelib.iterators.EnumerateIterator;
import haxelib.system.System;
import haxelib.util.Misc;
import haxelib.util.StringMatrix;

/**
 * Implementation of the K over Theta species delimination method.
 *
 * @author Yann Spoeri
 */
class KOverTheta
{
    /**
     * Plotting settings.
     */
    private var mAddSets:Bool = System.getBoolProperty("KOverTheta.addSets", false);
    private var mAddK:Bool = System.getBoolProperty("KOverTheta.addK", false);
    private var mAddTheta:Bool = System.getBoolProperty("KOverTheta.addK", false);
    private var mAddFinalValue:Bool = System.getBoolProperty("KOverTheta.addKoTheta", true);
    private var mPrecision:Int = System.getIntProperty("KOverTheta.precision", 3);
    
    /**
     * The decision rule to take. Currently (0) Rosenberg and (1) 4-times-rule are implemented.
     */
    private var mDecisionRule:Int = 0;

    /**
     * The decision threshold to use for the corresponding rule.
     */
    private var mDecisionThreshold:Float = 0;
    
    /**
     * Only monophyletic species
     */
    private var mMonopyhleticOnly:Bool = false;
    
    /**
     * Create a new KOverTheta object.
     */
    public function new() {
    }
    
    /**
     * Set the decision rule.
     */
    public function setDecisionRule(rule:Int):Void {
        if (0 <= rule && rule <= 1) {
            mDecisionRule = rule;
        } else {
            throw "Unknown decision rule " + rule + "!";
        }
    }
    
    /**
     * Set the decision threshold.
     */
    public function setDecisionThreshold(threshold:Float) {
        mDecisionThreshold = threshold;
    }
    
    /**
     * Set whether all delimited species should be monophyletic.
     */
    public function setDelimitedSpeciesMonophyletic(val:Bool):Void {
        mMonopyhleticOnly = val;
    }
    
    /**
     * Calculate K for a particular sets of sequences.
     */
    private function calcK(firstListOfSequenceNames:StringSet, secondListOfSequenceNames:StringSet, distanceMatrix:StringMatrix, sequenceLength:Int):Float {
        var comparisons:Float = 0, diff:Float = 0;
        
        for (name1 in firstListOfSequenceNames) {
            for (name2 in secondListOfSequenceNames) {
                comparisons++;
                diff += distanceMatrix.lookup(name1, name2);
            }
        }
        
        var result:Float = 0;
        if (diff != 0) { result = - (3.0 / 4) * Math.log (1 - 4 * diff / (3.0 * comparisons)); }
        return result;
    }
    
    /**
     * Calculate Theta for a particular set of sequences.
     */
    private function calcTheta(listOfSequenceNames:StringSet, distanceMatrix:StringMatrix, sequenceLength:Int):Float {
        var n:Int = (listOfSequenceNames.size() == 1) ? 2 : listOfSequenceNames.size(); // in case there is only one individual - do as if individual was sampled twice
        
        var count:Int = 0, diff:Float = 0;
        for (name1 in new EnumerateIterator<String>(listOfSequenceNames.iterator())) {
            for (name2 in new EnumerateIterator<String>(listOfSequenceNames.iterator())) {
                if (name1.idx <= name2.idx) {
                    break;
                }
                diff += distanceMatrix.lookup(name1.element, name2.element);
                ++count;
            }
        }
        var pi:Float = (diff == 0 || count == 0) ? 2 / (sequenceLength * n * (n - 1)) : diff / count;
        
        var theta:Float = pi / (1 - 4 * pi / 3);
        return theta;
    }
    
    /**
     * Return if two set of sequences belong to the same species (or not).
     */
    public function belongToSameSpecies(clade:Clade, c1:StringSet, c2:StringSet, distanceMatrix:StringMatrix, sequenceLength:Int):Bool {
        if (clade != null && mAddSets) {
            clade.addOutput(c1.toString() + " <-> " + c2.toString());
        }
        var k:Float = calcK(c1, c2, distanceMatrix, sequenceLength);
        if (clade != null && mAddK) {
            clade.addOutput("k=" + Misc.floatToStringPrecision(k, mPrecision));
        }
        var theta1:Float = calcTheta(c1, distanceMatrix, sequenceLength);
        var theta2:Float = calcTheta(c2, distanceMatrix, sequenceLength);
        if (clade != null && mAddTheta) {
            clade.addOutput("theta1=" + Misc.floatToStringPrecision(theta1, mPrecision) + ", theta2=" + Misc.floatToStringPrecision(theta2, mPrecision));
        }
        
        if (theta1 == -1 || theta2 == -1) {
            return true;
        }
        
        if (mDecisionRule == 0) {
            if (k == 0) {
                return true;
            }
            var n1:Int = c1.size();
            var n2:Int = c2.size();
            var kDivTheta1:Float = k / theta1;
            var kDivTheta2:Float = k / theta2;
            var p:Float = Rosenberg.calcRosenberg(kDivTheta1, kDivTheta2, BigInt.fromInt(n1), BigInt.fromInt(n2));
            if (clade != null && mAddFinalValue) {
                clade.addOutput("p=" + Misc.floatToStringPrecision(p, mPrecision));
            }
            return p <= mDecisionThreshold;
        } else if (mDecisionRule == 1) {
            var theta:Float = (theta1 > theta2) ? theta1 : theta2;
            var ratio:Float = k / theta;
            if (clade != null && mAddFinalValue) {
                clade.addOutput("k/T=" + Misc.floatToStringPrecision(ratio, mPrecision));
            }
            return ratio <= mDecisionThreshold;
        } else {
            throw "Unknown rule " + mDecisionRule + "!";
        }
    }
    
    /**
     * Run the K over Theta algorithm on a particular clade.
     */
    private function runKOverTheta_(clade:Clade, distanceMatrix:StringMatrix, sequenceLength:Int):{ shortest:StringSet, shortestLength:Float, other:List<StringSet> } {
        if (clade.isLeaf()) {
            var name:String = clade.getName();
            var mySet:StringSet = new StringSet();
            mySet.add(name);
            
            var shortest:StringSet = mySet;
            var shortestLength:Float = clade.getDistance();
            var other:List<StringSet> = new List<StringSet>();
            
            return { shortest: shortest, shortestLength: shortestLength, other: other };
        } else {
            // calculate the child clades
            var childCladeResults = new List();
            for (childClade in clade) {
                var childCladeResult = runKOverTheta_(childClade, distanceMatrix, sequenceLength);
                childCladeResults.add(childCladeResult);
            }
            
            // find the two shortest connections
            var firstShortest:StringSet = null;
            var firstShortestLength:Float = 0;
            for (childCladeResult in childCladeResults) {
                if (firstShortest == null) {
                    firstShortest = childCladeResult.shortest;
                    firstShortestLength = childCladeResult.shortestLength;
                } else {
                    if (firstShortestLength > childCladeResult.shortestLength) {
                        firstShortest = childCladeResult.shortest;
                        firstShortestLength = childCladeResult.shortestLength;
                    }
                }
            }
            var secondShortest:StringSet = null;
            var secondShortestLength:Float = 0;
            for (childCladeResult in childCladeResults) {
                if (firstShortest == childCladeResult.shortest) {
                    continue;
                }
                if (secondShortest == null) {
                    secondShortest = childCladeResult.shortest;
                    secondShortestLength = childCladeResult.shortestLength;
                } else {
                    if (secondShortestLength > childCladeResult.shortestLength) {
                        secondShortest = childCladeResult.shortest;
                        secondShortestLength = childCladeResult.shortestLength;
                    }
                }
            }
            
            // compare the two shortest connections
            var same:Bool = belongToSameSpecies(clade, firstShortest, secondShortest, distanceMatrix, sequenceLength);
            
            // calculate the result of this clade
            var shortest:StringSet = null;
            var shortestLength:Float = firstShortestLength + clade.getDistance();
            var other:List<StringSet> = new List<StringSet>();
            if (same) {
                if (mMonopyhleticOnly) {
                    shortest = new StringSet();
                    for (childCladeResult in childCladeResults) {
                        for (s in childCladeResult.shortest) {
                            shortest.add(s);
                        }
                        for (o in childCladeResult.other) {
                            for (e in o) {
                                shortest.add(e);
                            }
                        }
                    }
                } else {
                    shortest = new StringSet();
                    for (childCladeResult in childCladeResults) {
                        for (s in childCladeResult.shortest) {
                            shortest.add(s);
                        }
                        for (o in childCladeResult.other) {
                            other.add(o);
                        }
                    }
                }
            } else {
                shortest = firstShortest;
                for (childCladeResult in childCladeResults) {
                    for (o in childCladeResult.other) {
                        other.add(o);
                    }
                    if (shortest != childCladeResult.shortest) {
                        other.add(childCladeResult.shortest);
                    }
                }
            }
            
            return { shortest: shortest, shortestLength: shortestLength, other: other };
        }
        return null;
    }
    
    /**
     * Run the K over Theta algorithm on a particular clade.
     */
    public function runKOverTheta(clade:Clade, distanceMatrix:StringMatrix, sequenceLength:Int):List<StringSet> {
        var result = runKOverTheta_(clade, distanceMatrix, sequenceLength);
        result.other.add(result.shortest);
        return result.other;
    }
    
    public static function main() {
        var cA:Clade = new Clade("A");
        var cB:Clade = new Clade("B");
        var cC:Clade = new Clade("C");
        var cD:Clade = new Clade("D");
        var cE:Clade = new Clade("E");
        var cF:Clade = new Clade("F");
        var cG:Clade = new Clade("G");
        var c1:Clade = new Clade("C1");
        var c2:Clade = new Clade("C2");
        var c3:Clade = new Clade("C3");
        var c4:Clade = new Clade("C4");
        var c5:Clade = new Clade("C5");
        var c6:Clade = new Clade("C6");
        c1.addChild(cA);
        c1.addChild(cB);
        c2.addChild(cD);
        c2.addChild(cE);
        c3.addChild(cF);
        c3.addChild(cG);
        c4.addChild(c1);
        c4.addChild(cC);
        c5.addChild(c2);
        c5.addChild(c3);
        c6.addChild(c4);
        c6.addChild(c5);
        var parser = new haxelib.bio.parsers.FastaParser();
        var lst = parser.read(">A\nACGTTGACGTACTGCA\n>B\nACGTTGACGTACTGCA\n>C\nACGTTTACGTACTGCA\n>D\nACGTTCCCGTTCTGCA\n>E\nACGTTCCCGTTCTGCA\n>F\nCCGTTCCCGTTCTGGG\n>G\nCCGTTCCCGTTCTGGG\n");
        var analyzer = new haxelib.bio.SequenceListAnalyzer();
        var distanceMatrix:StringMatrix = analyzer.toDistanceMatrixUsingPairwiseComparison(lst);
        var method:KOverTheta = new KOverTheta();
        method.setDecisionRule(1);
        method.setDecisionThreshold(4);
        var result:List<StringSet> = method.runKOverTheta(c6, distanceMatrix, 20);
        for (obj in result) {
            trace(obj.toString());
        }
    }
}