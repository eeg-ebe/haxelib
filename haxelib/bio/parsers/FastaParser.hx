/**
 * Copyright (c) 2022 Université libre de Bruxelles, eeg-ebe Department, Yann Spöri
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

import haxelib.bio.Sequence;

/**
 * A parser for FASTA files.
 *
 * @author Yann Spoeri
 */
class FastaParser
{
    /**
     * Create a new FastaParser.
     */
    public function new() {
    }
    
    public function read(fileContent:String):List<Sequence> {
        var result:List<Sequence> = new List<Sequence>();
        var lines:Array<String> = fileContent.split("\n");
        var name:Null<String> = null, seq:Null<String> = null;
        for (line in lines) {
            line = StringTools.trim(line);
            if (line == "" || line.charAt(0) == ";" || line.charAt(0) == "#") {
                continue;
            }
            if (line.charAt(0) == ">") {
                if (name != null) {
                    var s:Sequence = new Sequence(name, seq);
                    result.add(s);
                }
                name = StringTools.trim(line.substr(1));
                seq = "";
            } else {
                seq = seq.toUpperCase() + line;
            }
        }
        if (name != null) {
            var s:Sequence = new Sequence(name, seq);
            result.add(s);
        }
        return result;
    }
    
    public static function main() {
        var parser:FastaParser = new FastaParser();
        var result = parser.read(">A\nACTGCAGTACTG\n>B\nZVHAZHAVZHAVHZ");
        trace(result);
    }
}