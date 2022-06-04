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

import haxelib.math.Combinatorics;
import haxelib.math.Fractional;

/**
 * Rosenberg.
 *
 * @author Yann Spoeri
 */
class Rosenberg
{
    @:final
    private static var precision:Float = 0.000001;
    @:final
    private static var precision2:Int = 1000000;
    @:final
    private static var minCounter:Int = 10;
    @:final
    private static var stopWith0:Float = -100.0;

    public static inline function exp(f:Float):Float {
        // e ^-100 is already a number X...E-44
        if (f <= stopWith0) {
            return 0.0;
        }
        return Math.exp(f);
    }

    public static inline function sign(s:BigInt) {
        return (s % 2 == 0) ? 1 : -1;
    }

    public static inline function calcGTerm(k:BigInt, j:BigInt, TD2:Float, downTerm1:BigInt, kmj:BigInt):Float {
        var k_:BigInt = k - 1;
        var expTerm:Float = exp((-k * k_).toInt() * TD2);
        var upperTerm1:BigInt = ((k << 1) - 1);
        var upperTerm2:BigInt = sign(kmj);
        var upperTerm3:BigInt = Combinatorics.multUp(j, k_);
        var downTerm2:BigInt = Combinatorics.factorial(kmj);
        var term1:Fractional = new Fractional(upperTerm1 * upperTerm2, downTerm1);
        term1.reduce();
        var term2:Fractional = new Fractional(upperTerm3, downTerm2);
        term2.reduce();
        var term:Fractional = term1 * term2;
        var termAsFloat:Float = term.toFloat(precision2);
        var result:Float = expTerm * termAsFloat;
        return result;
    }

    public static inline function calcG(j:BigInt, TD2:Float):Float {
        var downTerm1:BigInt = Combinatorics.factorial(j);
        var k:BigInt = j + BigInt.fromInt(0);
        var kmj:BigInt = BigInt.fromInt(0);
        var term:Float = calcGTerm(k, j, TD2, downTerm1, kmj);
        var summe:Float = term;
        while (Math.abs(term) > precision || k < minCounter) {
            k++;
            kmj++;
            term = calcGTerm(k, j, TD2, downTerm1, kmj);
            summe += term;
        }
        return summe;
    }

    public static inline function calcS(l2:BigInt, l1:BigInt, j:BigInt):Float {
        var comb1:BigInt = Combinatorics.comb(l1, l2);
        if (comb1 == BigInt.fromInt(0)) {
            return 0.0;
        }
        var comb2:BigInt = Combinatorics.comb(j, l2);
        if (comb2 == BigInt.fromInt(0)) {
            return 0.0;
        }
        var comb3:BigInt = Combinatorics.comb(j + l1, j);
        if (comb3 == BigInt.fromInt(0)) {
            return 0.0;
        }
        var term1:Fractional = new Fractional(comb1, comb3);
        term1.reduce();
        var term2:Fractional = new Fractional(comb2, l1);
        term2.reduce();
        var term3:Fractional = new Fractional(l2 * (j + l1), j);
        term3.reduce();
        var result:Fractional = term1 * term2 * term3;
        var resultAsFloat:Float = result.toFloat(precision2);
        return resultAsFloat;
    }

    public static inline function calcRosenberg3(ma:BigInt, mb:BigInt, taD2:Float, tbD2:Float, ra:BigInt, rb:BigInt, g_mata:Float, k_mamb:BigInt, g_mbtb:Float):Float {
        var summe:Float = 0.0;
        var qa:BigInt = BigInt.fromInt(1);
        while(qa <= ma) {
            var s_qamara:Float = calcS(qa, ma, ra);
            if (s_qamara != 0) {
                var qb:BigInt = BigInt.fromInt(1);
                while(qb <= mb) {
                    var s_qbmbrb:Float = calcS(qb, mb, rb);
                    if (s_qbmbrb != 0) {
                        var k_qaqb:BigInt = Combinatorics.comb(qa + qb, qa) * (qa + qb - 1);
                        if (k_qaqb != 0) {
                            summe += g_mata * s_qamara * g_mbtb * s_qbmbrb * new Fractional(k_qaqb, k_mamb).toFloat(precision2);
                        }
                    }
                    qb = qb + 1;
                }
            }
            qa = qa + 1;
        }
        return summe;
    }

    public static inline function calcRosenberg2(ma:BigInt, taD2:Float, tbD2:Float, ra:BigInt, rb:BigInt, g_mata:Float):Float {
        var mb:BigInt = BigInt.fromInt(1);
        var summe:Float = 0.0;
        var term:Float = 1;
        while (term > precision || mb < minCounter) {
            var k_mamb:BigInt = Combinatorics.comb(ma + mb, ma) * (ma + mb - 1);
            if (k_mamb != 0) {
                var g_mbtb:Float = calcG(mb, tbD2);
                if (g_mbtb == 0) {
                    term = 0;
                } else {
                    term = calcRosenberg3(ma, mb, taD2, tbD2, ra, rb, g_mata, k_mamb, g_mbtb);
                    summe += term;
                }
            }
            mb = mb + 1;
        }
        return summe;
    }

    public static function calcRosenberg(ta:Float, tb:Float, ra:BigInt, rb:BigInt):Float {
        var taD2 = ta / 2;
        var tbD2 = tb / 2;
        var ma:BigInt = BigInt.fromInt(1);
        var summe:Float = 0.0;
        var term:Float = 1;
        while (term > precision || ma < minCounter) {
            var g_mata:Float = calcG(ma, taD2);
            if (g_mata == 0) {
                term = 0;
            } else {
                term = calcRosenberg2(ma, taD2, tbD2, ra, rb, g_mata);
                summe += term;
            }
            ma = ma + 1;
        }
        return summe;
    }

    public static function main() {
        var start = Date.now().getTime();
        trace(calcRosenberg(14.3, 2.814, BigInt.fromInt(5), BigInt.fromInt(10))); // 0.97806358086
                                                                                  // 0.978063412488675
        var end1 = Date.now().getTime();
        trace("diff " + (end1 - start));
        trace(calcRosenberg(12.0, 14.0, BigInt.fromInt(3), BigInt.fromInt(2))); // 0.999992747089
                                                                                // 0.9999927470844874
        var end2 = Date.now().getTime();
        trace("diff " + (end2 - end1));
        trace(calcRosenberg(3.0, 2.0, BigInt.fromInt(3), BigInt.fromInt(2))); // 0.778611485998
                                                                              // 0.7786111883017944
        var end3 = Date.now().getTime();
        trace("diff " + (end3 - end2));
        trace(calcRosenberg(2.3, 2.814, BigInt.fromInt(50), BigInt.fromInt(30))); // 0.9841989649613306
                                                                                  // 0.9841986298869676
        var end4 = Date.now().getTime();
        trace("diff " + (end4 - end3));
    }
}
