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

        writeln(to!string(results.failedCount) ~ " Tests Failed " ~ to!string(
                results.succeededCount()) ~ " Tests Succeeded");

        foreach (result; results.getResults())
        {
            writeln(result.getName());
            writeln(result.getException().file ~ ":" ~ to!string(result.getException().line));
            writeln(result.getException().msg);
            writeln(result.getException().toString());
        }
    }
}
