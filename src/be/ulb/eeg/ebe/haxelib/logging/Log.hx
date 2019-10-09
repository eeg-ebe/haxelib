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
package be.ulb.eeg.ebe.haxelib.logging;

/**
 * A class listing the different log levels.
 *
 * @author Yann Spoeri
 */
class Log
{
    /**
     * Log level indicating that nothing should get logged.
     */
    @:final
    public static var NONE:Int = 256;

    /**
     * Log level indicating a fatal error. That means
     * an error the application probably cannot recover
     * from and the application has to stop.
     */
    @:final
    public static var FATAL:Int = 128;
    
    /**
     * Log level indicating an error. Unlike FATAL it is
     * expected that the application can handle this
     * situation.
     */
    @:final
    public static var ERROR:Int = 64;
    
    /**
     * Log level indicating a warning. Something that
     * hypothetically may lead to an error.
     */
    @:final
    public static var WARN:Int = 32;
    
    /**
     * Log level providing a skeleton of what happened.
     */
    @:final
    public static var INFO:Int = 16;
    
    /**
     * Log level indicating more granular, diagnostic
     * information.
     */
    @:final
    public static var DEBUG:Int = 8;
    
    /**
     * Log level indicating that the parameters and
     * return values of every method should get logged.
     */
    @:final
    public static var METHOD:Int = 4;
    
    /**
     * Log level indicating fine-graned log information.
     */
    @:final
    public static var TRACE:Int = 2;
    
    /**
     * Log level that indicates that everything should
     * get logged.
     */
    @:final
    public static var ALL:Int = 1;
}