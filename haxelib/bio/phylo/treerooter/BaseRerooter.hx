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
 * Base class for all tree rerooters.
 *
 * @author Yann Spoeri
 */
abstract class BaseRerooter
{
    /**
     * Get the point this rooter is using to root the graph.
     */
    abstract public function getRootingPoint(graph:Clade):Clade;
    
    /**
     * Do the rerooting.
     */
    public function reroot(graph:Clade):Clade {
        if (graph == null) {
            throw "No graph to root given!";
        }
        var point:Clade = getRootingPoint(graph);
        if (point == null) {
            throw "Rerooting point not found!";
        }
        if (point.getParent() == null) {
            // already rooted
            return point;
        }
        // need to reroot
        var result:Clade = new Clade();
        var child1:Clade = copyCladesDown(point);
        var child2:Clade = copyCladesUp(point.getParent(), point);
        child1.setDistance(child1.getDistance() / 2);
        child2.setDistance(child1.getDistance() / 2);
        result.addChild(child1);
        result.addChild(child2);
        return result;
    }
    
    /**
     * Copy the subhierarchy down.
     */
    private function copyCladesDown(c:Clade):Clade {
        var result:Clade = new Clade(c.getName(), c.getDistance(), c.getBootstrapValue());
        for (child in c) {
            var childClade:Clade = copyCladesDown(child);
            result.addChild(childClade);
        }
        return result;
    }
    
    /**
     * Copy the subhierarchy up.
     */
    private function copyCladesUp(current:Clade, comeFrom:Clade):Clade {
        var result:Clade = new Clade(current.getName(), 0, current.getBootstrapValue());
        for (child in current) {
            if (child == comeFrom) {
                continue;
            }
            var childClade:Clade = copyCladesDown(child);
            result.addChild(childClade);
        }
        var parent:Clade = current.getParent();
        if (parent != null) {
            var parentParent:Clade = parent.getParent();
            if (parentParent == null) {
                for (child in parent) {
                    if (child == current) {
                        continue;
                    }
                    var childClade:Clade = copyCladesDown(child);
                    childClade.setDistance(childClade.getDistance() + current.getDistance());
                    result.addChild(childClade);
                }
            } else {
                var childClade:Clade = copyCladesUp(parent, current);
                childClade.setDistance(current.getDistance());
                result.addChild(childClade);
            }
        }
        return result;
    }
}