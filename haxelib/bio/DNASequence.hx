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
package haxelib.bio;

/**
 * A DNA Sequence.
 *
 * @author Yann Spöri
 */
class DNASequence extends Sequence
{
    @:final
    public static var ALLOWED_DNA_CHARACTERS = [
        "A" => "A", "C" => "C", "G" => "G",
        "T" => "T", "R" => "R", "Y" => "Y",
        "S" => "S", "W" => "W", "K" => "K",
        "M" => "M", "B" => "B", "D" => "D",
        "H" => "H", "V" => "V", "N" => "N",
        "." => "-", "-" => "-", "?" => "?"
    ];

    public inline override function setSequence(seq:String):Void {
        if (seq == null) {
            throw "Sequence must not be null!";
        }
        seq = seq.toUpperCase();
        var mySeq:Array<String> = new Array<String>();
        for (i in 0...seq.length) {
            var chr:String = seq.charAt(i);
            if (! ALLOWED_DNA_CHARACTERS.exists(chr)) {
                throw "Illegal character " + chr + " at position " + (i + 1) + " in DNASequence " + seq + "!";
            }
            var r:String = ALLOWED_DNA_CHARACTERS.get(chr);
            mySeq.push(r);
        }
        mSequence = mySeq.join("");
    }

    public static function main() {
        var s:Sequence = new DNASequence("mySeq", "ACTA.GCGTACTACgg");
        trace(s.getName());
        trace(s.getSequence());
        trace(s.length());
        trace(s.charAt(3));
        trace(s.toString());
        for (c in s) {
            trace(c);
        }
    }
}