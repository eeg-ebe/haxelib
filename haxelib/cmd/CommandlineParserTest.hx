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
 *
 *
 * @author Yann Spoeri
 */
class CommandlineParserTest
{
    public static function testCmdPackage() {
        var parser1:CommandlineParser = new CommandlineParser();
        parser1.addArgument("z", ["-f", "-g"], "string", null, true, "my simple argument1");
        parser1.addArgument("x", ["-1", "-2", "-3"], "string", null, false, "my simple argument1");
        parser1.addArgument("y", ["-a", "-b", "-c"], "string", "x", false, "my simple argument2");
        var out:String = parser1.getHelp();

        var parser2:CommandlineParser = new CommandlineParser();
        parser2.addArgument("z", ["-f", "-g"], "string", null, true, "my simple argument1");
        parser2.addArgument("x", ["-1", "-2", "-3"], "string", null, false, "my simple argument1");
        parser2.addArgument("y", ["-a", "-b", "-c"], "string", "x", false, "my simple argument2");
        parser2.addArgument("b", ["-t"], "bool", null, false, "my simple argument2");
        //parser2.addArgument("g", ["-x"], "file", null, true, "my simple argument2");
        var parser2Result:CommandlineParserResult = parser2.parse(["-1", "a", "-f", "srr"]);
        trace(parser2Result.hasError());
        trace(parser2Result.getErrorMessage());
        trace(parser2Result.getBool("b"));
    }
}