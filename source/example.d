module blerp.example;
import blerp.blerp;

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

@("unittest_one") unittest
{

    assert(testme2(10, 10) == 20);

}

@("Unittest_two") unittest
{
    assert(testme(10, 10) == 40);

}
