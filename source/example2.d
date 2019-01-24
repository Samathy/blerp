import blerp.blerp;

string giveMeATry()
{
    return "Help! I'm in the computer";
}

unittest
{
    assert(giveMeATry() == "Help! I'm in the computer");
}
