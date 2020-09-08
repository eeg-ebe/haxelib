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
package be.ulb.eeg.ebe.haxelib.gui;

import be.ulb.eeg.ebe.haxelib.tests.TestCase;
import be.ulb.eeg.ebe.haxelib.tests.TestRunner;

/**
 * Tests for the Color class.
 *
 * @author Yann Spöri
 */
class ColorTest extends TestCase
{
    /**
     * Create a new instance of this class.
     */
    public function new() {
        super("gui.ColorTest", "Check the Color class of the GUI package");
    }

    /**
     * Test the constructor of the Color class.
     */
    public function testConstructor():Void {
        // normal
        var color01:Color = new Color(20, 40, 50);
        ensure(color01.getRed() == 20);
        ensure(color01.getGreen() == 40);
        ensure(color01.getBlue() == 50);
        ensure(color01.getAlpha() == 100);
        // normal with alpha
        var color02:Color = new Color(10, 30, 70, 80);
        ensure(color02.getRed() == 10);
        ensure(color02.getGreen() == 30);
        ensure(color02.getBlue() == 70);
        ensure(color02.getAlpha() == 80);
        // red should be between 0 and 255
        try {
            var color03:Color = new Color(-10, 30, 70);
            ensure(false);
        } catch(err:Any) {}
        try {
            var color03:Color = new Color(256, 30, 70);
            ensure(false);
        } catch(err:Any) {}
        // green should be between 0 and 255
        try {
            var color03:Color = new Color(10, -30, 70);
            ensure(false);
        } catch(err:Any) {}
        try {
            var color03:Color = new Color(10, 256, 70);
            ensure(false);
        } catch(err:Any) {}
        // blue should be between 0 and 255
        try {
            var color03:Color = new Color(10, 30, -1);
            ensure(false);
        } catch(err:Any) {}
        try {
            var color03:Color = new Color(10, 30, 256);
            ensure(false);
        } catch(err:Any) {}
        // alpha should be between 0 and 100
        try {
            var color03:Color = new Color(10, 30, 80, -1);
            ensure(false);
        } catch(err:Any) {}
        try {
            var color03:Color = new Color(10, 30, 255, 101);
            ensure(false);
        } catch(err:Any) {}
    }

    /**
     * Test the toString method of the Color class.
     */
    public function testToString():Void {
        var color01:Color = new Color(10, 30, 255, 99);
        ensure(color01.toString() == "rgba(10,30,255,0.99)");
        var color02:Color = new Color(0, 8, 1);
        ensure(color02.toString() == "rgba(0,8,1,1)");
        var color03:Color = new Color(11, 2, 100, 0);
        ensure(color03.toString() == "rgba(11,2,100,0)");
        var color04:Color = new Color(5, 18, 215, 50);
        ensure(color04.toString() == "rgba(5,18,215,0.5)");
    }

    /**
     * Test the clone method of the Color class.
     */
    public function testClone():Void {
        var color01:Color = new Color(10, 33, 18, 11);
        var color02:Color = color01.clone();
        ensure(color02.getRed() == 10);
        ensure(color02.getGreen() == 33);
        ensure(color02.getBlue() == 18);
        ensure(color02.getAlpha() == 11);
    }

    /**
     * Test the equals method of the Color class.
     */
    public function testEquals():Void {
        var color01:Color = new Color(10, 33, 18, 11);
        var color02:Color = new Color(10, 33, 18, 11);
        var color03:Color = new Color(11, 33, 18, 11);
        var color04:Color = new Color(10, 34, 18, 11);
        var color05:Color = new Color(10, 33, 19, 11);
        var color06:Color = new Color(10, 33, 18, 10);
        ensure(color01.equals(color02)); // same -> true
        ensure(!color01.equals(color03)); // different red -> false
        ensure(!color01.equals(color04)); // different green -> false
        ensure(!color01.equals(color05)); // different blue -> false
        ensure(!color01.equals(color06)); // different alpha -> false
    }

    /**
     * Test the parse method of the Color class.
     */
    public function testParse():Void {
        var color01:Color = Color.parse("green");
        ensure(color01.toString() == "rgba(0,128,0,1)");
        var color02:Color = Color.parse("rgb(80,0,0)");
        ensure(color02.toString() == "rgba(80,0,0,1)");
        var color03:Color = Color.parse("rgba(80,0,10,0.3)");
        ensure(color03.toString() == "rgba(80,0,10,0.3)");
        var color04:Color = Color.parse("#0F0");
        ensure(color04.toString() == "rgba(0,255,0,1)");
        var color05:Color = Color.parse("#010");
        ensure(color05.toString() == "rgba(0,17,0,1)");
        var color06:Color = Color.parse("#123456");
        ensure(color06.toString() == "rgba(18,52,86,1)");
        var color07:Color = Color.parse("hsl(0,0,0)");
        ensure(color07.toString() == "rgba(0,0,0,1)");
        var color08:Color = Color.parse("hsla(0,0,0,1)");
        ensure(color08.toString() == "rgba(0,0,0,1)");
        try {
            var color08:Color = Color.parse("bla");
            ensure(false);
        } catch(err:Any) {}
    }

    /**
     * Run this test.
     */
    public override function run() {
        testConstructor();
        // getters and setters are tested in constructorTests, too
        testToString();
        testClone();
        testEquals();
        testParse();
    }
}
