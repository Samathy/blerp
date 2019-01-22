module blerp.results;

import core.exception;

class Results

{
    this()
    {
    }

    public void add(Result r)
    {
        this.results~=r;

        if(r.failed)
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
        this.name  = name;
        this.exception = e;

        this.failed = true;
    }

    this(string name)
    {
        this.name  = name;
        this.exception = null;
    }

    public AssertError getException()
    {
        return this.exception;
    }

    private
    {
        string name;
        AssertError exception;

        bool failed = false;
    }

}
