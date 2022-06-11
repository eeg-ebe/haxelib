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
import haxelib.ds.set.StringSet;
import haxelib.iterators.EnumerateIterator;

/**
 * A midpoint router.
 *
 * @author Yann Spoeri
 */
class MidpointRooter extends BaseRooter
{
    /**
     * Create a new moidpoint rooter.
     */
    public function new() {
    }
    
    /**
     * Get distance and path between two points in a graph.
     */
    private function getPath(graph:StringGraph<Float>, start:String, stop:String, ?comeFrom:String=null):{ path: List<String>, length: Float } {
        for (connected in graph.getConnectedNodesWithValues(start)) {
            if (connected.node == comeFrom) {
                continue;
            }
            if (connected.node == stop) {
                var l:List<String> = new List<String>();
                l.add(stop);
                l.add(start);
                return {
                    path: l,
                    length: 0.0
                }
            }
            var result:{ path: List<String>, length: Float } = getPath(graph, connected.node, stop, start);
            if (result != null) {
                result.path.add(start);
                return { path: result.path, length: result.length + connected.val };
            }
        }
        return null;
    }

    /**
     * Get the longest path in a particular graph.
     */
    private function getLongestPath(graph:StringGraph<Float>):{ path: List<String>, length: Float } {
        var result:{ path: List<String>, length: Float } = null;
        var leafs:List<String> = graph.getLeafNodes();
        for (leaf1 in new EnumerateIterator<String>(leafs.iterator())) {
            for (leaf2 in new EnumerateIterator<String>(leafs.iterator())) {
                if (leaf1.idx <= leaf2.idx) {
                    break;
                }
                if (result == null) {
                    result = getPath(graph, leaf1.element, leaf2.element);
                } else {
                    var possiblyBetter:{ path: List<String>, length: Float } = getPath(graph, leaf1.element, leaf2.element);
                    if (possiblyBetter.length > result.length) {
                        result = possiblyBetter;
                    }
                }
            }
        }
        trace(result.path.join(","));
        return result;
    }
    
    /**
     * Get the point this rooter is using to root the graph.
     */
    public function getRootingPoint(graph:StringGraph<Float>):{ v1:String, v2:String } {
        var path:{ path: List<String>, length: Float } = getLongestPath(graph);
        if (path == null) {
            throw "No longest path found. Probably graph is empty or contains only one node?";
        }
        var midPointLength:Float = path.length / 2;
        var last:String = null;
        for (ele in path.path) {
            if (last != null) {
                var length:Float = graph.getEdge(ele, last);
                var midPointLength:Float = midPointLength - length;
                if (midPointLength < 0) {
                    return { v1: ele, v2: last };
                }
            }
            last = ele;
        }
        throw "Midpoint in path " + path.path.join(",") + " not found!";
    }
    
    public static function main() {
        var graph:StringGraph<Float> = new StringGraph<Float>();
        graph.addEdge("A", "X", 3);
        graph.addEdge("B", "X", 2);
        graph.addEdge("X", "Y", 5);
        graph.addEdge("Y", "C", 0.1);
        graph.addEdge("Y", "D", 1);
        var rooter:MidpointRooter = new MidpointRooter();
        var c:Clade = rooter.root(graph);
        trace(c.toDotString());
    }
}