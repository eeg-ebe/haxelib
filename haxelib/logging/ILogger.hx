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

/**
 * The logging interface. By convention, every logger should register
 * itself to the LogManager singleton class upon creation. This registry
 * will then assign a loglevel to the created logger.
 *
 * The name of the logger should NOT change anymore once it was set and
 * the logger registered.
 *
 * Every logger can create a LogEntry object and put that entry into the
 * corresponding queue of the LogManager.
 *
 * @author Yann Spöri
 */
interface ILogger
{
    /**
     * Return the name of this logger.
     *
     * @return The name of this logger.
     */
    public function getName():String;

    /**
     * Set the log level of this logger. After the log level was set,
     * the logger should log only those message with a log level higher
     * or equal to set log level.
     *
     * @param level The new log level.
     */
    public function setLogLevel(level:Int):Void;
}