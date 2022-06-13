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
package haxelib.gui.plotter;

import haxe.ds.Vector;
import haxelib.bio.phylo.Clade;
import haxelib.ds.set.StringSet;
import haxelib.gui.Color;
import haxelib.system.System;

/**
 * Assign colors to every clade.
 *
 * @author Yann Spoeri
 */
class CladeColorer
{
    /**
     * The colors to use.
     */
    private static var mColors:String = System.getProperty("CladeColorer.colors", "ORANGE,CYAN,GREEN,MAGENTA,RED,BLUE");
    
    /**
     * The neutral color to use.
     */
    private static var neutralColor:String = System.getProperty("CladeColorer.neutralColor", "BLACK");
    
    /**
     * Assign a color to the leafs.
     */
    private static function assignColorsToClades(c:Clade, parts:List<StringSet>, colors:Vector<Color>, neutralColor:Color):Void {
        if (c.isLeaf()) {
            var leafName:String = c.getName();
            var i:Int = 0;
            for (part in parts) {
                if (part != null && part.contains(leafName)) {
                    var color:Color = colors[i % colors.length];
                    c.setColor(color);
                    break;
                }
                ++i;
            }
        } else {
            for (child in c) {
                assignColorsToClades(child, parts, colors, neutralColor);
            }
            var color:Color = null;
            for (child in c) {
                var childColor:Color = child.getColor();
                if (color == null) {
                    color = childColor;
                } else if (! color.equals(childColor)) {
                    c.setColor(neutralColor);
                    return;
                }
            }
            c.setColor(color);
        }
    }
    
    /**
     * Color the clades by using a particular set of strings.
     */
    public static function colorClades(c:Clade, parts:List<StringSet>):Void {
        // parse colors
        var colorListStr:Array<String> = mColors.split(",");
        var colorList:Vector<Color> = new Vector<Color>(colorListStr.length);
        var i:Int = 0;
        for (color in colorListStr) {
            var c:Color = Color.parse(color);
            colorList[i] = c;
            ++i;
        }
        // parse neutral color
        var neutralColor:Color = Color.parse(neutralColor);
        // assign colors to clades
        assignColorsToClades(c, parts, colorList, neutralColor);
    }
}