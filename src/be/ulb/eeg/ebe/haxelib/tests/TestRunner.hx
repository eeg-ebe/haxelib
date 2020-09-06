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

import haxe.CallStack;

import be.ulb.eeg.ebe.haxelib.lang.Object;

import be.ulb.eeg.ebe.haxelib.logging.BaseLogger;
import be.ulb.eeg.ebe.haxelib.logging.Log;

/**
 * A single TestCase.
 *
 * @author Yann Spoeri
 */
class TestRunner extends Object
{
    /**
     * A list of tests to execute
     */
    private var mTests:List<TestCase>;

    /**
     * Create a new TestRunner.
     */
    public function new() {
        mTests = new List<TestCase>();
    }

    /**
     * Add a test to the list of tests to execute.
     *
     * @param test   The test to execute.
     */
    public function addTest(test:TestCase):Void {
        if (test == null) {
            throw "Test must not be null!";
        }
        mTests.add(test);
    }

    /**
     * Run this test-case. This method should get overwritten by sub-classes.
     */
    public function run() {
        toStdout("Executing tests ...\n\n");
        var failureCount:Int = 0;
        for (test in mTests) {
            test.clearFailures(); // just to ensure that test is clean
            toStdout("Executing " + test.getName());
            try {
                test.run();
            } catch(err:TestStopException) {
                // Exception to indicate that the test-execution should be stopped
                // If that's due to a failure, the failure should've been added
                // already, so there's nothing to do here.
            } catch (err:Any) {
                var failure:Failure = new Failure(Std.string(err), -1, "null", "null"); // TODO
                test.addFailure(failure);
            }
            var testFailures:List<Failure> = test.getFailures();
            failureCount += testFailures.length;
            if (testFailures.length == 0) {
                toStdout(" ...  OK\n");
            } else {
                toStdout(" ... " + testFailures.length + " failure(s)");
                for (failure in testFailures) {
                    toStdout("\n  " + failure);
                }
                toStdout("\n");
            }
        }
        toStdout("\n");
        if (failureCount == 0) {
            toStdout("Finished (no failures)!\n");
        } else {
            toStdout("Finished with " + failureCount + " failure(s)!\n");
        }
    }

    /**
     * Helper function to output a string on stdout on trace or ...
     */
    private static function toStdout(s:String):Void {
        #if sys
        Sys.print(s);
        #else
        trace(s);
        #end
    }
}
