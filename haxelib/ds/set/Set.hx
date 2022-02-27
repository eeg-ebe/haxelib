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
package haxelib.ds.set;

import haxe.ds.HashMap;

/**
 * A Set.
 *
 * @author Yann Spoeri
 */
class Set<E:{function hashCode():Int;}>
{
    /**
     * The items contained in the set.
     */
    @:final
    private var mItems:HashMap<E, Bool>;

    /**
     * The mapped boolean.
     */
    @:final
    private var mMappedBoolean:Bool = false;

    /**
     * The size of items in this set.
     */
    private var mSize:Int = 0;

    /**
     * Create a new set.
     */
    private function new() {
        mItems = new HashMap<E, Bool>();
    }

    /**
     * Clear the elements from the set.
     */
    public inline function clear():Void {
        for (item in mItems.keys()) {
            mItems.remove(item);
        }
    }

    /**
     * Return a copy of this set.
     *
     * @return The copy.
     */
    public inline function copy():Set<E> {
        var s:Set<E> = new Set<E>();
        for (item in mItems.keys()) {
            s.add(item);
        }
        return s;
    }

    /**
     * Get the number of items in this set.
     *
     * @return The number of items in this set.
     */
    public inline function size():Int {
        return mSize;
    }

    /**
     * Add a particular item.
     *
     * @param e     The item to add.
     */
    public inline function add(e:E):Void {
        mItems.set(e, mMappedBoolean);
        ++mSize;
    }

    /**
     * Remove a particular item.
     *
     * @param e     The item to remove.
     * @result True if such an item existed, false otherwise.
     */
    public inline function remove(e:E):Bool {
        var result:Bool = mItems.remove(e);
        --mSize;
        return result;
    }

    /**
     * Remove an item from this set and returns it. Will return null in case there is no item left.
     */
    public inline function pop():E {
        var result:E = null;
        for (item in mItems.keys()) {
            result = item;
            break;
        }
        remove(result);
        return result;
    }

    /**
     * Check if a particular item e is part of this set.
     *
     * @param e     The element to check.
     * @return true if e is in this set, false otherwise.
     */
    public inline function contains(e:E):Bool {
        return mItems.exists(e);
    }

    /**
     * Calculate the intersection between this set and another set.
     */
    public inline function intersection(s:Set<E>):Set<E> {
        var result:Set<E> = new Set<E>();
        for (item in mItems.keys()) {
            if (s.contains(item)) {
                result.add(item);
            }
        }
        return result;
    }

    /**
     * Calculate the difference between this set and another set.
     */
    public inline function difference(s:Set<E>):Set<E> {
        var result:Set<E> = new Set<E>();
        for (item in mItems.keys()) {
            if (!s.contains(item)) {
                result.add(item);
            }
        }
        return result;
    }

    /**
     * Calculate the union between this set and another set.
     */
    public inline function union(s:Set<E>):Set<E> {
        var result:Set<E> = new Set<E>();
        for (item in mItems.keys()) {
            result.add(item);
        }
        for (item in s.mItems.keys()) {
            result.add(item);
        }
        return result;
    }

    /**
     * Create an array out of the elements present in this set.
     */
    public inline function toArray():Array<E> {
        var result:Array<E> = new Array<E>();
        for (item in mItems.keys()) {
            result.push(item);
        }
        return result;
    }

    /**
     * Return a textual representation of this set.
     */
    public inline function toString():String {
        var result:Array<String> = new Array<String>();
        result.push("[");
        var addComa:Bool = false;
        for (item in mItems.keys()) {
            if (addComa) {
                result.push(",");
            }
            result.push(Std.string(item));
            addComa = true;
        }
        result.push("]");
        return result.join("");
    }

    /**
     * Return an iterator to iterate over the different items in this set.
     */
    public inline function iterator():Iterator<E> {
        return mItems.keys();
    }

    public static function main() {
        //var s:Set = new Set<Int>();
        //s.add(1);
    }
}
