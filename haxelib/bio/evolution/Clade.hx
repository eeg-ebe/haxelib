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
package haxelib.bio.evolution;

/**
 * A Clade.
 *
 * @author Yann Spoeri
 */
class Clade implements IClade
{
    /**
     * The name of this clade.
     */
    private var mName:String;

    /**
     * The distance of this clade to the parental clade.
     */
    private var mDist:Float;

    /**
     * Possible child nodes.
     */
    private var mChilds:List<IClade>;

    /**
     * Create a new Clade.
     */
    public function new(?name:String, ?dist:Float) {
        mName = name;
        mDist = dist;
    }

    /**
     * The distance to the parent clade.
     *
     * @return The distance to the parent clade.
     */
    public function getDistance():Float {
        return mDist;
    }

    /**
     * Return the name of this clase.
     *
     * @return The result of this clade or null if this clade has no name.
     */
    public function getName():String {
        return mName;
    }

    /**
     * Return the clades connected to this clade.
     *
     * @return The clades connected to this clade.
     */
    public function getChilds():List<IClade> {
        return mChilds;
    }

    /**
     * Add a subclade as child.
     */
    public function addChild(subClade:IClade) {
        if (subClade == null) {
            return;
        }
        if (mChilds == null) {
            mChilds = new List<IClade>();
        }
        mChilds.add(subClade);
    }
}