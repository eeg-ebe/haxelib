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
package haxelib.bio.phylo.treerooter;

import haxelib.bio.phylo.Clade;

/**
 * Implementation of an outgroop rerooter.
 *
 * @author Yann Spoeri
 */
class OutgroopRerooter extends BaseRerooter
{
    /**
     * The name of the outgroop.
     */
    private var mOutgroop:String;
    
    /**
     * Create a new outgroop rooter.
     */
    public function new(outgroop) {
        mOutgroop = outgroop;
    }

    /**
     * Get the point this rooter is using to root the graph.
     */
    public function getRootingPoint(clade:Clade):Clade {
        if (clade.getName() == mOutgroop) {
            return clade;
        }
        for (child in clade) {
            var result:Clade = getRootingPoint(child);
            if (result != null) {
                return result;
            }
        }
        return null;
    }
    
    public static function main() {
        var cA:Clade = new Clade("A");
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
        trace(c6.toNewickString());
        var rerooter = new OutgroopRerooter("D");
        var root:Clade = rerooter.reroot(c6);
        trace(root.toNewickString());
    }
}