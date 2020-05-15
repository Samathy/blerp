import blerp.blerp;

version (unittest) static this()
{
    runTests!(__MODULE__);
}

string giveMeATry()
{
    return "Help! I'm in the computer";
}

@("test_give_me_a_try") unittest
{
    assert(giveMeATry() == "Help! I'm in the computer");
}
