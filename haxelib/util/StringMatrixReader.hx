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
package haxelib.util;

import haxe.ds.Vector;

/**
 * Reader to read in tab delimited matrices into a StringMatrix.
 *
 * @author Yann Spoeri
 */
class StringMatrixReader
{
    public static function readMatrix(fileContent:String):StringMatrix {
        var lines:Array<String> = fileContent.split("\n");
        var linesStripped:Vector<String> = new Vector<String>(lines.length);
        var i:Int = 0;
        for (line in lines) {
            var sLine:String = StringTools.trim(line);
            linesStripped[i] = sLine;
            i++;
        }
        var names:Array<String> = linesStripped[0].split("\t");
        var namesSize:Int = names.length;
        var namesV:Vector<String> = new Vector(namesSize);
        var i:Int = 0;
        for (name in names) {
            var nameStripped:String = StringTools.trim(name);
            namesV[i] = nameStripped;
            i++;
        }
        var result:StringMatrix = new StringMatrix(namesV);
        for (i in 1...linesStripped.length) {
            var currentLine:String = linesStripped[i];
            var currentVals:Array<String> = currentLine.split("\t");
            var name1:String = StringTools.trim(currentVals[0]);
            for (j in 1...currentVals.length) {
                var name2:String = namesV[j-1];
                var valueStr:String = currentVals[j];
                var value:Float = Std.parseFloat(valueStr);
                //trace(name1 + " " + name2 + " " + value);
                result.set(name2, name1, value);
            }
        }
        return result;
    }
    
    public static function main() {
        var m:StringMatrix = readMatrix("\tA\tB\nA\t0\t1\nB\t2\t3");
        trace(m.toString());
    }
}