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
package haxelib.math;

/**
 * A fractional number.
 *
 * @author Yann Spoeri
 */
class Combinatorics
{
    /**
     * Calculate the factorial of a number.
     *
     * @param a The numer to calculate the factorial for.
     * @return The factorial of this number.
     */
    public static inline function factorial(a:BigInt):BigInt {
        var nr:BigInt = BigInt.fromInt(2);
        var result:BigInt = BigInt.fromInt(1);
        while (nr <= a) {
            result *= nr;
            ++nr;
        }
        return result;
    }

    /**
     * Calculate n over k (binomial coefficient).
     *
     * @param n The
     * @param k The
     * @return The binomial coefficient of the two numbers.
     */
    public static inline function comb(n:BigInt, k:BigInt):BigInt {
        if (k > n) {
            return 0;
        }
        if (k == 0 || n == k) {
            return 1;
        }
        if (k > n / 2) {
            k = n - k;
        }
        var last:BigInt = BigInt.fromInt(1);
        var result:BigInt = BigInt.fromInt(1);
        var i:BigInt = BigInt.fromInt(0);
        while (i < k) {
            last = result;
            result = last * (n - i) / (i + 1);
            i++;
        }
        return result;
//        C[0] = 1
//for (int k = 0; k < n; ++ k)
//    C[k+1] = (C[k] * (n-k)) / (k+1)
    }

    public static function main() {
        /*
        trace(factorial(BigInt.fromString("1")));
        trace(factorial(BigInt.fromString("2")));
        trace(factorial(BigInt.fromString("3")));
        trace(factorial(BigInt.fromString("4")));
        trace(factorial(BigInt.fromString("5")));
        trace(factorial(BigInt.fromString("6")));
        */
        trace("XXX");
        trace("" + comb(0, 0));
        trace("" + comb(1, 0) + " " + comb(1, 1));
        trace("" + comb(2, 0) + " " + comb(2, 1) + " " + comb(2, 2));
        trace("" + comb(3, 0) + " " + comb(3, 1) + " " + comb(3, 2) + " " + comb(3, 3));
        trace("" + comb(4, 0) + " " + comb(4, 1) + " " + comb(4, 2) + " " + comb(4, 3) + " " + comb(4, 4));
        trace("" + comb(5, 0) + " " + comb(5, 1) + " " + comb(5, 2) + " " + comb(5, 3) + " " + comb(5, 4) + " " + comb(5, 5));
        trace("" + comb(6, 0) + " " + comb(6, 1) + " " + comb(6, 2) + " " + comb(6, 3) + " " + comb(6, 4) + " " + comb(6, 5) + " " + comb(6, 6));
    }
}