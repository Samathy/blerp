module blerp.example;

version (unittest)
{
    import blerp.blerp;
    import blerp.blerp : BlerpTest;
}

version (unittest) static this()
{
    runTests!(__MODULE__);
}

int testme(int i, int j)
{

    return i + j;
}

int testme2(int i, int j)
{

    return i + j;
}

@BlerpTest("unittest_one") unittest
{

    assert(testme2(10, 10) == 20);

}

@BlerpTest("Unittest_two") unittest
{
    assert(testme(10, 10) == 40);

}

@BlerpTest("hello") unittest
{
    assert(100 == 100);
}
