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

import haxe.ds.StringMap;
import haxe.ds.Vector;

/**
 * A graph implementation using strings as representation for nodes and edges.
 *
 * @author Yann Spoeri
 */
class StringGraph<E>
{
    /**
     * The nodes this graph consists of.
     */
    private var mNodes:StringMap<GraphNode<String,E>>;
    
    /**
     * Init the graph.
     */
    public function new(nodeInfo:Vector<String>=null) {
        mNodes = new StringMap<GraphNode<String,E>>();
        if (nodeInfo != null) {
            for (node in nodeInfo) {
                addNode(node);
            }
        }
    }
    
    /**
     * Check whether a particular node exists in this graph.
     */
    public inline function hasNode(s:String):Bool {
        return mNodes.exists(s);
    }
    
    /**
     * Add a particular node to this graph.
     */
    public inline function addNode(s:String):Bool {
        var result:Bool = false;
        if (!hasNode(s)) {
            var gn:GraphNode<String,E> = new GraphNode<String,E>(s);
            mNodes.set(s, gn);
            result = true;
        }
        return result;
    }
    
    /**
     * Add a new node.
     */
    public inline function addNextNode():String {
        var i:Int = 0;
        var name:String = "n" + i;
        while (hasNode(name)) {
            i++;
            name = "n" + i;
        }
        addNode(name);
        return name;
    }
    
    /**
     * Remove a particular node from this graph.
     */
    public inline function removeNode(s:String):Bool {
        var result:Bool = false;
        if (hasNode(s)) {
            var gn:GraphNode<String,E> = mNodes.get(s);
            gn.removeAllConnections();
            mNodes.remove(s);
            result = true;
        }
        return result;
    }
    
    /**
     * Get a list of all nodes in this graph.
     */
    public inline function getNodes():List<String> {
        var result:List<String> = new List<String>();
        for (s in mNodes.keys()) {
            result.add(s);
        }
        return result;
    }
    
    /**
     * Get a list of all leaf nodes in this graph.
     */
    public inline function getLeafNodes():List<String> {
        var result:List<String> = new List<String>();
        for (s in mNodes) {
            if (s.countConnections() <= 1) {
                result.add(s.getInfoElement());
            }
        }
        return result;
    }
    
    /**
     * Check whether this graph has an edge between two string nodes.
     */
    public inline function hasEdge(v1:String, v2:String):Bool {
        var result:Bool = false;
        if (hasNode(v1)) {
            if (hasNode(v2)) {
                var g1:GraphNode<String,E> = mNodes.get(v1);
                var g2:GraphNode<String,E> = mNodes.get(v2);
                if (g1.isConnectedTo(g2)) {
                    result = true;
                }
            }
        }
        return result;
    }
    
    /**
     * Get the value of an edge. This method returns null in case there is no such
     * edge in this graph. In order to distinguish whether there is no such edge in the
     * graph or whether the value of the edge is null, use the hasEdge function of this
     * graph object.
     */
    public inline function getEdge(v1:String, v2:String):E {
        var result:E = null;
        if (hasNode(v1)) {
            if (hasNode(v2)) {
                var g1:GraphNode<String,E> = mNodes.get(v1);
                var g2:GraphNode<String,E> = mNodes.get(v2);
                var connection:GraphEdge<String,E> = g1.getConnectionTo(g2);
                result = connection.getInfoElement();
            }
        }
        return result;
    }
    
    /**
     * Add an edge to this StringGraph.
     */
    public inline function addEdge(v1:String, v2:String, val:E):Void {
        addNode(v1);
        addNode(v2);
        var g1:GraphNode<String,E> = mNodes.get(v1);
        var g2:GraphNode<String,E> = mNodes.get(v2);
        g1.connectTo(g2, val);
    }
    
    /**
     * Remove an edge from this StringGraph.
     */
    public inline function removeEdge(v1:String, v2:String):Bool {
        var result:Bool = false;
        if (hasNode(v1)) {
            if (hasNode(v2)) {
                var g1:GraphNode<String,E> = mNodes.get(v1);
                var g2:GraphNode<String,E> = mNodes.get(v2);
                result = g1.removeConnection(g2);
            }
        }
        return result;
    }
    
    /**
     * Get connected nodes.
     */
    public inline function getConnectedNodes(s:String):List<String> {
        var result:List<String> = new List<String>();
        if (hasNode(s)) {
            var g:GraphNode<String,E> = mNodes.get(s);
            for (gn in g.getConnectedNodes()) {
                result.add(gn.getInfoElement());
            }
        }
        return result;
    }
    
