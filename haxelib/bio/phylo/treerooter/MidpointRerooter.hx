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
 * Implementation of a midpoint rerooter.
 *
 * @author Yann Spoeri
 */
class MidpointRerooter extends BaseRerooter
{
    /**
     * Create a new midpoint rerooter.
     */
    public function new() {
    }

    /**
     * Get distance and path between two points in a graph.
     */
    private function getLongestPath(current:Clade, fromClade:Clade, length:Float):{ path:List<Clade>, length:Float } {
        // get all possible ways to follow
        var ways:List<{c:Clade, l:Float}> = new List<{c:Clade, l:Float}>();
        for (child in current) {
            if (child != fromClade) {
                ways.add({c:child, l:child.getDistance()});
            }
        }
        var parent:Clade = current.getParent();
        if (parent != null && parent != fromClade) {
            ways.add({c:parent, l:current.getDistance()});
        }
        // check which way gives the longest connection
        if (ways.isEmpty()) {
            var path:List<Clade> = new List<Clade>();
            path.add(current);
            if (fromClade != null) {
                path.add(fromClade);
            }
            return {
                path: path,
                length: length
            };
        } else {
            var currentBestPath:List<Clade> = null;
            var currentBestLength:Float = -1;
            for (way in ways) {
                var previousResult:{ path:List<Clade>, length:Float } = getLongestPath(way.c, current, length + way.l);
                if (previousResult.length > currentBestLength) {
                    currentBestPath = previousResult.path;
                    if (fromClade != null) {
                        currentBestPath.add(fromClade);
                    }
                    currentBestLength = previousResult.length;
                }
            }
            return {
                path: currentBestPath,
                length: currentBestLength
            }
        }
    }

    /**
     * Get distance and path between two points in a graph.
     */
    private function getLongestPathInTree(tree:Clade):{ path:List<Clade>, length:Float } {
        var currentLongestPath:List<Clade> = new List<Clade>();
        var currentLongestPathLength:Float = 0;
        for (leaf in tree.getLeafs()) {
            var pathAndLength:{ path:List<Clade>, length:Float } = getLongestPath(leaf, null, 0);
            if (pathAndLength.length > currentLongestPathLength) {
                currentLongestPath = pathAndLength.path;
                currentLongestPathLength = pathAndLength.length;
            }
        }
        return {
            path: currentLongestPath,
            length: currentLongestPathLength
        };
    }
    
    /**
     * Get the length between two clades.
     */
    public function getLengthBetweenClades(c1:Clade, c2:Clade):Float {
        if (c1.getParent() == c2) {
            return c1.getDistance();
        } else if (c2.getParent() == c1) {
            return c2.getDistance();
        } else {
            throw "Clades " + c1 + " " + c2 + " not connected!";
        }
    }
    
    /**
     * Get the point this rooter is using to root the graph.
     */
    public function getRootingPoint(clade:Clade):Clade {
        if (clade == null) {
            throw "No longest path found. Tree is null";
        }
        var pathAndLength:{ path:List<Clade>, length:Float } = getLongestPathInTree(clade);
        if (pathAndLength == null) {
            throw "No longest path found. Probably graph is empty or contains only one node?";
        }
        var midPointLength:Float = pathAndLength.length / 2;
        var last:Clade = null;
        for (ele in pathAndLength.path) {
            if (last != null) {
                var length:Float = getLengthBetweenClades(ele, last);
                midPointLength = midPointLength - length;
                if (midPointLength < 0) {
                    if (ele.getParent() == last) {
                        return ele;
                    } else if (last.getParent() == ele) {
                        return last;
                    } else {
                        throw "Something is wrong here " + ele + " vs " + last + "!";
                    }
                }
            }
            last = ele;
        }
        throw "Midpoint in path " + pathAndLength.path.join(",") + " not found!";
    }
    
    public static function main() {
        var cA:Clade = new Clade("A", 3);
        var cB:Clade = new Clade("B", 1);
        var cC:Clade = new Clade("C", 1);
        var cD:Clade = new Clade("D", 1);
        var cE:Clade = new Clade("E", 1);
        var cF:Clade = new Clade("F", 1);
        var cG:Clade = new Clade("G", 1.2);
        var c1:Clade = new Clade("C1", 1);
        var c2:Clade = new Clade("C2", 1);
        var c3:Clade = new Clade("C3", 1);
        var c4:Clade = new Clade("C4", 1);
        var c5:Clade = new Clade("C5", 1);
        var c6:Clade = new Clade("C6", 1);
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
        var rerooter = new MidpointRerooter();
        var root:Clade = rerooter.reroot(c6);
        trace(root.toNewickString());
    }
}