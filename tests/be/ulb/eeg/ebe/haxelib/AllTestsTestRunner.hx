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
package be.ulb.eeg.ebe.haxelib;

import be.ulb.eeg.ebe.haxelib.tests.TestRunner;

/**
 * Tests for the Color class.
 *
 * @author Yann Spöri
 */
class AllTestsTestRunner extends TestRunner
{
    /**
     * Run all tests.
     */
    public static function main():Void { 
        var runner:AllTestsTestRunner = new AllTestsTestRunner();
        runner.addTest(new be.ulb.eeg.ebe.haxelib.gui.ColorTest());
        runner.run();
    }
}

