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

import haxe.CallStack;

/**
 * A base implementation of the logger interface.
 *
 * @author Yann Spöri
 */
class BaseLogger implements ILogger
{
    /**
     * The name of the logger.
     */
    private var mName:String;

    /**
     * The currently set log level.
     */
    private var mLogLevel:Int = Log.WARN;

    /**
     * Create a new BaseLogger.
     *
     * @param name  This logger's name.
     */
    public function new(name:String) {
        if (name == null) {
            throw "Name must not be null!";
        }
        this.mName = name;
        LogManager.instance().register(name, this);
    }

    /**
     * Get the name of this logger.
     *
     * @return The name of this logger.
     */
    public function getName():String {
        return mName;
    }

    /**
     * Set a new loglevel.
     *
     * @param level The new loglevel this logger should have.
     */
    public function setLogLevel(level:Int):Void {
        mLogLevel = level;
    }

    /**
     * Log a message.
     *
     * @param level The log level that should get used to log the message.
     * @param The level to log.
     */
    public inline function log(level:Int, message:String, withStack:Bool=false, ?pos:haxe.PosInfos):Void { // TODO: callStack may be slow, opt
        if (level >= mLogLevel) {
            var thread:String = "???"; // TODO once haxe knows thread names ;)
            var stack = (withStack) ? CallStack.callStack() : null;
            var le:LogEntry = new LogEntry(pos.lineNumber, pos.fileName, pos.className, pos.methodName, level, message, mName, thread, stack);
            LogManager.instance().log(le);
        }
    }
}