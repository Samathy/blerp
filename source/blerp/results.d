module blerp.results;

import core.exception;

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

    this(string name, AssertError e)
    {
        this.name = name;
        this.exception = e;

        this.failed = true;
    }

    this(string name)
    {
        this.name = name;
        this.exception = null;
    }

    public string getName()
    {
        return this.name;
    }

    public AssertError getException()
    {
        return this.exception;
    }

    public bool hasException()
    {
        if (this.exception !is null)
        {
            return true;
        }

        return false;
    }

    private
    {
        string name;
        AssertError exception;

        bool failed = false;
    }

}
