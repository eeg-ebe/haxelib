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
package be.ulb.eeg.ebe.haxelib.math;

/**
 * An Interface describing an option for an algorithm.
 *
 * @author Yann Spöri
 */
interface IOption
{
    /**
     * Get the name of this option.
     *
     * @return The name of this option.
     */
    public function getName():String;

    /**
     * Get the description for this option.
     *
     * @return A string which describes this option.
     */
    public function getDescription():String;

    /**
     * Get the value of this option.
     *
     * @return The value connected to this option.
     */
    public function getValue():Null<Dynamic>;

    /**
     * Get the default value of this option.
     *
     * @return Get the default value of this option.
     */
    public function getDefaultValue():Null<Dynamic>;

    /**
     * Whether this option has a default value.
     *
     * @return Wether this option has a default value.
     */
    public function hasDefaultValue():Bool;

    /**
     * Save the information of this option into an
     * XML representation.
     *
     * @return An XML representation of this option.
     */
    public function getXMLRepresentation():String;

    /**
     * Load the information of an XML representation.
     *
     * @param xml  The xml string to load this options
     * data from.
     */
    public function loadXMLRepresentation(xml:String):Void;

    /**
     * Check whether a certain xml string can get parsed
     * by an option of this type.
     *
     * @param xml  The xml string to check.
     * @return Whether a certain xml string can get parsed.
     */
    public function canParseXML(xml:String):Bool;
}
