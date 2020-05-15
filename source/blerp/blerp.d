module blerp.blerp;

/**
 * Imports.
 */
import core.exception;
import core.runtime;

import blerp.results;
import blerp.console;

import std.stdio;
import std.format : format;

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
            alias test_attributes = Tuple!(__traits(getAttributes, test));
            string test_name;

            static if (test_attributes.length >= 1)
            {
                test_name = format("%s.%s", module_name, test_attributes[0]);
            }
            else
            {
                test_name = format("%s.%s", module_name);
            }

            try
            {
                test();
            }
            catch (AssertError ex)
            {
                results.add(new Result(test_name, new AssertError(ex.msg, ex.file, ex.line)));
                continue;
            }
            results.add(new Result(test_name));
        }

        console.writeReport(results);

        return !results.failedCount;
    }
}