    /**
     * Get connected nodes with values.
     */
    public inline function getConnectedNodesWithValues(s:String):List<{node:String, val:E}> {
        var result:List<{node:String, val:E}> = new List<{node:String, val:E}>();
        if (hasNode(s)) {
            var g:GraphNode<String,E> = mNodes.get(s);
            for (connection in g) {
                var otherNode:GraphNode<String,E> = connection.getOtherNode(g);
                var otherNodeName:String = otherNode.getInfoElement();
                var val:E = connection.getInfoElement();
                var ele = {
                    node: otherNodeName,
                    val: val
                };
                result.add(ele);
            }
        }
        return result;
    }
    
    /**
     * Get a textual representation of this graph.
     */
    public inline function toString():String {
        var result:List<String> = new List<String>();
        result.add("graph {");
        // map ints to every node
        var map:StringMap<Int> = new StringMap<Int>();
        var val:Int = 0;
        for (nodeName in mNodes.keys()) {
            map.set(nodeName, val);
            result.add("  " + val + " [label=\"" + nodeName + "\"];");
            val++;
        }
        // now output every connection
        var seen:StringMap<Bool> = new StringMap<Bool>();
        for (node in mNodes.keys()) {
            var nodeInt:Int = map.get(node);
            for (con in getConnectedNodesWithValues(node)) {
                var otherNode:String = con.node;
                if (seen.exists(otherNode)) {
                    continue;
                }
                var nodeInt2:Int = map.get(otherNode);
                var val:E = con.val;
                result.add("  " + nodeInt + " -- " + nodeInt2 + " [label=\"" + val + "\"];");
            }
            seen.set(node, true);
        }
        result.add("}");
        return result.join("\n");
    }
    
    public static function main() {
        var graph:StringGraph<String> = new StringGraph<String>();
        // hasNode
        assert(false, graph.hasNode("a"));
        graph.addNode("a");
        assert(true, graph.hasNode("a"));
        graph.removeNode("a");
        assert(false, graph.hasNode("a"));
        // addNode
        assert(true, graph.addNode("a"));
        assert(false, graph.addNode("a"));
        assert(true, graph.addNode("b"));
        assert(false, graph.addNode("b"));
        // removeNode
        assert(true, graph.removeNode("a"));
        assert(false, graph.removeNode("a"));
        assert(true, graph.removeNode("b"));
        assert(false, graph.removeNode("b"));
        // getNodes
        assert(0, graph.getNodes().length);
        graph.addNode("a");
        assert(1, graph.getNodes().length);
        graph.addNode("b");
        assert(2, graph.getNodes().length);
        graph.addNode("c");
        assert(3, graph.getNodes().length);
        // getLeafNodes
        graph.removeNode("a");
        graph.removeNode("b");
        graph.removeNode("c");
        assert(0, graph.getNodes().length);
        graph.addNode("a");
        assert(1, graph.getNodes().length);
        graph.addNode("b");
        assert(2, graph.getNodes().length);
        graph.addNode("c");
        assert(3, graph.getNodes().length);
        // hasEdge
        assert(false, graph.hasEdge("a", "b"));
        graph.addEdge("a", "b", "val");
        assert(true, graph.hasEdge("a", "b"));
        assert(true, graph.hasEdge("b", "a"));
        graph.removeEdge("a", "b");
        assert(false, graph.hasEdge("a", "b"));
        graph.addEdge("b", "a", "val");
        assert(true, graph.hasEdge("a", "b"));
        assert(true, graph.hasEdge("b", "a"));
        graph.removeEdge("b", "a");
        assert(false, graph.hasEdge("a", "b"));
        assert(false, graph.hasEdge("b", "a"));
        // getEdge
        graph.addEdge("b", "a", "val1");
        assert("val1", graph.getEdge("b", "a"));
        graph.addEdge("b", "a", "val2");
        assert("val2", graph.getEdge("b", "a"));
        assert(null, graph.getEdge("xxx", "yyy"));
        // removeNode 2
        graph.removeNode("a");
        graph.removeNode("b");
        graph.removeNode("c");
        graph.addEdge("a", "b", "val");
        graph.addEdge("a", "c", "val");
        graph.addEdge("a", "d", "val");
        graph.addEdge("a", "e", "val");
        graph.removeNode("a");
        // getConnectedNodes
        graph.addEdge("a", "b", "val");
        graph.addEdge("a", "c", "val");
        graph.addEdge("a", "d", "val");
        graph.addEdge("a", "e", "val");
        assert(4, graph.getConnectedNodes("a").length);
        assert(4, graph.getConnectedNodesWithValues("a").length);
        // addNextNode
        var size:Int = graph.getNodes().length;
        graph.addNextNode();
        var nextSize:Int = graph.getNodes().length;
        assert(size+1, nextSize);
    }
    private static function assert(expected:Dynamic, got:Dynamic) {
        if (expected != got) {
            throw "Expected: " + expected + " but got: " + got;
        }
    } 
}