module blerp.example;

import blerp.blerp;

int testme(int i, int j)
{

    return i + j;
}

unittest
{
    assert(testme(10, 10) == 20);
    assert(testme(10, 10) == 10);

}
