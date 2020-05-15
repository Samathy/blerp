module blerp.blerp;

/**
 * Imports.
 */
import core.exception;
import core.runtime;

import blerp.results;
import blerp.console;

import std.stdio;
import std.conv: to;
import std.format : format;
import std.traits : getUDAs;

/**
 * Replace the standard unit test handler.
 */
//version (unittest) shared static this()

template Tuple(T...)
{
    alias Tuple = T;
}

version (unittest) shared static this()
{
    Runtime.moduleUnitTester = { return true; };
}

struct BlerpTest
{
    string name;
}

version (unittest) template runTests(string module_name) //if( __traits(isModule, mixin(packageName(mixin(module_name)"."~Nmodule_name)))
{
    bool runTests()
    {
        auto console = new Console();
        auto results = new Results();

        console.writeHeader(module_name);

        mixin("static import " ~ module_name ~ ";");

        alias tests = Tuple!(__traits(getUnitTests, mixin(module_name)));

        foreach (test; tests)
        {
            alias test_attribute = getUDAs!(test, BlerpTest);
            string test_name;

            static if (test_attribute.length >= 1)
            {
                test_name = format("%s.%s", module_name, test_attribute[0].name);
            }
            else
            {
                test_name = format("%s", module_name);
            }

            //If this is not a BlerpTest marked test, ignore it.
            if (test_attribute.length >= 1)
            {
                try
                {
                    test();
                }
                catch (AssertError ex)
                {
                    results.add(new Result(test_name, exceptionInfo(true, ex.msg, ex.file, ex.line, to!string(ex.info))));
                    writeln(format("FAILED    %s", test_name));
                    continue;
                }
                results.add(new Result(test_name));
                writeln(format("PASSED    %s", test_name));

            }
            else
            {
                writeln(format("          Ignoring test %s, it is not marked as a BlerpTest",
                        test_name));
            }
        }

        console.writeReport(results);

        return !results.failedCount;
    }
}
