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
package haxelib.iterators;

/**
 * Iterate over an iterator, but remember the current index for each element.
 *
 * @author Yann Spoeri
 */
class EnumerateIterator<E> 
{
    private var myIdx:Int;
    private var myIterator:Iterator<E>;
    
    public function new(it:Iterator<E>) {
        myIdx = 0;
        myIterator = it;
    }
    
    public function hasNext():Bool {
        return myIterator.hasNext();
    }
    
    public function next():{ idx:Int, element:E } {
        var result = {
            idx: myIdx,
            element: myIterator.next()
        };
        ++myIdx;
        return result;
    }
    
    public static function main() {
        var l:List<String> = new List<String>();
        l.add("A");
        l.add("B");
        l.add("C");
        l.add("D");
        for (e in new EnumerateIterator<String>(l.iterator())) {
            trace(e);
        }
    }
}
 