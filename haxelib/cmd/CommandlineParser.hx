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

import haxe.ds.StringMap;
import haxelib.system.System;

/**
 * A commandline parser.
 *
 * @author Yann Spoeri
 */
class CommandlineParser
{
    /**
     * The name of this executable.
     */
    private var mProg:String;

    /**
     * A possible description of this program.
     */
    private var mDescription:String;

    /**
     * The arguments that have been added to this parser.
     */
    private var mArguments:StringMap<CommandlineParserArgument>;

    /**
     * Create a new CommandlineParser.
     *
     * @param   description     A possible description of this program.
     */
    public function new(?prog="PROG", ?description:String=null) {
        mProg = prog;
        mDescription = description;
        mArguments = new StringMap<CommandlineParserArgument>();
    }

    /**
     * Add an argument.
     *
     * @param   name        The name of the argument.
     * @param   args        The arguments on the commandline connected to this argument.
     * @param   type        The argument type (String, Int, Float, Bool, File) as String.
     * @param   def         A possible default value (as string).
     * @param   required    Whether this is a required argument.
     * @param   help        A help string explaining this argument.
     */
    public function addArgument(name:String, args:Array<String>, ?type:String="String", ?def:String=null, ?required:Bool=true, ?help:String=null):Void {
        if (mArguments.exists(name)) {
            throw "Argument " + name + " is already in list!";
        }
        var arg:CommandlineParserArgument = new CommandlineParserArgument(name, args, type, def, required, help);
        mArguments.set(name, arg);
    }

    /**
     * Create the help information.
     *
     * @return The help information.
     */
    public function getHelp():String {
        var result:List<String> = new List<String>();
        result.add("usage: ");
        result.add(mProg);
        for (arg in mArguments) {
            result.add(" ");
            if (!arg.isRequired()) {
                result.add("[");
            }
            result.add(arg.getArgs()[0]);
            if (arg.getType() != "bool") {
                result.add(" " + arg.getType());
            }
            if (!arg.isRequired()) {
                result.add("]");
            }
        }
        result.add("\n\n");
        if (mDescription != null) {
            result.add(mDescription);
            result.add("\n\n");
        }
        result.add("options:\n");
        for (arg in mArguments) {
            result.add("  ");
            result.add(arg.getArgs().join(", "));
            result.add("\t");
            result.add(arg.getHelp());
            if (arg.getDefault() != null) {
                result.add(" (default: ");
                result.add(arg.getDefault());
                result.add(")");
            }
            if (arg.isRequired()) {
                result.add(" (required)");
            }
            result.add("\n");
        }
        result.add("\n");
        result.add("(Created with haxe version " + System.getHaxeCompilerVersion() + "; Buildtime " + Date.fromTime(System.getBuildTime() * 1000).toString() + ")");
        return result.join("");
    }

    /**
     * Parse a bunch of arguments.
     *
     * @param   args    The arguments to parse.
     * @return A result object that contains the parsing result.
     */
    public function parse(args:Array<String>):CommandlineParserResult {
        var result:CommandlineParserResult = new CommandlineParserResult();
        // reset
        for (arg in mArguments) {
            arg.setGiven(false);
        }
        // parse
        var pos:Int = 0;
        while (pos < args.length) {
            var arg:String = args[pos];
            var cArg:CommandlineParserArgument = null;
            // get argument object
            for (ca in mArguments) {
                for (pa in ca.getArgs()) {
                    if (pa == arg) {
                        cArg = ca;
                        break;
                    }
                }
            }
            // now store
            if (cArg == null) {
                var systemArg:String = "--system:";
                if (StringTools.startsWith(arg, systemArg)) {
                    if (arg == "--system:directOutput") {
                        System.messages.setDirectOutput(true);
                    } else if (arg == "--system:noDirectOutput") {
                        System.messages.setDirectOutput(false);
                    } else if (arg == "--system:coloredOutput") {
                        System.messages.setColoredOutput(true);
                    } else if (arg == "--system:noColoredOutput") {
                        System.messages.setColoredOutput(false);
                    } else {
                        var argLen:Int = systemArg.length;
                        var rest:String = arg.substr(argLen);
                        var eqPos:Int = rest.indexOf("=");
                        if (eqPos > 0) {
                            var key:String = rest.substr(0, eqPos);
                            var val:String = rest.substr(eqPos + 1);
                            System.setProperty(key, val);
                        } else {
                            result.setErrorMessage("Unknown argument '" + arg + "'!\n\n" + getHelp());
                            break;
                        }
                    }
                    ++pos;
                    continue;
                } else {
                    result.setErrorMessage("Unknown argument '" + arg + "'!\n\n" + getHelp());
                    break;
                }
            } else if (cArg.isGiven()) {
                result.setErrorMessage("Argument '" + arg + "' already given!\n\n" + getHelp());
                break;
            } else if (cArg.getType() == "bool") {
                result.store(cArg.getName(), "true");
            } else {
                var value:String = args[++pos];
                result.store(cArg.getName(), value);
            }
            cArg.setGiven(true);
            ++pos;
        }
        // check
        if (!result.hasError()) {
            for (arg in mArguments) {
                if (!arg.isGiven()) {
                    if (arg.isRequired()) {
                        result.setErrorMessage("Missing required argument " + arg.getArgs()[0] + "\n\n" + getHelp());
                        break;
                    } else {
                        result.store(arg.getName(), arg.getDefault());
                    }
                }
            }
        }
        return result;
    }
    
    public static function main() {}
}