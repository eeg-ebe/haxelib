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
 * A single log entry.
 *
 * @author Yann Spöri
 */
class LogEntry
{
    /**
     * The time that the LogEntry was logged / created.
     */
    private var mTime:String;

    /**
     * The line number.
     */
    private var mLineNumber:Int;

    /**
     * The name of the file.
     */
    private var mFilename:String;

    /**
     * The class where the logger was called.
     */
    private var mClazz:String;

    /**
     * The method where the logger was called.
     */
    private var mMethod:String;

    /**
     * The log level of this log entry.
     */
    private var mLevel:Int;

    /**
     * The message that was logged.
     */
    private var mMessage:String;

    /**
     * The name of the logger that logged this entry.
     */
    private var mLogger:String;

    /**
     * The name of the thread that logged this entry
     * (or null if unknown).
     */
    private var mThread:String;

    /**
     * The stacktrace connected to this log entry,
     * or null if the stacktrace was not available.
     */
    private var mTrace:Null<Array<StackItem>>;

    /**
     * Create a new LogEntry.
     *
     * @param lineNumber    The line number connected to this LogEntry.
     * @param filename      The name of the file connected to this LogEntry.
     * @param clazz         The clazz name connected to this LogEntry.
     * @param method        The method connected to this LogEntry.
     * @param level         The level connected to this LogEntry.
     * @param message       The message connected to this LogEntry.
     * @param logger        The name of the logger connected to this LogEntry.
     * @param thread        The name of the thread connected to this LogEntry.
     * @param trace         The trace connected to this thread connected to this LogEntry.
     */
    public function new(lineNumber:Int, filename:String, clazz:String, method:String, level:Int, message:String, logger:String, thread:String, trace:Null<Array<StackItem>>) {
        mTime = Date.now().toString();
        mLineNumber = lineNumber;
        mFilename = filename;
        mClazz = clazz;
        mMethod = method;
        mLevel = level;
        mMessage = message;
        mLogger = logger;
        mThread = thread;
        mTrace = trace;
    }

    /**
     * Get the time this LogEntry was created.
     *
     * @return The time this LogEntry was created.
     */
    public function getTime():String {
        return mTime;
    }

    /**
     * Get the line number connected to this LogEntry.
     *
     * @return The Line number connected to this LogEntry.
     */
    public function getLineNumber():Int {
        return mLineNumber;
    }

    /**
     * Get the filename connected to this LogEntry.
     *
     * @return The filename connected to this LogEntry.
     */
    public function getFileName():String  {
        return mFilename;
    }

    /**
     * Get the class name connected to this LogEntry.
     *
     * @return The class name connected to this LogEntry.
     */
    public function getClazz():String {
        return mClazz;
    }

    /**
     * Get the method connected to this LogEntry.
     *
     * @return The method connected to this LogEntry.
     */
    public function getMethod():String {
        return mMethod;
    }

    /**
     * Get the log level connected to this LogEntry.
     *
     * @return The log level connected to this LogEntry.
     */
    public function getLogLevel():Int {
        return mLevel;
    }

    /**
     * Get the message connected to this LogEntry.
     *
     * @return The message connected to this LogEntry.
     */
    public function getMesage():String {
        return mMessage;
    }

    /**
     * Get the name of the logger that logged this LogEntry.
     *
     * @return The name of the logger that logged this LogEntry.
     */
    public function getLogger():String {
        return mLogger;
    }

    /**
     * Get the thread the logger was called from.
     *
     * @return The thread name the logger was called from.
     */
    public function getThread():String {
        return mThread;
    }

    /**
     * Get the trace of the thread.
     *
     * @return The stacktrace.
     */
    public function getTrace():Null<Array<StackItem>> {
        return mTrace;
    }

    /**
     * Get a textual representation of this object.
     *
     * @return A textual representation of this object.
     */
    @:keep
    public function toString():String {
        return mLogger + " " + mThread + " " + mTime + " " + mFilename + "." + mMethod + "@" + mLineNumber + ":" + mMessage + " " + mTrace;
    }
}