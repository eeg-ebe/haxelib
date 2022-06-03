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
 * A single node of the graph.
 *
 * @author Yann Spoeri
 */
class GraphNode<V,E>
{
    /**
     * The element connected to this node.
     */
    private var mInfo:V;
    
    /**
     * The edges connected to this node.
     */
    private var mEdges:List<GraphEdge<V,E>>;
    
    /**
     * Create a new GraphNode.
     */
    public function new(info:V) {
        setInfoElement(info);
        mEdges = new List<GraphEdge<V,E>>();
    }
    
    /**
     * Get the info element of this edge.
     */
    public inline function getInfoElement():V {
        return mInfo;
    }
    
    /**
     * Set the info element of this edge.
     */
    public inline function setInfoElement(info:V):Void {
        mInfo = info;
    }
    
    /**
     * Check whether this node is connected to a particular node.
     */
    public inline function isConnectedTo(other:GraphNode<V,E>):Bool {
        return getConnectionTo(other) != null;
    }
    
    /**
     * Get the connection to a particular node. Will return null in case there is no such connection.
     */
    public inline function getConnectionTo(other:GraphNode<V,E>):GraphEdge<V,E> {
        var result:GraphEdge<V,E> = null;
        for (edge in mEdges) {
            if (edge.connectedTo(other)) {
                result = edge;
                break;
            } 
        }
        return result;
    }
    
    /**
     * Connect this graph node to another graph node.
     */
    public inline function connectTo(other:GraphNode<V,E>, e:E):Bool {
        if (isConnectedTo(other)) {
            return false;
        }
        var edge:GraphEdge<V,E> = new GraphEdge<V,E>(this, other, e);
        mEdges.add(edge);
        other.mEdges.add(edge);
        return true;
    }
    
    /**
     * Remove all connections.
     */
    public inline function removeAllConnections() {
        while (!mEdges.isEmpty()) {
            var toRemove = mEdges.pop();
            var other:GraphNode<V,E> = toRemove.getOtherNode(this);
            mEdges.remove(toRemove);
            other.mEdges.remove(toRemove);
        }
    }
    
    /**
     * Remove a particular connection.
     */
    public inline function removeConnection(other:GraphNode<V,E>):Bool {
        var result:Bool = false;
        var toRemove:GraphEdge<V,E> = null;
        for (edge in mEdges) {
            if (edge.connectedTo(other)) {
                toRemove = edge;
                break;
            }
        }
        if (toRemove != null) {
            mEdges.remove(toRemove);
            other.mEdges.remove(toRemove);
            result = true;
        }
        return result;
    }
    
    /**
     * Count the number of connections connected to this GraphNode.
     */
    public inline function countConnections():Int {
        return mEdges.length;
    }
    
    /**
     * Get an array of GraphNodes, this node is connected to.
     */
    public inline function getConnectedNodes():List<GraphNode<V,E>> {
        var result:List<GraphNode<V,E>> = new List<GraphNode<V,E>>();
        for (edge in mEdges) {
            result.add(edge.getOtherNode(this));
        }
        return result;
    }
    
    /**
     * Iterate over the connection of this node.
     */
    public inline function iterator():Iterator<GraphEdge<V,E>> {
        return mEdges.iterator();
    }
}