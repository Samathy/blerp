import blerp.blerp;

int testme(int i, int j)
{

    return i + j;
}

int testme2(int i, int j)
{

    return i + j;
}

unittest
{
    
    assert(testme2(10, 10) == 20);

}

unittest
{
    assert(testme(10, 10) == 40);

}
