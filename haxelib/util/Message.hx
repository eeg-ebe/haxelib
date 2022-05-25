/**
 * Copyright (c) 2022 Université libre de Bruxelles, eeg-ebe Department, Yann Spöri
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
package haxelib.util;

/**
 * A message to show to show e.g. the user.
 *
 * @author Yann Spoeri
 */
class Message
{
    /**
     * The date of this message.
     */
    private var mNow:Date;

    /**
     * An estimation of the importance of this message from 0 to 5.
     * (0 not important, 5 important).
     */
    private var mImportance:Int;

    /**
     * The module this message comes from.
     */
    private var mModule:String;

    /**
     * The message.
     */
    private var mMessage:String;

    /**
     * Create a new message object.
     */
    public function new(importance:Int, module:String, message:String) {
        mNow = Date.now();
        mImportance = importance;
        mModule = module;
        mMessage = message;
    }
    
    /**
     * Get the time this message was created.
     */
    public function getTime():Date {
        return mNow;
    }
    
    /**
     * Get the importance of this message.
     */
    public function getImportance():Int {
        return mImportance;
    }
    
    /**
     * Get the importance of this message as text.
     */
    public function getImportanceAsText():String {
        if (mImportance == 0) {
            return "ALL";
        } else if (mImportance == 1) {
            return "DEBUG-LOW";
        } else if (mImportance == 2) {
            return "DEBUG";
        } else if (mImportance == 3) {
            return "INFO";
        } else if (mImportance == 4) {
            return "WARNING";
        } else if (mImportance == 5) {
            return "ERROR";
        }
        return "???";
    }
    
    /**
     * Get the escape sequence for this kind of importance.
     */
    public function getImportanceEscapeSequence():String {
        if (mImportance == 3) {
            return "\x1B[1;32m";
        } else if (mImportance == 4) {
            return "\x1B[1;33m";
        } else if (mImportance == 5) {
            return "\x1B[1;31m";
        }
        return "\x1B[0m";
    }
    
    /**
     * Get the module this message comes from.
     */
    public function getModule():String {
        return mModule;
    }
    
    /**
     * Get the message of this message.
     */
    public function getMessage():String {
        return mMessage;
    }
    
    /**
     * Get a textual representation of this message.
     */
    private function toString():String {
        var result:Array<String> = [];
        result.push(mNow.toString());
        result.push(" ");
        var importance:String = getImportanceAsText();
        result.push(importance);
        if (mModule != null && mModule != "") {
            result.push(" [");
            result.push(mModule);
            result.push("]");
        }
        if (mMessage != null && mMessage != "") {
            result.push(" ");
            result.push(mMessage);
        }
        return result.join("");
    }
    
    /**
     * Get an escaped textual representation of this message.
     */
    private function toEscapeString():String {
        var result:Array<String> = [];
        result.push("\x1B[1;37m");
        result.push(mNow.toString());
        result.push("\x1B[0m");
        result.push(" ");
        result.push("\x1B[1;36m");
        var importance:String = getImportanceAsText();
        result.push(importance);
        result.push("\x1B[0m");
        if (mModule != null && mModule != "") {
            result.push(" [\x1B[1;34m");
            result.push(mModule);
            result.push("\x1B[0m]");
        }
        if (mMessage != null && mMessage != "") {
            result.push(" ");
            var escapeColorSequence:String = getImportanceEscapeSequence();
            result.push(escapeColorSequence);
            result.push(mMessage);
        }
        result.push("\033[0m");
        return result.join("");
    }
    
    /**
     * Get an html representation of this message.
     */
    private function toHtmlString():String {
        var result:Array<String> = [];
        result.push("<span class='message messageType" + mImportance + "'>");
        result.push("<span class='messageDate'>");
        result.push(mNow.toString());
        result.push("</span>");
        result.push(" <span class='importanceString'>");
        var importance:String = getImportanceAsText();
        result.push(importance);
        result.push("</span>");
        if (mModule != null && mModule != "") {
            result.push(" <span class='messageModule'>[");
            var module:String = StringTools.htmlEscape(mModule);
            result.push(module);
            result.push("]</span>");
        }
        if (mMessage != null && mMessage != "") {
            result.push(" <span class='messageMessage messageColor" + mImportance + "'>");
            result.push(mMessage);
            result.push("</span>");
        }
        result.push("</span>");
        return result.join("");
    }
    
    public static function main() {
        var m:Message = new Message(4, "TEST", "Test message");
        trace(m.toString());
        trace(m.toHtmlString());
        for (i in 0...6) {
            var m:Message = new Message(i, "TEST", "Test message");
            trace(m.toEscapeString());
        }
    }
}
