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
package haxelib.bio;

import haxelib.iterators.StringIterator;

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
    private var mName:String;

    /**
     * The sequence itself.
     */
    private var mSequence:String;

    /**
     * Create a new sequence object.
     */
    public function new(name:String, seq:String) {
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
    public function setSequence(seq:String):Void {
        if (seq == null) {
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
            throw "Pos (" + pos + ") is out of range!";
        }
        return mSequence.charAt(pos);
    }

    /**
     * Create a textual representation of this Sequence object.
     */
    public inline function toString():String {
        return ">" + mName + "\n" + mSequence;
    }

    /**
     * Iterate over this sequence.
     */
    public inline function iterator() {
        return new StringIterator(mSequence);
    }

    public inline function toStringL(maxLen:Int):String {
        var result:Array<String> = new Array<String>();
        result.push(">");
        result.push(mName);
        result.push("\n");
        var seqLength:Int = mSequence.length;
        var startPos:Int = 0;
        while (startPos < seqLength) {
            var endPos:Int = (startPos + maxLen > seqLength) ? seqLength : startPos + maxLen;
            var s:String = mSequence.substring(startPos, endPos);
            result.push(s);
            if (endPos != seqLength) {
                result.push("\n");
            }
            startPos += maxLen;
        }
        return result.join("");
    }
    
    public inline function hashCode():Int {
        var result:Int = 17;
        for (i in 0...mName.length) {
            result = result * 3 + mName.charCodeAt(i);
        }
        for (i in 0...mSequence.length) {
            result = result * 5 + mSequence.charCodeAt(i);
        }
        return result;
    }
    
    public inline function equals(s:Sequence):Bool {
        return mName == s.mName && mSequence == s.mSequence;
    }

    public static function main() {
        var s:Sequence = new Sequence("mySeq", "ACTAGCGTACTACG");
        trace(s.getName());
        trace(s.getSequence());
        trace(s.length());
        trace(s.charAt(3));
        trace(s.toString());
    }
}