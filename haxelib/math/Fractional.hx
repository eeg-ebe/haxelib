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
abstract Fractional(Array<BigInt>) to Array<BigInt>
{
    /**
     * Create a new fractional.
     */
    public inline function new(numerator:BigInt, divisor:BigInt) {
        this = new Array<BigInt>();
        this.push(numerator);
        this.push(divisor);
    }

    /**
     * Create a fractional via two integers.
     */
    public inline static function byInts(a:Int, b:Int):Fractional {
        var ap:BigInt = BigInt.fromInt(a);
        var bp:BigInt = BigInt.fromInt(b);
        return new Fractional(ap, bp);
    }

    /**
     * Create a fractional via two strings.
     */
    public inline static function byString(a:String, b:String):Fractional {
        var ap:BigInt = BigInt.fromString(a);
        var bp:BigInt = BigInt.fromString(b);
        return new Fractional(ap, bp);
    }

    /**
     * Get the numerator of this fractional.
     *
     * @return The numerator of this fractional.
     */
    public inline function getNumerator():BigInt {
        return this[0];
    }

    /**
     * Get the divisor of this fractional.
     *
     * @return The divisor of this fractional.
     */
    public inline function getDivisor():BigInt {
        return this[1];
    }

    /**
     * Reduce this fractional.
     */
    public inline function reduce():Void {
        var gcd:BigInt = gcd(this[0], this[1]);
        this[0] = this[0] / gcd;
        this[1] = this[1] / gcd;
    }

    /**
     * Convert this Fractional into a float number.
     */
    public inline function toFloat(precision:Int):Float {
        var d = BigInt.divMod(this[0], this[1]);
        return (d.quotient.toInt() + 0.0) + (d.remainder * precision / this[1]).toInt() / precision;
    }

    /**
     * Return a string representation of this fractional.
     *
     * @return A string representation of this fractional.
     */
    public inline function toString():String {
        return Std.string(this[0]) + "/" + Std.string(this[1]);
    }

    /**
     * Helper method to cacluate the gcd (greatest common divisor) of two numbers.
     *
     * @param a The first number.
     * @param b The second number.
     * @return The gcd of the two numbers.
     */
    public inline static function gcd(a:BigInt, b:BigInt):BigInt {
        if (a == 0) {
            return b;
        }
        return gcd(b % a, a);
    }

    /**
     * Add two fractional numbers.
     *
     * @param a The first fractional number.
     * @param b The second fractional number.
     * @return The fractional number.
     */
    @:op(A+B)
    public inline static function add(a:Fractional, b:Fractional):Fractional {
        var n1:BigInt = a[0];
        var m1:BigInt = a[1];
        var n2:BigInt = b[0];
        var m2:BigInt = b[1];
        var downGcd:BigInt = gcd(m1, m2);
        return new Fractional(n1 * downGcd + n2 * downGcd, downGcd);
    }

    /**
     * Substract two fractional numbers.
     *
     * @param a The first fractional number.
     * @param b The second fractional number.
     * @return The fractional number.
     */
    @:op(A-B)
    public inline static function sub(a:Fractional, b:Fractional):Fractional {
        var n1:BigInt = a[0];
        var m1:BigInt = a[1];
        var n2:BigInt = b[0];
        var m2:BigInt = b[1];
        var downGcd:BigInt = gcd(m1, m2);
        return new Fractional(n1 * downGcd - n2 * downGcd, downGcd);
    }

    /**
     * Multiply two fractional numbers.
     *
     * @param a The first fractional number.
     * @param b The second fractional number.
     * @return The fractional number.
     */
    @:op(A*B)
    public inline static function mult(a:Fractional, b:Fractional):Fractional {
        var n1:BigInt = a[0];
        var m1:BigInt = a[1];
        var n2:BigInt = b[0];
        var m2:BigInt = b[1];
        return new Fractional(n1 * n2, m1 * m2);
    }

    /**
     * Divide two fractional numbers.
     *
     * @param a The first fractional number.
     * @param b The second fractional number.
     * @return The fractional number.
     */
    @:op(A/B)
    public inline static function div(a:Fractional, b:Fractional):Fractional {
        var n1:BigInt = a[0];
        var m1:BigInt = a[1];
        var n2:BigInt = b[0];
        var m2:BigInt = b[1];
        return new Fractional(n1 * m2, n2 * m1);
    }
}
