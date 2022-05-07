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

import haxe.ds.StringMap;

/**
 * Class to save system stuff.
 *
 * @author Yann Spoeri
 */
class System
{
    /**
     * System properties.
     */
    private static var properties:StringMap<String> = new StringMap<String>();
    
    /**
     * Set the value of a system property.
     */
    public static inline function setProperty(key:String, value:String):Void {
        properties.set(key, value);
    }
    
    /**
     * Check whether a particular property exists.
     */
    public static inline function existsProperty(key:String):Bool {
        return properties.exists(key);
    }
    
    /**
     * Delete a system property.
     */
    public static inline function deleteProperty(key:String):Bool {
        return properties.remove(key);
    }
    
    /**
     * Get the value of a system property.
     */
    public static inline function getProperty(key:String, ?def:String=null):String {
        var result:String = def;
        if (properties.exists(key)) {
            result = properties.get(key);
        }
        return result;
    }
    
    /**
     * Get the haxe compiler version that was used to compile this program.
     */
    public static macro function getHaxeCompilerVersion() {
        return macro $v{haxe.macro.Context.definedValue("haxe_ver")};
    }
    
    /**
     * Get the time the compiler compiled this program.
     */
    public static macro function getBuildTime() {
        var buildTime = Math.floor(Date.now().getTime() / 1000);
        return macro $v{buildTime};
    }
    
    /**
     * Get the target language the compiler compiled this program to.
     */
    public static function getTargetLanguage():String {
        #if js
        return "Java Script";
        #elseif lua
        return "Lua";
        #elseif swf
        return "Flash";
        #elseif neko
        return "Neko";
        #elseif php
        return "PHP";
        #elseif cpp
        return "C++";
        #elseif cppia
        return "cppia";
        #elseif cs
        return "C#";
        #elseif java
        return "Java";
        #elseif jvm
        return "Java Byte Code";
        #elseif python
        return "Python";
        #elseif hl
        return "HashLink";
        #elseif eval
        return "Interpreter";
        #else
        #error "Missing target name"
        #end
    }
    
    public static function main():Void {
        var buildTime = getBuildTime();
        var compilerVersion = getHaxeCompilerVersion();
        var target = getTargetLanguage();
        var message = "Compiled towards " + target + " using compiler " + compilerVersion + " at " + buildTime;
        trace(message);
    }
}
