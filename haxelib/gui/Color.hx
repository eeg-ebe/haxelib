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
package haxelib.gui;

import haxelib.logging.BaseLogger;
import haxelib.logging.Log;

import haxe.ds.StringMap;
import StringTools;

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
    @:final
    private static var logger:BaseLogger = new BaseLogger("haxelib.gui.Color");

    /**
     * HashSet listing known color names.
     */
    @:final
    private static var KNOWN_COLOR_NAMES:StringMap<Color> = [
        'ALICEBLUE' => new Color(240, 248, 255),
        'ANTIQUEWHITE' => new Color(250, 235, 215),
        'AQUA' => new Color(0, 255, 255),
        'AQUAMARINE' => new Color(127, 255, 212),
        'AZURE' => new Color(240, 255, 255),
        'BEIGE' => new Color(245, 245, 220),
        'BISQUE' => new Color(255, 228, 196),
        'BLACK' => new Color(0, 0, 0),
        'BLANCHEDALMOND' => new Color(255, 235, 205),
        'BLUE' => new Color(0, 0, 255),
        'BLUEVIOLET' => new Color(138, 43, 226),
        'BROWN' => new Color(165, 42, 42),
        'BURLYWOOD' => new Color(222, 184, 135),
        'CADETBLUE' => new Color(95, 158, 160),
        'CHARTREUSE' => new Color(127, 255, 0),
        'CHOCOLATE' => new Color(210, 105, 30),
        'CORAL' => new Color(255, 127, 80),
        'CORNFLOWERBLUE' => new Color(100, 149, 237),
        'CORNSILK' => new Color(255, 248, 220),
        'CRIMSON' => new Color(220, 20, 60),
        'CYAN' => new Color(0, 255, 255),
        'DARKBLUE' => new Color(0, 0, 139),
        'DARKCYAN' => new Color(0, 139, 139),
        'DARKGOLDENROD' => new Color(184, 134, 11),
        'DARKGRAY' => new Color(169, 169, 169),
        'DARKGREY' => new Color(169, 169, 169),
        'DARKGREEN' => new Color(0, 100, 0),
        'DARKKHAKI' => new Color(189, 183, 107),
        'DARKMAGENTA' => new Color(139, 0, 139),
        'DARKOLIVEGREEN' => new Color(85, 107, 47),
        'DARKORANGE' => new Color(255, 140, 0),
        'DARKORCHID' => new Color(153, 50, 204),
        'DARKRED' => new Color(139, 0, 0),
        'DARKSALMON' => new Color(233, 150, 122),
        'DARKSEAGREEN' => new Color(143, 188, 143),
        'DARKSLATEBLUE' => new Color(72, 61, 139),
        'DARKSLATEGRAY' => new Color(47, 79, 79),
        'DARKSLATEGREY' => new Color(47, 79, 79),
        'DARKTURQUOISE' => new Color(0, 206, 209),
        'DARKVIOLET' => new Color(148, 0, 211),
        'DEEPPINK' => new Color(255, 20, 147),
        'DEEPSKYBLUE' => new Color(0, 191, 255),
        'DIMGRAY' => new Color(105, 105, 105),
        'DIMGREY' => new Color(105, 105, 105),
        'DODGERBLUE' => new Color(30, 144, 255),
        'FIREBRICK' => new Color(178, 34, 34),
        'FLORALWHITE' => new Color(255, 250, 240),
        'FORESTGREEN' => new Color(34, 139, 34),
        'FUCHSIA' => new Color(255, 0, 255),
        'GAINSBORO' => new Color(220, 220, 220),
        'GHOSTWHITE' => new Color(248, 248, 255),
        'GOLD' => new Color(255, 215, 0),
        'GOLDENROD' => new Color(218, 165, 32),
        'GRAY' => new Color(128, 128, 128),
        'GREY' => new Color(128, 128, 128),
        'GREEN' => new Color(0, 128, 0),
        'GREENYELLOW' => new Color(173, 255, 47),
        'HONEYDEW' => new Color(240, 255, 240),
        'HOTPINK' => new Color(255, 105, 180),
        'INDIANRED' => new Color(205, 92, 92),
        'INDIGO' => new Color(75, 0, 130),
        'IVORY' => new Color(255, 255, 240),
        'KHAKI' => new Color(240, 230, 140),
        'LAVENDER' => new Color(230, 230, 250),
        'LAVENDERBLUSH' => new Color(255, 240, 245),
        'LAWNGREEN' => new Color(124, 252, 0),
        'LEMONCHIFFON' => new Color(255, 250, 205),
        'LIGHTBLUE' => new Color(173, 216, 230),
        'LIGHTCORAL' => new Color(240, 128, 128),
        'LIGHTCYAN' => new Color(224, 255, 255),
        'LIGHTGOLDENRODYELLOW' => new Color(250, 250, 210),
        'LIGHTGRAY' => new Color(211, 211, 211),
        'LIGHTGREY' => new Color(211, 211, 211),
        'LIGHTGREEN' => new Color(144, 238, 144),
        'LIGHTPINK' => new Color(255, 182, 193),
        'LIGHTSALMON' => new Color(255, 160, 122),
        'LIGHTSEAGREEN' => new Color(32, 178, 170),
        'LIGHTSKYBLUE' => new Color(135, 206, 250),
        'LIGHTSLATEGRAY' => new Color(119, 136, 153),
        'LIGHTSLATEGREY' => new Color(119, 136, 153),
        'LIGHTSTEELBLUE' => new Color(176, 196, 222),
        'LIGHTYELLOW' => new Color(255, 255, 224),
        'LIME' => new Color(0, 255, 0),
        'LIMEGREEN' => new Color(50, 205, 50),
        'LINEN' => new Color(250, 240, 230),
        'MAGENTA' => new Color(255, 0, 255),
        'MAROON' => new Color(128, 0, 0),
        'MEDIUMAQUAMARINE' => new Color(102, 205, 170),
        'MEDIUMBLUE' => new Color(0, 0, 205),
        'MEDIUMORCHID' => new Color(186, 85, 211),
        'MEDIUMPURPLE' => new Color(147, 112, 219),
        'MEDIUMSEAGREEN' => new Color(60, 179, 113),
        'MEDIUMSLATEBLUE' => new Color(123, 104, 238),
        'MEDIUMSPRINGGREEN' => new Color(0, 250, 154),
        'MEDIUMTURQUOISE' => new Color(72, 209, 204),
        'MEDIUMVIOLETRED' => new Color(199, 21, 133),
        'MIDNIGHTBLUE' => new Color(25, 25, 112),
        'MINTCREAM' => new Color(245, 255, 250),
        'MISTYROSE' => new Color(255, 228, 225),
        'MOCCASIN' => new Color(255, 228, 181),
        'NAVAJOWHITE' => new Color(255, 222, 173),
        'NAVY' => new Color(0, 0, 128),
        'OLDLACE' => new Color(253, 245, 230),
        'OLIVE' => new Color(128, 128, 0),
        'OLIVEDRAB' => new Color(107, 142, 35),
        'ORANGE' => new Color(255, 165, 0),
        'ORANGERED' => new Color(255, 69, 0),
        'ORCHID' => new Color(218, 112, 214),
        'PALEGOLDENROD' => new Color(238, 232, 170),
        'PALEGREEN' => new Color(152, 251, 152),
        'PALETURQUOISE' => new Color(175, 238, 238),
        'PALEVIOLETRED' => new Color(219, 112, 147),
        'PAPAYAWHIP' => new Color(255, 239, 213),
        'PEACHPUFF' => new Color(255, 218, 185),
        'PERU' => new Color(205, 133, 63),
        'PINK' => new Color(255, 192, 203),
        'PLUM' => new Color(221, 160, 221),
        'POWDERBLUE' => new Color(176, 224, 230),
        'PURPLE' => new Color(128, 0, 128),
        'REBECCAPURPLE' => new Color(102, 51, 153),
        'RED' => new Color(255, 0, 0),
        'ROSYBROWN' => new Color(188, 143, 143),
        'ROYALBLUE' => new Color(65, 105, 225),
        'SADDLEBROWN' => new Color(139, 69, 19),
        'SALMON' => new Color(250, 128, 114),
        'SANDYBROWN' => new Color(244, 164, 96),
        'SEAGREEN' => new Color(46, 139, 87),
        'SEASHELL' => new Color(255, 245, 238),
        'SIENNA' => new Color(160, 82, 45),
        'SILVER' => new Color(192, 192, 192),
        'SKYBLUE' => new Color(135, 206, 235),
        'SLATEBLUE' => new Color(106, 90, 205),
        'SLATEGRAY' => new Color(112, 128, 144),
        'SLATEGREY' => new Color(112, 128, 144),
        'SNOW' => new Color(255, 250, 250),
        'SPRINGGREEN' => new Color(0, 255, 127),
        'STEELBLUE' => new Color(70, 130, 180),
        'TAN' => new Color(210, 180, 140),
        'TEAL' => new Color(0, 128, 128),
        'THISTLE' => new Color(216, 191, 216),
        'TOMATO' => new Color(255, 99, 71),
        'TURQUOISE' => new Color(64, 224, 208),
        'VIOLET' => new Color(238, 130, 238),
        'WHEAT' => new Color(245, 222, 179),
        'WHITE' => new Color(255, 255, 255),
        'WHITESMOKE' => new Color(245, 245, 245),
        'YELLOW' => new Color(255, 255, 0),
        'YELLOWGREEN' => new Color(154, 205, 50)
    ];

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
    public inline function setRed(red:Null<Int>):Void {
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
    public inline function setGreen(green:Null<Int>):Void {
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
    public inline function setBlue(blue:Null<Int>):Void {
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
    public inline function setAlpha(alpha:Null<Int>):Void {
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
    public inline function toString():String {
        return "rgba(" + mRed + "," + mGreen + "," + mBlue + "," + (mAlpha / 100) + ")";
    }

    /**
     * Clone this color.
     *
     * @return A cloned instance of this color.
     */
    public inline function clone():Color {
        return new Color(mRed, mGreen, mBlue, mAlpha);
    }

    /**
     * Check if this object is the same as another object.
     *
     * @return True if the objects are the same, false otherwise.
     */
    public function equals(o:Dynamic):Bool {
        var result:Bool = false;
        //if(Std.is(o, Color)) {
        if (Std.isOfType(o, Color)) {
            var oColor:Color = cast o;
            result = (oColor.mAlpha == mAlpha) &&
                    (oColor.mRed == mRed) &&
                    (oColor.mGreen == mGreen) &&
                    (oColor.mBlue == mBlue);
        }
        return result;
    }

    /**
     * Calculate a hashCode value for this object.
     *
     * @return A hashCode value for this object.
     */
    public function hashCode():Int {
        return mAlpha + mRed << 8 + mGreen << 16 + mBlue << 24;
    }

    /**
     * Parse a string representing a color.
     *
     * @param s The color to parse.
     * @return The corresponding color.
     */
    public static function parse(str:String):Color {
        logger.log(Log.METHOD, "parsing: " + str);
        if(str == null) {
            throw "Cannot parse null string!";
        }
        var s:String = StringTools.trim(str);
        s = StringTools.replace(s, " ", "");
        s = StringTools.replace(s, "\t", "");
        s = s.toUpperCase();
        // known name
        if(KNOWN_COLOR_NAMES.exists(s)) {
            var c:Color = KNOWN_COLOR_NAMES.get(s);
            logger.log(Log.DEBUG, "found color " + c + " for string " + s + " in map!");
            return KNOWN_COLOR_NAMES.get(s).clone();
        }
        // rgb(red, green, blue)
        if(StringTools.startsWith(s, "RGB(")) {
            logger.log(Log.DEBUG, "rgb() color representation");
            s = StringTools.replace(s, "RGB(", "");
            s = StringTools.replace(s, ")", "");
            var numbers:Array<String> = s.split(",");
            if(numbers.length != 3) {
                logger.log(Log.DEBUG, "rgb() color representation, but " + numbers.length + " tupel?");
                throw "Parsing string " + str + " failed! No corresponding color (case 1: " + numbers.length + " != 3)";
            }
            var red:Int = Std.parseInt(numbers[0]);
            var green:Int = Std.parseInt(numbers[1]);
            var blue:Int = Std.parseInt(numbers[2]);
            return new Color(red, green, blue);
        }
        // rgba(red, green, blue, alpha)
        if(StringTools.startsWith(s, "RGBA(")) {
            logger.log(Log.DEBUG, "rgba() color representation");
            s = StringTools.replace(s, "RGBA(", "");
            s = StringTools.replace(s, ")", "");
            var numbers:Array<String> = s.split(",");
            if(numbers.length != 4) {
                logger.log(Log.DEBUG, "rgba() color representation, but " + numbers.length + " tupel?");
                throw "Parsing string " + str + " failed! No corresponding color (case 2: " + numbers.length + " != 4)";
            }
            var red:Int = Std.parseInt(numbers[0]);
            var green:Int = Std.parseInt(numbers[1]);
            var blue:Int = Std.parseInt(numbers[2]);
            var alphaOrig = Std.parseFloat(numbers[3]);
            var alpha:Int = Std.int(alphaOrig * 100);
            logger.log(Log.DEBUG, "alpha " + alphaOrig + " -> " + alpha);
            return new Color(red, green, blue, alpha);
        }
        // #rrggbb / #rgb
        if(StringTools.startsWith(s, "#")) {
            logger.log(Log.DEBUG, "#XXXXXX or #XXX color representation");
            s = StringTools.replace(s, "#", "");
            if(s.length == 3) {
                var redHexStr:String = "0x" + s.charAt(0) + s.charAt(0);
                var greenHexStr:String = "0x" + s.charAt(1) + s.charAt(1);
                var blueHexStr:String = "0x" + s.charAt(2) + s.charAt(2);
                var red:Int = Std.parseInt(redHexStr);
                var green:Int = Std.parseInt(greenHexStr);
                var blue:Int = Std.parseInt(blueHexStr);
                return new Color(red, green, blue);
            } else if(s.length == 6) {
                var redHexStr:String = "0x" + s.charAt(0) + s.charAt(1);
                var greenHexStr:String = "0x" + s.charAt(2) + s.charAt(3);
                var blueHexStr:String = "0x" + s.charAt(4) + s.charAt(5);
                var red:Int = Std.parseInt(redHexStr);
                var green:Int = Std.parseInt(greenHexStr);
                var blue:Int = Std.parseInt(blueHexStr);
                return new Color(red, green, blue);
            } else {
                throw "Parsing string " + str + " failed! No corresponding color (case 3: " + s.length + " != 3 or 6)";
            }
        }
        // hsl(hue, saturation, lightness)
        if(StringTools.startsWith(s, "HSL(")) {
            logger.log(Log.DEBUG, "hsl() color representation");
            s = StringTools.replace(s, "HSL(", "");
            s = StringTools.replace(s, ")", "");
            s = StringTools.replace(s, "%", "");
            var numbers:Array<String> = s.split(",");
            if(numbers.length != 3) {
                logger.log(Log.DEBUG, "hsl() color representation, but " + numbers.length + " tupel?");
                throw "Parsing string " + str + " failed! No corresponding color (case 4: " + numbers.length + " != 3)";
            }
            var h:Float = Std.parseFloat(numbers[0]);
            var s:Float = Std.parseFloat(numbers[1]) / 100;
            var l:Float = Std.parseFloat(numbers[2]) / 100;
            logger.log(Log.DEBUG, "h: " + h + ", s: " + s + ", l: " + l);
            return Color.hslToRgbColor(h, s, l);
        }
        // hsla(hue, saturation, lightness, alpha)
        if(StringTools.startsWith(s, "HSLA(")) {
            logger.log(Log.DEBUG, "hsla() color representation");
            s = StringTools.replace(s, "HSLA(", "");
            s = StringTools.replace(s, ")", "");
            s = StringTools.replace(s, "%", "");
            var numbers:Array<String> = s.split(",");
            if(numbers.length != 4) {
                logger.log(Log.DEBUG, "hsla() color representation, but " + numbers.length + " tupel?");
                throw "Parsing string " + str + " failed! No corresponding color (case 5: " + numbers.length + " != 4)";
            }
            var h:Float = Std.parseFloat(numbers[0]);
            var s:Float = Std.parseFloat(numbers[1]) / 100;
            var l:Float = Std.parseFloat(numbers[2]) / 100;
            var a:Float = Std.parseFloat(numbers[3]);
            logger.log(Log.DEBUG, "h: " + h + ", s: " + s + ", l: " + l + ", a: " + a);
            return Color.hslToRgbColor(h, s, l, a);
        }
        throw "Parsing string " + str + " failed! No corresponding color (case default).";
    }

    /**
     * Convert an hsla tuple to a Color object.
     *
     * @param h The hue (0 <= h < 360)
     * @param s The saturation (0 <= s <= 1)
     * @param l The lightness (0 <= l <= 1)
     * @param a The alpha value (0 <= a <=1).
     * @return The corresponding color.
     */
    public static function hslToRgbColor(h:Float, s:Float, l:Float, ?a:Float=1):Color {
        logger.log(Log.METHOD, "h: " + h +", s: " + s + ", l: " + l + ", a: " + a);
        if(!(0 <= h && h < 360)) {
            throw "Hue must be in between 0 and 360 (0 inclusive, 360 exclusive), but is " + h;
        }
        if(!(0 <= s && s <= 1)) {
            throw "Saturation must be in between 0 and 1 (both inclusive), but is " + s;
        }
        if(!(0 <= l && l <= 1)) {
            throw "Lightness must be in between 0 and 1 (both inclusive), but is " + l;
        }
        if(!(0 <= a && a <= 1)) {
            throw "Alpha must be in between 0 and 1 (both inclusive), but is " + a;
        }
        var c:Float = (1 - Math.abs(2 * l - 1)) * s;
        var x:Float = c * (1 - Math.abs((h / 60) % 2 - 1));
        var m:Float = l - c / 2;
        var r_:Float = 0, g_:Float = 0, b_:Float =  0;
        if (0 <= h && h < 60) {
            r_ = c;
            g_ = x;
        } else if (60 <= h && h < 120) {
            r_ = x;
            g_ = c;
        } else if (120 <= h && h < 180) {
            g_ = c;
            b_ = x;
        } else if (180 <= h && h < 240) {
            g_ = x;
            b_ = c;
        } else if (240 <= h && h < 300) {
            r_ = x;
            b_ = c;
        } else if (300 <= h && h < 360) {
            r_ = c;
            b_ = x;
        }
        var red:Int = Std.int((r_ + m) * 255);
        var green:Int = Std.int((g_ + m) * 255);
        var blue:Int = Std.int((b_ + m) * 255);
        var alpha:Int = Std.int(a * 100);
        logger.log(Log.DEBUG, "red: " + red + ", green: " + green + ", blue: " + blue + ", alpha: " + alpha);
        return new Color(red, green, blue, alpha);
    }

    public static function main() {}
}
