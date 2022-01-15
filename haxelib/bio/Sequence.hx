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
package haxelib.logging;

/**
 * A Sequence.
 *
 * @author Yann Spöri
 */
class Sequence
{
    /**
     * The name connected to this sequence.
     */
    private static var mName:String;

    /**
     * The sequence itself.
     */
    private static var mSequence:String;

    /**
     * As this is a singleton, the constructor is private.
     */
    private function new(name:String, seq:String) {
        setName(name);
        setSequence(seq);
    }

    /**
     * Set the name of this sequence.
     */
    public inline function setName(name:String):Void {
        mName = name;
    }

    /**
     * Get the name of this sequence.
     */
    public inline function getName():String {
        return mName;
    }

    /**
     * Set the sequence of this sequence.
     */
    public inline function setSequence(seq:String):Void {
        if (mSequence == null) {
            throw "Sequence must not be null!";
        }
        mSequence = seq.toUpperCase();
    }

    /**
     * Get the sequence of this sequence.
     */
    public inline function getSequence():String {
        return mSequence;
    }

    /**
     * Get the length of this sequence.
     */
    public inline function length() {
        return mSequence.length;
    }

    /**
     * Return the char at position pos in this sequence.
     */
    public inline function charAt(pos:Int):String {
        if (!(0 <= pos && pos < mSequence.length)) {
            throw "Pos (" + i + ") is out of range!";
        }
        return mSequence.charAt(pos);
    }
}