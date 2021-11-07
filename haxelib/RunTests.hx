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
package haxelib;

import haxelib.cmd.CommandlineParserTest;
import haxelib.logging.LoggingTest;

/**
 * Run the test classes to verify the correct functionality of the different classes
 * in this library.
 *
 * @author Yann Spöri
 */
class RunTests
{
    /**
     * Run all tests ...
     */
    public static function main():Void {
        LoggingTest.testLoggingPackage();
        CommandlineParserTest.testCmdPackage();
    }
}