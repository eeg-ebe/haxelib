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

import haxe.ds.StringMap;

/**
 * The LogManager that manages everything that has to do with logging.
 *
 * @author Yann Spöri
 */
class LogManager
{
    /**
     * The instance of this manager.
     */
    private static var sInstance:LogManager;

    /**
     * All registered loggers.
     */
    private var mLoggers:StringMap<ILogger>;

    /**
     * As this is a singleton, the constructor is private.
     */
    private function new() {
        mLoggers = new Stringmap<ILogger>();
    }

    /**
     * Register a new Logger.
     *
     * @param name      The name of the logger to register.
     * @param logger    The logger to register.
     */
    public function register(logger:ILogger):Void {
        // TODO, check whether there is another logger with this name
        va name:String = logger.getName();
        mLoggers.set(name, logger);
        // TODO - when registering, see whether there is a loglevel set for that name
        // then set the loglevel of the logger accordingly.
        // Furthermore add a way to iterate over the registered logger
        // in order to change the LogLevel of each logger later on.
    }

    /**
     * Log a LogEntry.
     *
     * @param logentry  The LogEntry that should get logged.
     */
    public function log(logentry:LogEntry) {
        trace(logentry); // TODO - make it possible to register handlers that handle
        // every logentry. Thus it becomes possible to define what exactly should
        // happen each LogEntry - e.g. trace/writeToFile/...
    }

    /**
     * Get the LogManager instance.
     *
     * @return The instance of this LogManager.
     */
    public static function instance():LogManager {
        if (sInstance == null) {
            sInstance = new LogManager();
        }
        return sInstance;
    }
}