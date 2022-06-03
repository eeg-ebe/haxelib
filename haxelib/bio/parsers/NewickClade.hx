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
 * A Newick clade.
 *
 * @author Yann Spoeri
 */
class NewickClade
{
    /**
     * The name of this clade.
     */
    public var name:String;
    
    /**
     * The extra information connected to this clade.
     */
    public var extraInformation:String;
    
    /**
     * The subClades of this clade.
     */
    public var subClades:List<NewickClade> = new List<NewickClade>();
    
    /**
     * Create a new NewickClade.
     */
    public function new(?myName:String, ?myExtraInformation:String, ?mySubClades:List<NewickClade>) {
        name = myName;
        extraInformation = myExtraInformation;
        if (mySubClades != null) {
            subClades = mySubClades;
        }
    }
    
    /**
     * Create a textual representation of this clade.
     */
    public function toString():String {
        var result:List<String> = new List<String>();
        if (subClades != null && !subClades.isEmpty()) {
            result.add("(");
            var subCladeString:List<String> = new List<String>();
            for (subClade in subClades) {
                var s:String = subClade.toString();
                subCladeString.add(s);
            }
            var s:String = subCladeString.join(",");
            result.add(s);
            result.add(")");
        }
        if (name != null && name != "") {
            result.add(name);
        }
        if (extraInformation != null && extraInformation != "") {
            result.add(":");
            result.add(extraInformation);
        }
        return result.join("");
    }
    
    public static function main() {
        var n1 = new NewickClade("A", "0.7:0.3");
        var n2 = new NewickClade("B", "0.9:0.4");
        var n3 = new NewickClade("C", "0.8:0.1");
        n1.subClades.add(n2);
        n1.subClades.add(n3);
        trace(n1.toString());
    }
}
