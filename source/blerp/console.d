module blerp.console;

import std.stdio;
import std.conv : to;

import blerp.results;

class Console
{

    this()
    {
    }

    public void writeHeader()
    {

        writeln("==================================  BLERP  ==================================");
    }

    public void writeReport(Results results)
    {
        writeln(to!string(results.failedCount) ~ " Modules Failed " ~ to!string(
                results.succeededCount()) ~ " Modules Succeeded");

        writeln(to!string(results.totalTests()) ~ " Modules ran");

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
