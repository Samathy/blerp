module blerp.results;

import core.exception;

import std.conv: to;

struct exceptionInfo
{
    bool hasInfo;
    string msg;
    string file;
    ulong line;
    string info;
}
           

class Results

{
    this()
    {
    }

    public void add(Result r)
    {
        this.results ~= r;

        if (r.failed)
        {
            this.failedTotal++;
        }

    }

    public int failedCount()
    {
        return this.failedTotal;
    }

    public int succeededCount()
    {
        return cast(int) this.results.length - this.failedTotal;
    }

    public int totalTests()
    {
        return cast(int) this.results.length;
    }

    public Result[] getResults()
    {
        return this.results;
    }

    private
    {
        Result[] results;
        int failedTotal;
    }

}

class Result
{

    this(string name, exceptionInfo ex)
    {
        this.name = name;
        this.exception = ex;
        this.exception.hasInfo = true;

        this.failed = true;
    }

    this(string name)
    {
        this.name = name;
        this.exception.hasInfo = false;
    }

    public string getName()
    {
        return this.name;
    }

    public exceptionInfo getException()
    {
        return this.exception;
    }

    public bool hasException()
    {
        if (this.exception.hasInfo )
        {
            return true;
        }

        return false;
    }

    private
    {
        string name;
        exceptionInfo exception;

        bool failed = false;
    }

}
