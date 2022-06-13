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

/**
 * A CladeCombiner. This class combines every class (collapse them) which
 * do not have the needed bootstrap support or when the distance between two sister clades is 0.
 *
 * @author Yann Spoeri
 */
class CladeCombiner
{
    /**
     * The bootstrap support value needed.
     */
    private var mBootstrapSupportNeeded:Float;

    /**
     * Create a new CladeCombiner.
     */
    public function new(?bootstrap=0.7) {
        setBootstrapSupportNeeded(bootstrap);
    }

    /**
     * Get the bootstrap support needed.
     */
    public function getBootstrapSupportNeeded():Float {
        return mBootstrapSupportNeeded;
    }

    /**
     * Set the bootstrap support needed.
     */
    public function setBootstrapSupportNeeded(bootstrap:Float):Void {
        mBootstrapSupportNeeded = bootstrap;
    }
    
    /**
     * Collapse clades.
     */
    public function collapseClades(c:Clade):Clade {
        var myLst:List<Clade> = collapse(c);
        if (myLst.length == 0) {
            throw "Missing clades!";
        } else if (myLst.length == 1) {
            return myLst.first();
        }
        var root:Clade = new Clade();
        for (e in myLst) {
            root.addChild(e);
        }
        return root;
    }
    private function collapse(c:Clade):List<Clade> {
        var result:List<Clade> = new List<Clade>();
        if (c.isLeaf()) {
            var clade:Clade = new Clade(c.getName(), c.getDistance(), c.getBootstrapValue());
            result.add(clade);
        } else {
            if (c.getBootstrapValue() >= mBootstrapSupportNeeded) {
                var clade:Clade = new Clade(c.getName(), c.getDistance(), c.getBootstrapValue());
                for (child in c) {
                    var collapsed:List<Clade> = collapse(child);
                    for (ele in collapsed) {
                        clade.addChild(ele);
                    }
                }
                result.add(clade);
            } else {
                var additioalDist:Float = c.getDistance();
                for (child in c) {
                    var collapsed:List<Clade> = collapse(child);
                    for (ele in collapsed) {
                        ele.setDistance(ele.getDistance() + additioalDist);
                        result.add(ele);
                    }
                }
            }
        }
        return result;
    }
}