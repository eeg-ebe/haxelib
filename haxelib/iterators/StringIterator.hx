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
package haxelib.iterators;

/**
 * A String iterator (to iterate over the different characters of a string.
 *
 * @copyed from https://haxe.org/manual/lf-iterators.html
 */
class StringIterator
{
    var s:String;
    var i:Int;

    public function new(s:String) {
        this.s = s;
        this.i = 0;
    }

    public function hasNext() {
        return i < s.length;
    }

    public function next() {
        return s.charAt(i++);
    }
}
