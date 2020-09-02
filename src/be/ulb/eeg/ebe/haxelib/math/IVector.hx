/**
 * Copyright (c) 2020 Université libre de Bruxelles, eeg-ebe Department, Yann Spöri
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
package be.ulb.eeg.ebe.haxelib.math;

/**
 * An Interface describing a vector.
 *
 * @author Yann Spöri
 */
interface IVector
{
    /**
     * Get the dimension of this vector.
     *
     * @return The dimension of this vector.
     */
    public function getDimension():Int;

    /**
     * Get the value of the i-th dimension of this vector.
     *
     * @return The value fo the i-th dimension of this vector.
     */
    public function get(i:Int):Float;

    /**
     * Check whether this is a null vector.
     *
     * @return true if this is a null vector and false otherwise.
     */
    public function isNullVector():Bool;

    /**
     * Calculate the lenght of this vector.
     */
    public function length():Float;

    /**
     * Normalize this vector. Before calling this function
     * check whether the current vector is a null vector.
     *
     * @return The vector itself for command chaining.
     * @throws Whenever a null vector gets normalized.
     */
    public function normalize():Void;

    /**
     * Clone this vector.
     *
     * @return A copy of this vector.
     */
    public function clone():IVector;

    /**
     * Check whether this vector is equal to another vector.
     *
     * @param oVector The other vector.
     * @return Whether this vector equals to the other vector.
     */
    public function equals(oVector:IVector):Bool;

    /**
     * Add another vector to this vector.
     *
     * @param oVector The other vector.
     */
    public function add(oVector:IVector):Void;

    /**
     * Substract another vector from this vector.
     *
     * @param oVector The other vector.
     */
    public function sub(oVector:IVector):Void;

    /**
     * mult, div, angle
     */
}
