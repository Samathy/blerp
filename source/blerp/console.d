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
        writeln(format("==================================  %s  ==================================",
                module_name));
    }

    public void writeReport(Results results)
    {
        writeln(to!string(results.failedCount) ~ " Tests Failed " ~ to!string(
                results.succeededCount()) ~ " Tests Succeeded");

        writeln(to!string(results.totalTests()) ~ " Test ran");

        foreach (result; results.getResults())
        {
            writeln(result.getName());
            if (result.hasException())
            {
                writeln(result.getException().file ~ ":" ~ to!string(result.getException().line));
                writeln(result.getException().msg);
                writeln(result.getException().toString());
            }
        }
    }
}
