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
package haxelib.logging;

import haxelib.logging.Log;
import haxelib.logging.BaseLogger;

/**
 * A base implementation of the logger interface.
 *
 * @author Yann Spöri
 */
class LoggingTest
{
    public static function testLoggingPackage():Void {
        // well just create a logger and log a log message with warning level
        var logger:BaseLogger = new BaseLogger("myLogger");
        logger.log(Log.WARN, "My warning message", true);
    }
}