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
package haxelib.bio.evolution;

/**
 * Rosenberg.
 *
 * @author Yann Spoeri
 */
class Newick
{
    /*
    Tree -> SubTree ";"
    SubTree -> Leaf | Internal
    Leaf -> Name
    Internal -> "(" BranchSet ")" Name
    BranchSet -> Branch | Branch "," BranchSet
    Branch -> SubTree length
    Name -> empty | string
    Length -> empty | ":" number
    */

    private static function parse_(s:String, begin:Int, stop:Int):Clade {
        if (begin >= stop) {
            // empty name
            var result:Clade = new Clade("", -1);
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
            return parse_(s, begin, stop);
        }
        // braces
        if (s.charAt(begin) == "(") {
            var subChilds:List<IClade> = new List<IClade>();
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
                    subChilds.add(parse_(s, lastBegin, i));
                    lastBegin = i + 1;
                }
                if (braceCounter == 0) {
                    braceStop = i;
                    break;
                }
            }
            subChilds.add(parse_(s, lastBegin, braceStop));
            var result:Clade = parse_(s, braceStop + 1, stop);
            for (child in subChilds) {
                result.addChild(child);
            }
            return result;
        }
        // parse rest/name
        var result:Clade = new Clade(null);
        var partsString:String = s.substring(begin, stop);
        var parts:Array<String> = partsString.split(":");
        if (parts.length >= 1) {
            var name:String = StringTools.trim(parts[0]);
            result.setName(name);
        }
        if (parts.length >= 2) {
            var f:Float = Std.parseFloat(StringTools.trim(parts[1]));
            result.setDistance(f);
        }
        if (parts.length >= 3) {
            var f:Float = Std.parseFloat(StringTools.trim(parts[1]));
            result.setDistance(f);
        }
        return result;
    }

    public static function parse(s:String):Clade {
        if (s == null) {
            throw "String to parse must not be null!";
        }
        if (s == "") {
            var result:Clade = new Clade("", -1);
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
                return parse_(s, 0, i);
            }
        }
        return parse_(s, 0, s.length);
    }

    public static function main() {
        var result:IClade = parse("(B:0.2,(C:0.3,D:0.4)E:0.5,(G,H))F:0.1:0.3:1;");
        trace("\n" + print(result));
    }
    public static function print(clade:IClade, ?indents:Int=0):String {
        var result:List<String> = new List<String>();
        for (i in 0...indents) {
            result.add(" ");
        }
//        result.add("+ " + clade.getName() + " (" + clade.getDistance() + ";" + clade.getBootstrap() + ";" + clade.getProbability() +  ")\n");
        var childs:List<IClade> = clade.getChilds();
        if (childs != null) {
            for (child in childs) {
                if (child != null) {
                    result.add(print(child, indents + 2));
                }
            }
        }
        return result.join("");
    }
}