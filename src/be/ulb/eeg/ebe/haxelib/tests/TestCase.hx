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
 * A single TestCase.
 *
 * @author Yann Spoeri
 */
class TestCase extends Object
{
    /**
     * The list of failures which occured in this testcase.
     */
    private var mFailures:List<Failure>;

    /**
     * The number of times ensure was called.
     */
    private var mEnsureCount:Int;

    /**
     * The name of this test-case.
     */
    private var mName:String;

    /**
     * A possible description for this test-case.
     */
    private var mDescription:String;

    /**
     * Create a new instance of this testcase.
     */
    public function new(name:String, description:String) {
        mFailures = new List<Failure>();
        mName = name;
        mDescription = description;
        mEnsureCount = 0;
    }

    /**
     * Ensure that a certain statement is true.
     *
     * @param stmt         The statement to ensure.
     * @param description  A possible description to log in case the statement is false.
     * @param throws       Whether to throw an exception in case the statemetn is false in order to skip the execution of the curren test.
     */
    public function ensure(stmt:Bool, ?description:String="", ?throws:Bool=true, ?pos:haxe.PosInfos):Void {
        mEnsureCount++;
        if (!stmt) {
            var failure:Failure = new Failure(description, pos.lineNumber, pos.methodName, pos.className);
            mFailures.add(failure);
            if (throws) {
                throw new TestStopException();
            }
        }
    }

    /**
     * Add a failure to the failure list of this object.
     *
     * @param failure  A failure object to add to the list of failures.
     */
    public function addFailure(failure:Failure):Void {
        mFailures.add(failure);
    }

    /**
     * Clear the failures connected to this testcase.
     */
    public function clearFailures():Void {
        mFailures.clear();
        mEnsureCount = 0;     
    }

    /**
     * Get a list listing all failures connected to this test-case.
     */
    public function getFailures():List<Failure> {
        var copy:List<Failure> = new List<Failure>();
        for (failure in mFailures) {
            // failures are read-only,
            // so no need to copy the information
            // of one failure object into another, too.
            copy.add(failure);
        }
        return copy;
    }

    /**
     * Get the name of this test-case.
     */
    public function getName():String {
        return mName;
    }

    /**
     * Run this test-case. This method should get overwritten by sub-classes.
     */
    public function run() {
    }

    /**
     * Get the number of times ensure was called.
     *
     * @return The number of times ensure was called since clearFailures was
     * called the last time.
     */
    public function getEnsureCount():Int {
        return mEnsureCount;
    }
}
