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
package haxelib.bio;

import haxe.ds.IntMap;
import haxe.ds.StringMap;
import haxe.ds.Vector;
import haxelib.util.StringMatrix;

/**
 * A dataset for multiple sequences.
 *
 * @author Yann Spoeri
 */
class SequenceListAnalyzer
{
    public function new() {
    }
    
    public inline function isATCG(c:String) {
        return c == "A" || c == "T" || c == "C" || c == "G";
    }
    
    public function toDistanceMatrixUsingPairwiseComparison(lst:List<Sequence>):StringMatrix {
        var names:Vector<String> = new Vector<String>(lst.length);
        var i:Int = 0;
        for (seq in lst) {
            names[i++] = seq.getName();
        }
        var matrix:StringMatrix = new StringMatrix(names);
        var i:Int = 0;
        for (seq1 in lst) {
            var j:Int = 0;
            var seqName1:String = seq1.getName();
            for (seq2 in lst) {
                if (j > i) {
                    break;
                }
                var seqName2:String = seq2.getName();
                if (i == j) {
                    matrix.set(seqName1, seqName2, 0.0);
                } else {
                    var diff:Int = 0;
                    var count:Int = 0;
                    var l1:Int = seq1.length();
                    var l2:Int = seq2.length();
                    var len:Int = (l1 > l2) ? l2 : l1;
                    for (i in 0...len) {
                        var c1:String = seq1.charAt(i);
                        var c2:String = seq2.charAt(i);
                        if (isATCG(c1) && isATCG(c2)) {
                            if (c1 != c2) {
                                diff++;
                            }
                            count++;
                        }
                    }
                    var val:Float = (count == 0) ? 1.0 : diff / count;
                    matrix.set(seqName1, seqName2, val);
                    matrix.set(seqName2, seqName1, val);
                }
                j++;
            }
            i++;
        }
        return matrix;
    }
    
    public function toDistanceMatrixUsingGlobalDeletion(lst:List<Sequence>):StringMatrix {
        var listAllowed:List<String> = new List<String>();
        listAllowed.add("A");
        listAllowed.add("C");
        listAllowed.add("T");
        listAllowed.add("G");
        var lCopy:List<Sequence> = escapePositionsInSequencesExcept(lst, listAllowed);
        return toDistanceMatrixUsingPairwiseComparison(lCopy);
    }
    
    public function containsASequenceWithAnEmptyName(lst:List<Sequence>):Bool {
        for (s in lst) {
            var name:String = StringTools.trim(s.getName());
            if (name == null || name == "") {
                return true;
            }
        }
        return false;
    }
    
    public function checkAllSequencesSameLength(lst:List<Sequence>):Sequence {
        var seqLength:Int = -1;
        for (s in lst) {
            if (seqLength == -1) {
                seqLength = s.length();
            } else {
                if (s.length() != seqLength) {
                    return s;
                }
            }
        }
        return null;
    }
    
    public function toDNASequences(lst:List<Sequence>):List<DNASequence> {
        var result:List<DNASequence> = new List<DNASequence>();
        for (e in lst) {
            var eC:DNASequence = new DNASequence(e.getName(), e.getSequence());
            result.add(eC);
        }
        return result;
    }
    
    public function checkCharsInSequences(lst:List<Sequence>, allowedChars:Array<String>):{s:Sequence, l:List<Int>} {
        var unallowed:List<Int> = new List<Int>();
        for (e in lst) {
            var i:Int = 0;
            for (char in e) {
                var allowed:Bool = false;
                for (c in allowedChars) {
                    if (char == c) {
                        allowed = true;
                        break;
                    }
                }
                if (! allowed) {
                    unallowed.add(i);
                }
                ++i;
            }
            if (! unallowed.isEmpty()) {
                return {
                    s: e,
                    l: unallowed
                };
            }
        }
        return null;
    }
    
    public function escapePositionsInSequencesExcept(lst:List<Sequence>, allowedChars:List<String>):List<Sequence> {
        var result:List<Sequence> = new List<Sequence>();
        var positionsToEscape:IntMap<Bool> = new IntMap<Bool>(); // An IntSet would be better, but does not (yet?) exist ;)
        for (e in lst) {
            var i:Int = 0;
            for (char in e) {
                var allowed:Bool = false;
                for (c in allowedChars) {
                    if (char == c) {
                        allowed = true;
                        break;
                    }
                }
                if (! allowed) {
                    positionsToEscape.set(i, true);
                }
                ++i;
            }
        }
        for (e in lst) {
            var copySeq:Array<String> = new Array<String>();
            var i:Int = 0;
            for (char in e) {
                if (! positionsToEscape.exists(i)) {
                    copySeq.push(char);
                }
                ++i;
            }
            var seq:Sequence = new Sequence(e.getName(), copySeq.join(""));
            result.add(seq);
        }
        return result;
    }
    
    public function getDuplicatedNamesInDataSet(lst:List<Sequence>):List<String> {
        var result:List<String> = new List<String>();
        var cache:StringMap<Int> = new StringMap<Int>();
        for (e in lst) {
            var name:String = e.getName();
            var count:Int = (cache.exists(name)) ? cache.get(name) : 0;
            ++count;
            cache.set(name, count);
            if (count == 2) {
                result.add(name);
            }
        }
        return result;
    }
    
    public function combineDuplicatedSequencesInDataSet(lst:List<Sequence>):StringMap<List<Sequence>> {
        var result:StringMap<List<Sequence>> = new StringMap<List<Sequence>>();
        for (e in lst) {
            var seq:String = e.getSequence();
            if (result.exists(seq)) {
                result.get(seq).add(e);
            } else {
                var l:List<Sequence> = new List<Sequence>();
                l.add(e);
                result.set(seq, l);
            }
        }
        return result;
    }
    
    public static function main() {
        var analyzer:SequenceListAnalyzer = new SequenceListAnalyzer();
        var s1:Sequence = new Sequence("A", "A-AAAAAAAAAAAAAAAA");
        var s2:Sequence = new Sequence("B", "AAAAAAAAAAAAAAAAAT");
        var s3:Sequence = new Sequence("C", "AT-GGTA--ACTGC-CTA");
        var s4:Sequence = new Sequence("D", "AT-GGTA--ACTGC-CTA");
        var l:List<Sequence> = new List<Sequence>();
        l.add(s1);
        l.add(s2);
        l.add(s3);
        l.add(s4);
        var m:StringMatrix = analyzer.toDistanceMatrixUsingPairwiseComparison(l);
        trace(m.toString());
        var m:StringMatrix = analyzer.toDistanceMatrixUsingGlobalDeletion(l);
        trace(m.toString());
        /*
        var allowedChar:List<String> = new List<String>();
        allowedChar.add("A");
        allowedChar.add("C");
        allowedChar.add("T");
        allowedChar.add("G");
        var lc:List<Sequence> = analyzer.escapePositionsInSequencesExcept(l, allowedChar);
        for (e in lc) {
            trace(e.toString());
        }
        trace("===");
        var ln:List<String> = analyzer.getDuplicatedNamesInDataSet(l);
        for (e in ln) {
            trace(e);
        }
        var r = analyzer.combineDuplicatedSequencesInDataSet(l);
        for (e in r) {
            trace(e);
        }
        */
    }
}
