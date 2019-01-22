/**
  Copyright (c) 2013 Gary Willoughby

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
**/

/* https://github.com/nomad-software/dunit/blob/master/source/dunit/moduleunittester.d */

/**
 * Module to replace the built-in unit tester.
 *
 * License:
 *     MIT. See LICENSE for full details.
 */
module blerp.blerp;

/**
 * Imports.
 */
import core.exception;
import core.runtime;

import blerp.results;
import blerp.console;

/**
 * Replace the standard unit test handler.
 */
version (unittest) shared static this()
{
    Runtime.moduleUnitTester = function() {
        auto console = new Console();
        auto results = new Results();

        console.writeHeader();

        foreach (module_; ModuleInfo)
        {
            if (module_)
            {
                auto unitTest = module_.unitTest;

                if (unitTest)
                {
                    try
                    {
                        unitTest();
                    }
                    catch (AssertError ex)
                    {
                        results.add(new Result(module_.name,
                                new AssertError(ex.msg, ex.file, ex.line)));
                        continue;
                    }
                    results.add(new Result(module_.name));
                }
            }
        }

        console.writeReport(results);

        return !results.failedCount();
    };
}
