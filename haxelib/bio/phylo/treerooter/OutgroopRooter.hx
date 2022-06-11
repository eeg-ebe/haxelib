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
import haxelib.ds.graph.StringGraph;

/**
 * An outgroop rooter.
 *
 * @author Yann Spoeri
 */
class OutgroopRooter
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
    public function getRootingPoint(graph:StringGraph<Float>):{ v1:String, v2:String } {
        if (! graph.hasNode(mOutgroop)) {
            throw "Outgroop " + mOutgroop + " not present in graph!";
        }
        var connected:List<String> = graph.getConnectedNodes(mOutgroop);
        if (connected.length != 1) {
            throw "Outgroop " + mOutgroop + " has multiple or no connections (" + connected.join(",") + ")!";
        }
        return {
            v1: mOutgroop,
            v2: connected.first()
        };
    }
    
    public static function main() {}
}