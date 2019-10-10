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

import be.ulb.eeg.ebe.haxelib.logging.BaseLogger;
import be.ulb.eeg.ebe.haxelib.logging.Log;

/**
 * This class represents a single color.
 *
 * @author Yann Spoeri
 */
class Color
{
    /**
     * The logger for this class.
     */
    private static var logger:BaseLogger = new BaseLogger("be.ulb.eeg.ebe.haxelib.gui.Color");

    /**
     * The red value of this color. The value must be between 0 and 255 (inclusive).
     */
    private var mRed:Int;
    
    /**
     * The green value of this color. The value must be between 0 and 255 (inclusive).
     */
    private var mGreen:Int;
    
    /**
     * The blue value of this color. The value must be between 0 and 255 (inclusive).
     */
    private var mBlue:Int;
    
    /**
     * The alpha value of this color. The value must be between 0 and 100 (inclusive).
     *
     * 0 means fully transparent, 100 fully opaque.
     */
    private var mAlpha:Int;
    
    /**
     * Create a new Color.
     *
     * @param red   The red value of this color (between 0 and 255).
     * @param green The green value of this color (between 0 and 255).
     * @param blue  The blue value of this color (between 0 and 255).
     * @param alpha The alpha value of this color (between 0 and 100).
     */
    public function new(red:Int, green:Int, blue:Int, ?alpha:Null<Int>=null) {
        logger.log(Log.METHOD, "red: " + red + ", green: " + green + ", blue: " + blue + ", alpha: " + alpha);
        setRed(red);
        setGreen(green);
        setBlue(blue);
        setAlpha(alpha);
    }
    
    /**
     * Get the red value of this color.
     *
     * @return The red value of this color.
     */
    public inline function getRed():Int {
        return mRed;
    }
    
    /**
     * Get the green value of this color.
     *
     * @return The green value of this color.
     */
    public inline function getGreen():Int {
        return mGreen;
    }
    
    /**
     * Get the blue value of this color.
     *
     * @return The blue value of this color.
     */
    public inline function getBlue():Int {
        return mBlue;
    }
    
    /**
     * Get the alpha value of this color.
     *
     * @return The alpha value of this color.
     */
    public inline function getAlpha():Int {
        return mAlpha;
    }
    
    /**
     * Set the red value of this color.
     *
     * @param red   The new red value.
     */
    public inline function setRed(red:Int):Void {
        if(red == null || red < 0 || red > 255) {
            throw "Red value must be between 0 and 255 (inclusive), not " + red;
        }
        mRed = red;
    }
    
    /**
     * Set the green value of this color.
     *
     * @param green The new green value.
     */
    public inline function setGreen(green:Int):Void {
        if(green == null || green < 0 || green > 255) {
            throw "Green value must be between 0 and 255 (inclusive), not " + green;
        }
        mGreen = green;
    }
    
    /**
     * Set the blue value of this color.
     *
     * @param blue  The new blue value.
     */
    public inline function setBlue(blue:Int):Void {
        if(blue == null || blue < 0 || blue > 255) {
            throw "Blue value must be between 0 and 255 (inclusive), not " + blue;
        }
        mBlue = blue;
    }
    
    /**
     * Set the alpha value of this color.
     *
     * @param alpha The new alpha value.
     */
    public inline function setAlpha(alpha:Int):Void {
        if(alpha == null) {
            mAlpha = 100;
        } else {
            if(alpha < 0 || alpha > 100) {
                throw "Alpha value must be between 0 and 100 (inclusive), not " + alpha;
            }
            mAlpha = alpha;
        }
    }
    
    /**
     * Get this color as html color string.
     *
     * @return A textual representation of this color.
     */
    public inline function getHtmlColorString():String {
        return "rgba(" + mRed + "," + mGreen + "," + mBlue + "," + (mAlpha / 100) + ")";
    }
}