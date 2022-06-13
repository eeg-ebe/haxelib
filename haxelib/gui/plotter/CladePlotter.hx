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

import haxelib.bio.phylo.Clade;
import haxelib.iterators.EnumerateIterator;
import haxelib.system.System;

/**
 * Class to plot a clade system.
 *
 * @author Yann Spoeri
 */
class CladePlotter
{
    /**
     * Plotting settings.
     */
    private var mBorderDistLeft:Int = System.getIntProperty("CladePlotter.borderDistLeft", 5);
    private var mBorderDistRight:Int = System.getIntProperty("CladePlotter.borderDistRight", 5);
    private var mBorderDistUp:Int = System.getIntProperty("CladePlotter.borderDistUp", 5);
    private var mBorderDistDown:Int = System.getIntProperty("CladePlotter.borderDistDown", 5);
    private var mTextPrintMarginX:Int = System.getIntProperty("CladePlotter.textPrintMarginX", 5);
    private var mTextPrintMarginY:Int = System.getIntProperty("CladePlotter.textPrintMarginY", 5);
    private var mTextFontName:String = System.getProperty("CladePlotter.textFontName", "Courier New");
    private var mTextUseCladeColorAsTextColor:Bool = System.getBoolProperty("CladePlotter.useCladeColorAsTextColor", false);
    private var mLineWidth:Int = System.getIntProperty("CladePlotter.lineWidth", 1);
    private var mPrintName:Bool = System.getBoolProperty("CladePlotter.printName", true);
    private var mPrintOutput:Bool = System.getBoolProperty("CladePlotter.printOutput", true);
    private var mNameTextSize:Int = System.getIntProperty("CladePlotter.nameTextSize", 14);
    private var mNameTextColor:String = System.getProperty("CladePlotter.nameTextColor", "black");
    private var mOutputTextSize:Int = System.getIntProperty("CladePlotter.outputTextSize", 12);
    private var mOutputTextColor:String = System.getProperty("CladePlotter.nameTextColor", "grey");
    
    private var mDistStretchAutoCalculation:Bool = System.getBoolProperty("CladePlotter.distStretchAuto", true);
    private var mDistStretch:Float = System.getFloatProperty("CladePlotter.distOutputAndLine", 120);
    private var mDistSubCladeAndSubClade = System.getIntProperty("CladePlotter.subCladeToSubCladeDist", 5);
    
    /**
     * Create a new plotter.
     */
    public function new() {}
    
    /**
     * Paint text.
     */
    public function paintText(result:List<String>, x:Float, y:Float, text:String, size:Int, color:String):{ w:Float, h:Float, midPoint:Float } {
        if (text == null || text == "") {
            return { w: 0, h: 0, midPoint: y };
        }
        var mx:Float = x + mTextPrintMarginX;
        var w:Float = 0;
        var h:Float = mTextPrintMarginY;
        var lines:Array<String> = text.split("\n");
        for (line in lines) {
            w = line.length * size;
            var escapedText = StringTools.htmlEscape(line, true);
            h += size;
            var my:Float = y + h;
            result.add("<text x='" + mx + "' y='" + my + "' font-size='" + size + "' fill='" + color + "'>" + escapedText + "</text>");
        }
        h += mTextPrintMarginY;
        return { w: w, h: h, midPoint: y + mTextPrintMarginY + size / 2 };
    }
    
    /**
     * Paint the text of a particular clade.
     */
    private function paintTextOfClade(result:List<String>, c:Clade, x:Float, y:Float ):{ w:Float, h:Float, midPoint:Float } {
        var w:Float = 0;
        var h:Float = 0;
        var midPoint:Float = 0;
        var name:String = c.getName();
        var color1:String = (mTextUseCladeColorAsTextColor) ? c.getColor().toString() : mNameTextColor;
        var nameSize:{ w:Float, h:Float, midPoint:Float } = paintText(result, x, y, name, mNameTextSize, color1);
        w += nameSize.w;
        h += nameSize.h;
        midPoint = nameSize.midPoint;
        var output:String = c.getOutput();
        var color2:String = (mTextUseCladeColorAsTextColor) ? c.getColor().toString() : mNameTextColor;
        var outputSize:{ w:Float, h:Float, midPoint:Float } = paintText(result, x, y + h, output, mOutputTextSize, color2);
        w += outputSize.w;
        h += outputSize.h;
        return { w: w, h: h, midPoint: midPoint };
    }
    
