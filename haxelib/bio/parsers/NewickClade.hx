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
package haxelib.bio.parsers;

/**
 * A Newick clade.
 *
 * @author Yann Spoeri
 */
class NewickClade
{
    /**
     * The name of this clade.
     */
    public var name:String;
    
    /**
     * The extra information connected to this clade.
     */
    public var extraInformation:String;
    
    /**
     * The subClades of this clade.
     */
    public var subClades:List<NewickClade> = new List<NewickClade>();
    
    /**
     * Create a new NewickClade.
     */
    public function new(?myName:String, ?myExtraInformation:String, ?mySubClades:List<NewickClade>) {
        name = myName;
        extraInformation = myExtraInformation;
        subClades = mySubClades;
    }
}