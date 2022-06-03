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
    private static function read_(s:String, begin:Int, stop:Int):NewickClade {
        if (begin >= stop) {
            // empty name
            var result:NewickClade = new NewickClade("", "");
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
            var subChilds:List<NewickClade> = new List<NewickClade>();
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
                    var subClade:NewickClade = read_(s, lastBegin, i);
                    subChilds.add(subClade);
                    lastBegin = i + 1;
                }
                if (braceCounter == 0) {
                    braceStop = i;
                    break;
                }
            }
            var lastSubClade:NewickClade = read_(s, lastBegin, braceStop);
            subChilds.add(lastSubClade);
            var result:NewickClade = read_(s, braceStop + 1, stop);
            if (result.subClades == null) {
                result.subClades = new List<NewickClade>();
            }
            for (child in subChilds) {
                result.subClades.add(child);
            }
            return result;
        }
        // parse rest/name
        var partsString:String = s.substring(begin, stop);
        var part1Idx:Int = partsString.indexOf(":");
        var name:String = (part1Idx == -1) ? partsString : partsString.substring(0, part1Idx);
        var extra:String = (part1Idx == -1) ? null : partsString.substring(part1Idx + 1);
        var result:NewickClade = new NewickClade(name, extra);
        return result;
    }
    
    /**
     * Read a Newick string.
     */
    public function read(s:String):NewickClade {
        if (s == null) {
            throw "String to parse must not be null!";
        }
        if (s == "") {
            var result:NewickClade = new NewickClade("", "");
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
        var tree:NewickClade = parser.read("(B:0.2,(C:0.3,D:0.4)E:0.5,(G,H))F:0.1:0.3:1;");
        var treeAsString:String = tree.toString();
        trace(treeAsString);
    }
}
