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
package be.ulb.eeg.ebe.haxelib.tests;

import be.ulb.eeg.ebe.haxelib.lang.Object;

import be.ulb.eeg.ebe.haxelib.logging.BaseLogger;
import be.ulb.eeg.ebe.haxelib.logging.Log;

/**
 * An object of this class represents a single failure.
 *
 * @author Yann Spoeri
 */
class Failure extends Object
{
    /**
     * A possible description explaining the failure.
     */
    private var mDescription:String;

    /**
     * The line number where the failure occurred.
     */
    private var mLineNumber:Int;

    /**
     * The name of the method where the failure occurred.
     */
    private var mMethod:String;

    /**
     * The name of the class where the failure occurred.
     */
    private var mClassName:String;

    /**
     * Create a new failure object.
     *
     * @param description    A description for that failure (or null).
     * @param lineNumber     The line number where the failure occurred.
     * @param method         The name of the method where the failure occurred.
     * @param className      The name of the class where the failure occurred.
     */
    public function new(description:String, lineNumber:Int, method:String, className:String) {
        mDescription = description;
        mLineNumber = lineNumber;
        mMethod = method;
        mClassName = className;
    }

    /**
     * Return the description of this failure.
     *
     * @return The description of this failure.
     */
    public function getDescription():String {
        return mDescription;
    }

    /**
     * Return the line number where this failure occurred.
     *
     * @return The line number connected to this failure.
     */
    public function getLineNumber():Int {
        return mLineNumber;
    }

    /**
     * Return the method where this failure occurred.
     *
     * @return The method where this failure occurred.
     */
    public function getMethod():String {
        return mMethod;
    }

    /**
     * Return the class name where this failure occurred.
     *
     * @return The class name where this failure occurred.
     */
    public function getClassName():String {
        return mClassName;
    }

    /**
     * Return a textual representation of this failure.
     *
     * @return A textual representation of this failure.
     */
    public function toString():String {
        return "Failure: " + mDescription + " @line " + mLineNumber + ", method: " + mMethod + ", class: " + mClassName;
    }
}
