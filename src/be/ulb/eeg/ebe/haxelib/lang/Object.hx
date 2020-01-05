/**
 * Copyright (c) 2020 Université libre de Bruxelles, eeg-ebe Department, Yann Spöri
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
package be.ulb.eeg.ebe.haxelib.lang;


/**
 * This class represents a single color.
 *
 * @author Yann Spoeri
 */
class Object
{
    /**
     * Check whether this object equals to another object.
     *
     * @return True if this object equals to another object,
     * false if this is not the case.
     */
    public function equals(o:Object):Bool {
        return o == this;
    }
    
    /**
     * Get an hashcode for this object.
     *
     * @return An hashcode value for this object.
     */
    public function hashCode():Int {
        // This is a bad default hashing function
        // so overwrite, if possible
        var s:String = Type.getClassName(Type.getClass(this));
        var result:Int = 0;
        for(i in 0...s.length) {
            result = result * 3 + s.charCodeAt(i);
        }
        return result;
    }
}