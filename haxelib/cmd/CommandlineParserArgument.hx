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
package haxelib.cmd;

/**
 * A commandline parser argument.
 *
 * @author Yann Spoeri
 */
class CommandlineParserArgument
{
    /**
     * The name of this rule.
     */
    private var mName:String;

    /**
     * Possible arguments.
     */
    private var mArgs:Array<String>;

    /**
     * The argument type.
     */
    private var mType:String;

    /**
     * The default value.
     */
    private var mDefault:String;

    /**
     * Whether this is a required argument.
     */
    private var mRequired:Bool;

    /**
     * A help string explaining this argument.
     */
    private var mHelp:String;

    /**
     * Whether this argument is given.
     */
    private var mGiven:Bool;

    /**
     * Create a new CommandlineParserArgument.
     *
     * @param   name        The name of the argument.
     * @param   args        The arguments on the commandline connected to this argument.
     * @param   type        The argument type (String, Int, Float, Bool, File) as String.
     * @param   def         A possible default value (as string).
     * @param   required    Whether this is a required argument.
     * @param   help        A help string explaining this argument.
     */
    public function new(name:String, args:Array<String>, ?type:String="String", ?def:String=null, ?required:Bool=true, ?help:String="") {
        if (name == null || name == "") {
            throw "The name of a  commandline argument must not be null or empty!";
        }
        if (args == null || args.length == 0) {
            throw "Argument list is not empty!";
        }
        if (!(type == "string" || type == "int" || type == "float" || type == "bool" || type == "file")) {
            throw "Illegal type " + type;
        }
        if (required == null) {
            throw "Required must not be null!";
        }
        if (required && type == "bool") {
            throw "Arguments of type bool must not be required!";
        }
        if (required && def != null) {
            throw "Required arguments must not have default values!";
        }
        mName = name;
        mArgs = args;
        mType = type;
        mDefault = (type == "bool") ? "false" : def; // implicite default value for bools
        mRequired = required;
        mHelp = help;
        mGiven = false;
    }

    /**
     * Get the name of this argument.
     *
     * @return The name of this argument.
     */
    public function getName():String {
        return mName;
    }

    /**
     * Get the argument list connected to this argument.
     *
     * @return The argument list.
     */
    public function getArgs():Array<String> {
        return mArgs;
    }

    /**
     * Get this argument type.
     *
     * @return The argument type.
     */
    public function getType():String {
        return mType;
    }

    /**
     * Get the default value of this argument.
     *
     * @return The default value of this argument.
     */
    public function getDefault():String {
        return mDefault;
    }

    /**
     * Get whether this argument is required.
     *
     * @return Whether this argument is required.
     */
    public function isRequired():Bool {
        return mRequired;
    }

    /**
     * Get the help connected to this argument.
     *
     * @return The help connected to this argument.
     */
    public function getHelp():String {
        return mHelp;
    }

    /**
     * Returns whether this argument is given or not.
     *
     * @return Whether this argument is given.
     */
    public function isGiven():Bool {
        return mGiven;
    }

    /**
     * Set whether this option is given.
     *
     * @param   givenVal    Whether this option is given.
     */
    public function setGiven(givenVal:Bool):Void {
        mGiven = givenVal;
    }
}