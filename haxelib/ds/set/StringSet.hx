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

import haxe.ds.StringMap;

/**
 * A set containing strings.
 *
 * @author Yann Spoeri
 */
class StringSet
{
    /**
     * The hashmap behind this set.
     */
    private var mItems:StringMap<Bool>;
    
    /**
     * The number of elements in this set.
     */
    private var mSize:Int = 0;
    
    /**
     * The object to add for every StringMap item.
     */
    private var obj:Bool = false;
    
    /**
     * Create a new StringSet.
     */
    public function new(?items:List<String>) {
        mItems = new StringMap<Bool>();
        if (items != null) {
            for (item in items) {
                add(item);
            }
        }
    }
    
    /**
     * Add a string to this set.
     */
    public function add(item:String):Void {
        mItems.set(item, obj);
        mSize++;
    }
    
    /**
     * Check whether this set contains a particular string.
     */
    public function contains(item:String):Bool {
        return mItems.exists(item);
    }
    
    /**
     * Remove a particular string from this set.
     */
    public function remove(item:String):Bool {
        if (mItems.exists(item)) {
            mItems.remove(item);
            mSize--;
            return true;
        }
        return false;
    }
    
    /**
     * Get the number of elements in this set.
     */
    public function size():Int {
        return mSize;
    }
    
    /**
     * Iterate over the elements in this set.
     */
    public inline function iterator() {
        return mItems.keys();
    }
    
    /**
     * Remove all items from this set.
     */
    public function clear():Void {
        mItems = new StringMap<Bool>();
        mSize = 0;
    }
    
    /**
     * Create a copy of this set.
     */
    public function copy():StringSet {
        var result:StringSet = new StringSet();
        for (item in mItems.keys()) {
            result.add(item);
        }
        return result;
    }
    
    /**
     * Create another set that contains the unification of this set and another one.
     */
    public function union(o:StringSet):StringSet {
        var result:StringSet = new StringSet();
        for (item in mItems.keys()) {
            result.add(item);
        }
        for (item in o.mItems.keys()) {
            result.add(item);
        }
        return result;
    }
    
    /**
     * Calculate the intersection of this set and another one.
     */
    public function intersection(o:StringSet):StringSet {
        var result:StringSet = new StringSet();
        for (item in mItems.keys()) {
            if (o.contains(item)) {
                result.add(item);
            }
        }
        return result;
    }
    
    /**
     * Check whether this set equals to another one.
     */
    public function equals(o:StringSet) {
        if (mSize != o.mSize) {
            return false;
        }
        for (e in mItems.keys()) {
            if (! o.contains(e)) {
                return false;
            }
        }
        return true;
    }
    
    public inline function hashCode():Int {
        var result:Int = 17;
        var multiplier:Int = 3;
        for (e in mItems.keys()) {
            for (i in 0...e.length) {
                result = result * multiplier + e.charCodeAt(i);
            }
            multiplier += 2;
        }
        return result;
    }
    
    /**
     * Create a textual representation of this set.
     */
    public function toString():String {
        var out:Array<String> = new Array<String>();
        for (item in mItems.keys()) {
            out.push(item);
        }
        return out.join(", ");
    }
    
    public static function main() {
        var items1:List<String> = new List<String>();
        items1.add("1");
        items1.add("2");
        items1.add("3");
        var items2:List<String> = new List<String>();
        items2.add("1");
        items2.add("2");
        items2.add("4");
        var s1:StringSet = new StringSet(items1);
        var s2:StringSet = new StringSet(items2);
        trace(s1.intersection(s2).toString());
        trace(s1.size());
        for (e in s1) {
            trace(e);
        }
    }
}