    /**
     * Paint a subclade.
     */
    private function paintClade(result:List<String>, c:Clade, x:Float, y:Float, distStretch:Float):{ w:Float, h:Float, midPoint:Float } {
        if (c.isLeaf()) {
            var distance:Float = c.getDistance();
            var color:String = c.getColor().toString();

            var textOutputStartX = x + distance * distStretch;
            var textOutputStartY = y + mDistSubCladeAndSubClade;
            var textOutputSize:{ w:Float, h:Float, midPoint:Float } = paintTextOfClade(result, c, textOutputStartX, textOutputStartY);
            
            result.add("<line x1='" + x + "' y1='" + textOutputSize.midPoint + "' x2='" + textOutputStartX + "' y2='" + textOutputSize.midPoint + "' title='" + distance + "' style='stroke:" + color + "'/>");

            var w:Float = distance * distStretch + textOutputSize.w;
            var h:Float = textOutputSize.h + (mDistSubCladeAndSubClade << 1);
            return { w: w, h: h, midPoint: textOutputSize.midPoint };
        } else {
            var distance:Float = c.getDistance();
            var color:String = c.getColor().toString();
            
            var w:Float = distance * distStretch;
            
            var childPlotStartX:Float = x + distance * distStretch;
            var childPlotStartY:Float = y;
            
            var firstMidPoint:Float = 0;
            var lastMidPoint:Float = 0;
            
            var first:Bool = true;
            for (child in c) {
                var size:{ w:Float, h:Float, midPoint:Float } = paintClade(result, child, childPlotStartX, childPlotStartY, distStretch);
                w = Math.max(w, size.w + distance * distStretch);
                childPlotStartY += size.h;
                lastMidPoint = size.midPoint;
                
                if (first) {
                    firstMidPoint = size.midPoint;
                    
                    var textOutputSize:{ w:Float, h:Float, midPoint:Float } = paintTextOfClade(result, c, childPlotStartX, childPlotStartY);
                    w = Math.max(w, textOutputSize.w + distance * distStretch);
                    childPlotStartY += textOutputSize.h;
                    
                    first = false;
                }
            }
            
            var h:Float = childPlotStartY - y;
            var midPoint:Float = (firstMidPoint + lastMidPoint) / 2;
            
            result.add("<line x1='" + childPlotStartX + "' y1='" + firstMidPoint + "' x2='" + childPlotStartX + "' y2='" + lastMidPoint + "' style='stroke:" + color + "'/>");
            result.add("<line x1='" + x + "' y1='" + midPoint + "' x2='" + childPlotStartX + "' y2='" + midPoint + "' style='stroke:" + color + "'/>");
            
            return {
                w: w,
                h: h,
                midPoint: midPoint
            }
        }
    }
    
    /**
     * Get all distances.
     */
    private function getDistances(c:Clade):Array<Float> {
        var result:Array<Float> = new Array<Float>();
        if (! c.isRoot()) {
            result.push(c.getDistance());
        }
        for (child in c) {
            result.push(child.getDistance());
        }
        return result;
    }
    
    /**
     * Get shortest distance.
     */
    private function getMedianDistance(c:Clade):Float {
        var dists:Array<Float> = getDistances(c);
        dists.sort((a, b) -> {
            if (a == b) return 0;
            if (a > b) return 1;
            return -1;
        });
        if (dists.length == 0) {
            return 0;
        } else {
            var midPoint:Int = Math.ceil(dists.length / 2);
            for (ele in new EnumerateIterator<Float>(dists.iterator())) {
                if (ele.idx == midPoint) {
                    return ele.element;
                }
            }
            return 0;
        }
    }
    
    /**
     * Calculate a useful stretch factor.
     */
    private function calcStretch(c:Clade):Float {
        var dist:Float = getMedianDistance(c);
        if (dist == 0) {
            return mDistStretch;
        }
        return 100 / dist;
    }
    
    /**
     * Plot a particular clade.
     */
    public function plotClade(c:Clade):String {
        var innerSvgCodeAsList:List<String> = new List<String>();
        
        var distStretch:Float = (mDistStretchAutoCalculation)? calcStretch(c) : mDistStretch;
        var size:{ w:Float, h:Float, midPoint:Float } = paintClade(innerSvgCodeAsList, c, mBorderDistLeft, mBorderDistUp, distStretch);
        
        var innerSvgCode:String = innerSvgCodeAsList.join("");
        var width:Float = size.w + mBorderDistLeft + mBorderDistRight;
        var height:Float = size.h + mBorderDistUp + mBorderDistDown;
        
        var result:List<String> = new List<String>();
        result.add("<svg version='1.1' baseProfile='full' width='" + width + "' height='" + height + "' xmlns='http://www.w3.org/2000/svg'>");
        result.add("<g style='stroke-width:" + mLineWidth + "' font-family='" + mTextFontName + "' text-anchor='start'>");
        result.add(innerSvgCode);
        result.add("</g>");
        result.add("</svg>");
        return result.join("");
    }
    
    public static function main() {
        var cA:Clade = new Clade("A");
        cA.addOutput("A1 text");
        cA.addOutput("A2 text");
        cA.addOutput("A3 text");
        var cB:Clade = new Clade("B");
        var cC:Clade = new Clade("C");
        var cD:Clade = new Clade("D");
        var cE:Clade = new Clade("E");
        var cF:Clade = new Clade("F");
        var cG:Clade = new Clade("G");
        var c1:Clade = new Clade("C1");
        var c2:Clade = new Clade("C2");
        var c3:Clade = new Clade("C3");
        var c4:Clade = new Clade("C4");
        var c5:Clade = new Clade("C5");
        c5.setColor(Color.parse("red"));
        var c6:Clade = new Clade("C6");
        c1.addChild(cA);
        c1.addChild(cB);
        c2.addChild(cD);
        c2.addChild(cE);
        c3.addChild(cF);
        c3.addChild(cG);
        c4.addChild(c1);
        c4.addChild(cC);
        c5.addChild(c2);
        c5.addChild(c3);
        c6.addChild(c4);
        c6.addChild(c5);
        var plotter:CladePlotter = new CladePlotter();
        var result:String = plotter.plotClade(c6);
        trace(result);
    }
}