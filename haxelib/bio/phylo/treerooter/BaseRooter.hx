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
 * Base class for all tree rooters.
 *
 * @author Yann Spoeri
 */
abstract class BaseRooter
{
    /**
     * Get the point this rooter is using to root the graph.
     */
    abstract public function getRootingPoint(graph:StringGraph<Float>):{ v1:String, v2:String };
    
    /**
     * Do the rooting.
     */
    public function root(graph:StringGraph<Float>):Clade {
        if (graph == null) {
            throw "No graph to root given!";
        }
        var rootPoint:{ v1:String, v2:String } = getRootingPoint(graph);
        if (rootPoint == null) {
            throw "Do not know where to root graph. RootingPoint is null!";
        }
        var edgeLength:Null<Float> = graph.getEdge(rootPoint.v1, rootPoint.v2);
        if (edgeLength == null) {
            throw "Edge to root at not found!";
        }
        var result:Clade("root");
        var child1:Clade = copyToClades(graph, rootPoint.v1, rootPoint.v2);
        var child2:Clade = copyToClades(graph, rootPoint.v2, rootPoint.v1);
        child1.setDistance(edgeLength / 2);
        child2.setDistance(edgeLength / 2);
        result.addChild(child1);
        result.addChild(child2);
        return result;
    }
    
    /**
     * Create subClades by using a graph as reference.
     */
    public function createSubClades(graph:StringGraph<Float>, node:String, comeFrom:String):Clade {
        var result:Clade = new Clade(node);
        for (connectedNodeAndValue in graph.getConnectedNodesWithValues(node)) {
            var connectedNode:String = connectedNodeAndValue.node;
            var value:Float = connectedNodeAndValue.val;
            if (connectedNode == comeFrom) {
                continue;
            }
            var child:Clade = createSubClades(graph, connectedNode, node); 
            child.setDistance(value);
            result.addChild(child);
        }
        return result;
    }
}