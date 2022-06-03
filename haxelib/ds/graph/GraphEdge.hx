/**
 * Copyright (c) 2022 Université libre de Bruxelles, eeg-ebe Department, Yann Spöri
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
package haxelib.ds.graph;

/**
 * An edge in a graph.
 *
 * @author Yann Spoeri
 */
class GraphEdge<V,E>
{
    /**
     * The first node this edge is connected to.
     */
    private var mNode1:GraphNode<V,E>;
    
    /**
     * The second node this edge is connected to.
     */
    private var mNode2:GraphNode<V,E>;

    /**
     * The element connected to this edge.
     */
    private var mInfo:E;
    
    /**
     * Create a new GraphEdge object.
     */
    public function new(node1:GraphNode<V,E>, node2:GraphNode<V,E>, info:E) {
        mNode1 = node1;
        mNode2 = node2;
        setInfoElement(info);
    }
    
    /**
     * Get the info element of this edge.
     */
    public inline function getInfoElement():E {
        return mInfo;
    }
    
    /**
     * Set the info element of this edge.
     */
    public inline function setInfoElement(info:E):Void {
        mInfo = info;
    }
    
    /**
     * Get the first node of this edge.
     */
    public inline function getFirstNode():GraphNode<V,E> {
        return mNode1;
    }
    
    /**
     * Get the second node of this edge.
     */
    public inline function getSecondNode():GraphNode<V,E> {
        return mNode2;
    }
    
    /**
     * Check whether this edge is connected to a particular node.
     */
    public inline function connectedTo(n:GraphNode<V,E>):Bool {
        return n == mNode1 || n == mNode2;
    }
    
    /**
     * Get the other node connected to this node.
     */
    public inline function getOtherNode(n:GraphNode<V,E>):GraphNode<V,E> {
        var result:GraphNode<V,E> = null;
        if (n == mNode1) {
            result = mNode2;
        } else if (n == mNode2) {
            result = mNode1;
        } else {
            throw "Node " + n + " not connected to this edge, but " + mNode1 + " -- " + mNode2 + "!";
        }
        return result;
    }
    
    /**
     * Get a textual representation of this edge.
     */
    public function toString() {
        return "  " + mNode1 + " -- " + mNode2 + " (" + mInfo + ")";
    }
}