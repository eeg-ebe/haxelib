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
     * All logging rules.
     */
    private var mLoggingRules:StringMap<Int>;

    /**
     * As this is a singleton, the constructor is private.
     */
    private function new() {
        mLoggers = new StringMap<ILogger>();
        mLoggingRules = new StringMap<Int>();
    }

    /**
     * Register a new Logger.
     *
     * @param name      The name of the logger to register.
     * @param logger    The logger to register.
     */
    public function register(name:String, logger:ILogger):Void {
        if (name == null) {
            throw "Loggername " + name + " must not be null!";
        }
        if (logger == null) {
            throw "Logger " + logger + " must not be null";
        }
        if (mLoggers.exists(name)) {
            throw "Another logger with name " + name + " was already registered!";
        }
        mLoggers.set(name, logger);
        if (mLoggingRules.exists(name)) {
            var val:Int = mLoggingRules.get(name);
            logger.setLogLevel(val);
            mLoggingRules.remove(name);
        } else {
            logger.setLogLevel(Log.WARN);
        }
    }

    /**
     * Set the log level for a logger.
     *
     * @param name  The name of the logger.
     * @param val   The log level the parser should have.
     */
    public function setLogLevel(name:String, val:Int) {
        if (name == null) {
            throw "Logger name must not be null!";
        }
        // we already have that logger?
        if (mLoggers.exists(name)) {
            var logger:ILogger = mLoggers.get(name);
            logger.setLogLevel(val);
        } else {
            // logger not there yet, but may be later on. So save ;)
            mLoggingRules.set(name, val);
        }
    }

    /**
     * Set a bunch of log levels by a string.
     *
     * @param s     The string to parse.
     */
    public function setLogLevelsByString(s:String) {
        if (s == null || s == "") {
            return; // Nothing to do ;)
        }
        var splittedString:Array<String> = s.split(",");
        for (p in splittedString) {
            var split:Array<String> = p.split("=");
            if (split.length == 2) {
                var loggerName:String = StringTools.trim(split[0]);
                var loggerVal:String = StringTools.trim(split[1]);
                var loggerValAsInt:Int = Log.parse(loggerVal);
                setLogLevel(loggerName, loggerValAsInt);
            } else {
                throw "Unable to parse '" + p + "'";
            }
        }
    }

    /**
     * Log a LogEntry.
     *
     * @param logentry  The LogEntry that should get logged.
     */
    public function log(logentry:LogEntry) {
        // TODO - make it possible to register handlers that handle
        // every logentry. Thus it becomes possible to define what exactly should
        // happen each LogEntry - e.g. trace/writeToFile/...
        // for now, we simply output the log entry via trace ...
        trace(logentry.toString());
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