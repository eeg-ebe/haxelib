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
package be.ulb.eeg.ebe.haxelib.gui;

import be.ulb.eeg.ebe.haxelib.lang.Object;

import be.ulb.eeg.ebe.haxelib.logging.BaseLogger;
import be.ulb.eeg.ebe.haxelib.logging.Log;

/**
 * A Keyboard shortcut.
 *
 * @author Yann Spöri
 */
class KeyboardShortcut extends Object
{
    /**
     * The logger for this class.
     */
    @:final
    private static var logger:BaseLogger = new BaseLogger("be.ulb.eeg.ebe.haxelib.gui.KeyboardShortcut");

    /**
     * Whether the ctrl modifier is needed for this shortcut.
     */
    private var mCtrlModifier:Bool;
    
    /**
     * Whether the alt modifier is needed for this shortcut.
     */
    private var mAltModifier:Bool;
    
    /**
     * Whether the shift modifier is needed for this shortcut.
     */
    private var mShiftModifier:Bool;
    
    /**
     * The shortcut key that needs to get pressed. By convention the String should be uppercase.
     *
     * Examples:
     *  - B means that the key B is needs to get pressed (along with modifiers).
     *  - F10 means that the F10 key needs to get pressed (along with modifiers).
     */
    private var mKey:String;
    
    /**
     * Create a new KeyboardShortcut object.
     *
     * @param ctrl  Whether for this shortcut the ctrl modifier needs to get pressed.
     * @param alt   Whether for this shortcut the alt modifier needs to get pressed.
     * @param shift Whether for this shortcut the shift modifier needs to get pressed.
     * @param key   A string describing the key that needs to get pressed for this shortcut.
     * E.g. B in order to indicate that the key "B" needs to get pressed, or "F10" in order
     * to specify that the F10 key needs to get pressed.
     */
    public function new(ctrl:Bool, alt:Bool, shift:Bool, key:String) {
        setNeedsCtrl(ctrl);
        setNeedsAlt(alt);
        setNeedsShift(shift);
        setKey(key);
    }
    
    /**
     * Return whether this shortcut needs the ctrl modifier.
     *
     * @return Whether this shortcut needs the ctrl modifier.
     */
    public inline function needsCtrlModifier():Bool {
        return mCtrlModifier;
    }
    
    /**
     * Returns whether this shortcut needs the alt modifier.
     *
     * @return Whether this shortcut needs the alt modifier.
     */
    public inline function needsAltModifier():Bool {
        return mAltModifier;
    }
    
    /**
     * Returns whether this shortcut needs the shift modifier.
     *
     * @return Whether this shortcut needs the shift modifier.
     */
    public inline function needsShiftModifier():Bool {
        return mShiftModifier;
    }
    
    /**
     * Returns the main key of this keyboard shortcut.
     *
     * @return The key of this shortcut.
     */
    public inline function getkey():String {
        return mKey;
    }
    
    /**
     * Set whether this shortcut needs the ctrl modifier.
     *
     * @param needCtrl  Whether this shortcut needs the ctrl modifier.
     */
    public inline function setNeedsCtrl(needCtrl:Bool):Void {
        if(needCtrl == null) {
            throw "Illegal argument (1)";
        }
        mCtrlModifier = needCtrl;
    }
    
    /**
     * Set whether this shortcut needs the alt modifier.
     *
     * @param needAlt   Whether this shortcut needs the alt modifier.
     */
    public inline function setNeedsAlt(needAlt:Bool):Void {
        if(needAlt == null) {
            throw "Illegal argument (2)";
        }
        mAltModifier = needAlt;
    }
    
    /**
     * Set whether this shortcut needs the shift modifier.
     *
     * @param needShift Whether this shortcut needs the shift modifier.
     */
    public inline function setNeedsShift(needShift:Bool):Void {
        if(needShift == null) {
            throw "Illegal argument (3)";
        }
        mShiftModifier = needShift;
    }

    /**
     * Set the key of this shortcut.
     *
     * @param key   The key of this shortcut.
     */
    public inline function setKey(key:String) {
        if(key == null || key.length == 0) {
            throw "Empty key not allowed";
        }
        mKey = key.toUpperCase();
    }
    
    /**
     * Get a textual representation of this shortcut.
     *
     * @return A textual representation of this shortcut.
     */
    public function toString():String {
        var result:StringBuf = new StringBuf();
        if(mCtrlModifier) {
            result.add("Ctrl + ");
        }
        if(mAltModifier) {
            result.add("Alt + ");
        }
        if(mShiftModifier) {
            result.add("Shift + ");
        }
        result.add(mKey);
        return result.toString();
    }
    
    /**
     * Check if this object is the same as another object.
     * 
     * @return True if the objects are the same, false otherwise.
     */
    public override function equals(o:Object):Bool {
        var result:Bool = false;
        if(Std.is(o, KeyboardShortcut)) {
            var oKey:KeyboardShortcut = cast o;
            result = (oKey.mCtrlModifier == mCtrlModifier) &&
                    (oKey.mAltModifier == mAltModifier) &&
                    (oKey.mShiftModifier == mShiftModifier) &&
                    (oKey.mKey == mKey);
        }
        return result;
    }
    
    /**
     * Calculate a hashCode value for this object.
     *
     * @return A hashCode value for this object.
     */
    public override function hashCode():Int {
        var result:Int = 1;
        for (i in 0...mKey.length) {
            result = result * 3 + mKey.charCodeAt(i);
        }
        if(mCtrlModifier) {
            result *= 5;
        }
        if(mAltModifier) {
            result *= 7;
        }
        if(mShiftModifier) {
            result *= 11;
        }
        return result;
    }
}