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
package haxelib.bio.phylo;

import haxe.ds.StringMap;
import haxelib.gui.Color;

/**
 * A Clade.
 *
 * @author Yann Spoeri
 */
class Clade
{
    /**
     * The name of this clade.
     */
    private var mName:String;
    
    /**
     * The distance to the parental clade.
     */
    private var mDistance:Float;
    
    /**
     * The bootstrap value of this clade.
     */
    private var mBootstrapValue:Float;
    
    /**
     * The color of this clade (for plotting).
     */
    private var mColor:Color;
    
    /**
     * Extra information to output (in case this clade is plotted).
     */
    private var mOutput:List<String>;
    
    /**
     * Additional info connected to this clade.
     */
    private var mConnectedInfo:StringMap<Dynamic>;
    
    /**
     * A reference to the parent clade.
     */
    private var mParent:Null<Clade>;
    
    /**
     * A list of child clades.
     */
    private var mChilds:List<Clade>;
    
    /**
     * Create a new Clade.
     */
    public function new(?name:String=null, ?dist:Float=1, ?bootstrap:Float=1, ?color:Color=null) {
        setName(name);
        setDistance(dist);
        setBootstrapValue(bootstrap);
        setColor(color);
        mOutput = new List<String>();
        mConnectedInfo = new StringMap<Dynamic>();
        mChilds = new List<Clade>();
    }
    
    /**
     * Get the name of this clade.
     */
    public function getName():String {
        return mName;
    }
    
    /**
     * Set the name of this clade.
     */
    public function setName(s:String):Void {
        mName = (s == null) ? "" : s;
    }
    
    /**
     * Get the distance of this clade to the parental clade.
     */
    public function getDistance():Float {
        return mDistance;
    }
    
    /**
     * Set the distance of this clade to the parental clade.
     */
    public function setDistance(d:Float):Void {
        if (d < 0) {
            throw "Distance must be positive, not " + d + "!";
        }
        mDistance = d;
    }
    
    /**
     * Get the bootstrap value of this clade.
     */
    public function getBootstrapValue():Float {
        return mBootstrapValue;
    }
    
    /**
     * Set the bootstrap value of this clade.
     */
    public function setBootstrapValue(b:Float):Void {
        if (0 <= b && b <= 1) {
            mBootstrapValue = b;
        } else {
            throw "Bootstrap value must be between 0 and 1, not " + b + "!";
        }
    }
    
    /**
     * Get the color of this clade.
     */
    public function getColor():Color {
        return mColor.clone();
    }
    
    /**
     * Set the color of this clade.
     */
    public function setColor(color:Color):Void {
        mColor = (color == null) ? Color.parse("BLACK") : color;
    }
    
    /**
     * Get the additional clade output.
     */
    public function getOutput():String {
        return mOutput.join("\n");
    }
    
    /**
     * Add output to the additional clade output list.
     */
    public function addOutput(s:String):Void {
        mOutput.add(s);
    }
    
    /**
     * Additional information may be stored for each clade. With this method you
     * may access the different information.
     */
    public function getInfo(info:String):Null<Dynamic> {
        return mConnectedInfo.get(info);
    }
    
    /**
     * Strore additional information to this clade.
     */
    public function setInfo(info:String, val:Dynamic):Void {
        mConnectedInfo.set(info, val);
    }
    
    /**
     * Remove additional information to this clade.
     */
    public function removeInfo(info:String):Void {
        mConnectedInfo.remove(info);
    }
    
    /**
     * Check whether a particular info is connected to this clade.
     */
    public function checkInfo(info:String):Bool {
        return mConnectedInfo.exists(info);
    }
    
    /**
     * Get the parental clade.
     */
    public function getParent():Clade {
        return mParent;
    }
    
    /**
     * Iterate over the child clades.
     */
    public function iterator():Iterator<Clade> {
        return mChilds.iterator();
    }
    
    /**
     * Add a child clade.
     */
    public function addChild(c:Clade):Void {
        if (c.mParent != null) {
            throw "Clade already has a parental clade!";
        }
        mChilds.add(c);
        c.mParent = this;
    }
    
    /**
     * Check whether this is a root clade.
     */
    public function isRoot():Bool {
        return mParent == null;
    }
    
    /**
     * Check whether this is a leaf clade.
     */
    public function isLeaf():Bool {
        return mChilds.isEmpty();
    }
    
    /**
     * Count the number of child clades.
     */
    public function countChilds():Int {
        return mChilds.length;
    }
    
    public static function main() {}
}
