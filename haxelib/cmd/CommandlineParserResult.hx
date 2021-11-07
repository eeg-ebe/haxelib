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
package haxelib.cmd;

import haxe.ds.StringMap;

/**
 * The result of a commandline parser.
 *
 * @author Yann Spoeri
 */
class CommandlineParserResult
{
    /**
     * The map where the parsing results are stored.
     */
    private var mMap:StringMap<String>;

    /**
     * A possible error message.
     */
    private var mErrorMessage:String;

    /**
     * Create a new CommandlineParser result object.
     */
    public function new() {
        mMap = new StringMap<String>();
    }

    /**
     * This method is used by the parser in order to store a key/value pair.
     *
     * @param   key     The key to store.
     * @param   value   The corresponding value.
     */
    public function store(key:String, value:String):Void {
        mMap.set(key, value);
    }

    /**
     * Get the value of a string.
     *
     * @param   key     The key to get the value for.
     * @return The value mapped to the key.
     */
    public function getString(key:String):String {
        if (mErrorMessage != null) {
            throw mErrorMessage;
        }
        return mMap.get(key);
    }

    /**
     * Get the value of an int.
     *
     * @param   key     The key to get the value for.
     * @return The value mapped to the key.
     */
    public function getInt(key:String):Int {
        if (mErrorMessage != null) {
            throw mErrorMessage;
        }
        var val:String = mMap.get(key);
        return Std.parseInt(val);
    }

    /**
     * Get the value of a float.
     *
     * @param   key     The key to get the value for.
     * @return The value mapped to the key.
     */
    public function getFloat(key:String):Float {
        if (mErrorMessage != null) {
            throw mErrorMessage;
        }
        var val:String = mMap.get(key);
        return Std.parseFloat(val);
    }

    /**
     * Get the value of a boolean.
     *
     * @param   key     The key to get the value for.
     * @return The value mapped to the key.
     */
    public function getBool(key:String):Bool {
        if (mErrorMessage != null) {
            throw mErrorMessage;
        }
        var val:String = mMap.get(key);
        if (val == null) {
            return false;
        }
        val = StringTools.trim(val).toUpperCase();
        return "1" == val || "TRUE" == val || "YES" == val;
    }

    /**
     * Returns whether the program should stop and print the error message.
     *
     * @return Whether there was an error parsing the commandline.
     */
    public inline function hasError():Bool {
        return mErrorMessage != null;
    }

    /**
     * Set an error message.
     *
     * @param   s   The error message.
     */
    public inline function setErrorMessage(s:String):Void {
        mErrorMessage = s;
    }

    /**
     * Get an error message.
     *
     * @return An error message.
     */
    public inline function getErrorMessage():String {
        return mErrorMessage;
    }
}