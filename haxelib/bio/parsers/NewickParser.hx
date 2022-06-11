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
package haxelib.bio.parsers;

import haxelib.bio.phylo.Clade;

/**
 * A parser for the newick format.
 * See https://evolution.genetics.washington.edu/phylip/newick_doc.html for more
 * information.
 *
 * @author Yann Spoeri
 */
class NewickParser
{
    /**
     * Create a new NewickParser.
     */
    public function new() {
    }
    
    /**
     * Read a Newick string.
     */
    private static function read_(s:String, begin:Int, stop:Int):Clade {
        if (begin >= stop) {
            // empty name
            var result:Clade = new Clade();
            return result;
        }
        // spaces handling
        if ((s.charAt(begin) == " ") || (stop >= 1 && s.charAt(stop - 1) == " ")) {
            while (begin < s.length && s.charAt(begin) == " ") {
                begin++;
            }
            while (stop >= 1 && s.charAt(stop - 1) == " ") {
                stop--;
            }
            return read_(s, begin, stop);
        }
        // braces
        if (s.charAt(begin) == "(") {
            var subChilds:List<Clade> = new List<Clade>();
            var braceCounter:Int = 0;
            var braceStop:Int = stop;
            var lastBegin = begin + 1;
            for (i in begin...stop) {
                var ch:String = s.charAt(i);
                if (ch == "(") {
                    braceCounter++;
                } else if (ch == ")"){
                    braceCounter--;
                }
                if (ch == "," && braceCounter == 1) {
                    var subClade:Clade = read_(s, lastBegin, i);
                    subChilds.add(subClade);
                    lastBegin = i + 1;
                }
                if (braceCounter == 0) {
                    braceStop = i;
                    break;
                }
            }
            var lastSubClade:Clade = read_(s, lastBegin, braceStop);
            subChilds.add(lastSubClade);
            var result:Clade = read_(s, braceStop + 1, stop);
            for (child in subChilds) {
                result.addChild(child);
            }
            return result;
        }
        // parse rest/name
        var partsString:String = s.substring(begin, stop);
        var result:Clade = createCladeByStr(partsString);
        return result;
    }
    
    /**
     * Create a clade object by a string.
     */
    private static function createCladeByStr(s:String):Clade {
        // most easy case, no ":" given => only name
        if (s.indexOf(":") == -1) {
            return new Clade(s);
        }
        // split by ":"
        var arr:Array<String> = s.split(":");
        if (arr.length != 2) {
            throw "Unknown Newick format. More than one ':' given in string '" + s + "'";
        }
        var first:String = arr[0];
        var second:String = arr[1];
        // check if first can be interpreted as bootstrap value (.DND Clustal newick format)
        var firstAsFloat:Float = Std.parseFloat(first);
        var secondAsFloat:Float = Std.parseFloat(second);
        if (!Math.isNaN(firstAsFloat) && 0.0 <= firstAsFloat && firstAsFloat <= 100.0 && !Math.isNaN(secondAsFloat) && 0 <= secondAsFloat) {
            // .DND Clustal newick format. Bootstrap values will be written instead of name
            return new Clade("", secondAsFloat, firstAsFloat / 100);
        }
        if (second.indexOf("[") != -1 && StringTools.endsWith(second, "]")) {
            // .PHB Clustal newick format
            var parts:Array<String> = second.split("[");
            var distance:Float = Std.parseFloat(parts[0]);
            var bootstrap:Float = Std.parseFloat(parts[1].substring(0, parts[1].length - 1));
            if (!Math.isNaN(distance) && !Math.isNaN(bootstrap) && 0 <= distance && 0.0 <= bootstrap && bootstrap <= 100.0) {
                return new Clade(first, distance, bootstrap / 100);
            }
        }
        if (!Math.isNaN(secondAsFloat) && 0 <= secondAsFloat) {
            return new Clade(first, secondAsFloat);
        }
        throw "Unknown newick format! Unable to interprete '" + s + "'!";
    }
    
    /**
     * Read a Newick string.
     */
    public function read(s:String):Clade {
        if (s == null) {
            throw "String to parse must not be null!";
        }
        if (s == "") {
            var result:Clade = new Clade();
            return result;
        }
        var braceCounter:Int = 0;
        for (i in 0...s.length) {
            var ch:String = s.charAt(i);
            if (ch == "(") {
                braceCounter++;
            } else if (ch == ")"){
                braceCounter--;
            }
            if (braceCounter == 0 && ch == ";") {
                return read_(s, 0, i);
            }
        }
        return read_(s, 0, s.length);
    }
    
    public static function main() {
        var parser:NewickParser = new NewickParser();
        var tree:Clade = parser.read("(B:0.2,(C:0.3,D:0.4)E:0.5,(G,H))F:0.1:0.3:1;");
        var treeAsString:String = tree.toNewickString();
        trace(treeAsString);
    }
}
