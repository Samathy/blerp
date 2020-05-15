module blerp.console;

import std.stdio;
import std.conv : to;
import std.format : format;

import blerp.results;

class Console
{

    this()
    {
    }

    public void writeHeader(string module_name)
    {
        writeln(format("==================================  %s  ==================================\n",
                module_name));
    }

    public void writeReport(Results results)
    {
        writeln(format("\n%s Tests Ran", to!string(results.totalTests())));
        writeln(format("%s Tests Failed and %s Tests Succeeded.\n",
                to!string(results.failedCount), to!string(results.succeededCount())));

        foreach (result; results.getResults())
        {
            if (result.hasException())
            {
                writeln(format("==================================  %s  ==================================\n",
                        result.getName()));
                writeln(result.getException().file ~ ":" ~ to!string(result.getException().line));
                writeln(result.getException().msg);
                writeln(result.getException().info);
            }
        }

        writeln("\n");
    }
}
