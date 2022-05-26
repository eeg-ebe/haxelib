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
package haxelib.system;

/**
 * A Collector for messages. Messages are either outputted directly (in case
 * of sys targets) or collected so that they can be passed on to the GUI later
 * on.
 *
 * @author Yann Spoeri
 */
class MessageCollector
{
    /**
     * List of collected messages.
     */
    private var mMessages:List<Message> = new List<Message>();
    
    /**
     * Whether direct output on stdout is enabled.
     */
    private var mDirectOutput = false;
    
    /**
     * Whether to enable color output.
     */
    private var mColoredOutput = false;
    
    /**
     * Create a new MessageCollector.
     */
    public function new() {
        #if sys
        mDirectOutput = true;
        #end
    }
    
    /**
     * Set whether direct output should be used.
     */
    public function setDirectOutput(output:Bool):Void {
        mDirectOutput = output;
    }
    
    /**
     * Set whether colored output should be used.
     */
    public function setColoredOutput(colored:Bool):Void {
        mColoredOutput = colored;
    }
    
    /**
     * Output something.
     */
    public function add(level:Int, module:String, text:String):Void {
        var m:Message = new Message(level, module, text);
        addMessage(m);
    }
    
    /**
     * Add a message.
     */
    public function addMessage(m:Message):Void {
        if (m == null) {
            m = new Message(4, null, null);
        }
        if (mDirectOutput) {
            var text:String = (mColoredOutput) ? m.toEscapeString() : m.toString();
            #if sys
            Sys.stderr().writeString(text);
            Sys.stderr().writeString("\n");
            #else
            trace(text);
            #end
        } else {
            mMessages.push(m);
        }
    }
    
    /**
     * Grab all saved messages. Maybe empty in case messages where directly
     * outputted.
     */
    public function getMessages():List<Message> {
        return mMessages;
    }
    
    public static function main() {}
}
