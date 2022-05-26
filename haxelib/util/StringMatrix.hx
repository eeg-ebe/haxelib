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

import haxelib.math.Matrix;

import haxe.ds.StringMap;
import haxe.ds.Vector;

/**
 * Matrix representation with string keys.
 *
 * Do NOT use the methods getValue or setValue but the
 * methods set and lookup instead.
 *
 * @author Yann Spoeri
 */
class StringMatrix extends Matrix
{
    /**
     * The names.
     */
    private var mNames:Vector<String>;

    /**
     * A StringMap mapping Strings's to positions.
     */
    private var mNamePosLookup:StringMap<Int>;

    /**
     * Create a new DistanceMatrix.
     */
    public function new(names:Vector<String>) {
        if (names == null || names.length == 0) {
            throw "Names must not be empty!";
        }
        super(names.length, names.length);
        mNames = names;
        mNamePosLookup = new StringMap<Int>();
        var pos:Int = 0;
        for (name in names) {
            mNamePosLookup.set(name, pos++);
        }
    }

    /**
     * return the names connected to this distance matrix.
     */
    public inline function getNames():Vector<String> {
        return mNames;
    }

    /**
     * Lookup a distance.
     */
    public inline function lookup(x1:String, x2:String):Float {
        var ret:Float = 0;
        if (x1 != x2) {
            var pos1:Null<Int> = mNamePosLookup.get(x1);
            if (pos1 == null) {
                throw x1 + " not in map!";
            }
            var pos2:Null<Int> = mNamePosLookup.get(x2);
            if (pos2 == null) {
                throw x2 + " not in map!";
            }
            if (pos1 > pos2) {
                var swap:Int = pos1;
                pos1 = pos2;
                pos2 = swap;
            }
            ret = mValues.get(pos1 + pos2 * mWidth);
        }
        return ret;
    }

    /**
     * Set a distance.
     */
    public inline function set(x1:String, x2:String, d:Float):Void {
        if (x1 == x2) {
            if (d != 0) {
                throw "Distance of identical objects must be 0!";
            }
        }
        var pos1:Null<Int> = mNamePosLookup.get(x1);
        if (pos1 == null) {
            throw x1 + " not in map!";
        }
        var pos2:Null<Int> = mNamePosLookup.get(x2);
        if (pos2 == null) {
            throw x2 + " not in map!";
        }
        if (pos1 > pos2) {
            var swap:Int = pos1;
            pos1 = pos2;
            pos2 = swap;
        }
        mValues.set(pos1 + pos2 * mWidth, d);
    }

    /**
     * Get a textual represenation of this matrix.
     */
    public override function toString():String {
        var result:Array<String> = new Array<String>();
        result.push("Dist");
        for (name in mNames) {
            result.push("\t" + name);
        }
        result.push("\n");
        var x:Int = 0;
        for (name1 in mNames) {
            result.push(Std.string(name1));
            var y:Int = 0;
            for (name2 in mNames) {
                if (y >= x) {
                    break;
                }
                result.push("\t" + mValues.get(y + x * mWidth));
                y++;
            }
            result.push("\n");
            x++;
        }
        return result.join("");
    }

    public static function main() {}
}
