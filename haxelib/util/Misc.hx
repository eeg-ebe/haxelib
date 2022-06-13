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
package haxelib.util;

/**
 * Collection of misc functions.
 *
 * @author Yann Spoeri
 */
class Misc
{
    // tks to https://stackoverflow.com/questions/23689001/how-to-reliably-format-a-floating-point-number-to-a-specified-number-of-decimal
    public static function floatToStringPrecision(n:Float, prec:Int) {
        if (Math.isNaN(n)) {
            return "NaN";
        } else if (n == Math.POSITIVE_INFINITY) {
            return "inf";
        } else if (n == Math.NEGATIVE_INFINITY) {
            return "inf";
        }
        n = Math.round(n * Math.pow(10, prec));
        var str:String = '' + n;
        var len:Int = str.length;
        if (len <= prec) {
            while (len < prec) {
                str = '0' + str;
                len++;
            }
            return '0.' + str;
        } else {
            return str.substr(0, str.length-prec) + '.' + str.substr(str.length-prec);
        }
    }
}