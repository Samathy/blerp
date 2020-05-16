# Blerp

Blerp is a library for D which blerps out all the unittests that were ran and 
logs the number of succeeded and failed tests.
Because by default, D doesnt really print anything useful if all tests pass.

Blerp discovers tests at compile time.

Blerp allows you to name your tests too!

It doesnt do anything clever like colour the output atm.


## Including blerp in your project

Blerp is available on the dub package hub.
Inside your package's directory, run:

    dub add blerp

You can also install it manually:
[Clone blerp](https://github.com/Samathy/blerp), and run the following inside your package directory:
    
    dub add-local path-to-blerp

before adding the snippet:

```

"dependencies": 
{
    "blerp":
    {
        "version": "~master"
    }
}

```

to your dub.json.

### Enabling Blerp

At the top of one of your project's files, include: 

```

version(unittest)
{
    import blerp.blerp;
    static this()
    {
        import core.runtime;
        Runtime.moduleUnitTester = { return true; };
        runTests!(__MODULE__);
    }
}

import blerp.blerp: BlerpTest;

```
That overrides the default test runner, and runs blerp's.

Include the following at the top of all other files with tests in them:

```

version(unittest)
{
    import blerp.blerp;
    static this()
    {
        runTests!(__MODULE__);
    }
}

import blerp.blerp: BlerpTest;

```

## Making tests discoverable by Blerp

Simply add the `BlerpTest` [UDA](https://dlang.org/spec/attribute.html#uda) to every test
you wish Blerp to run.

```

@BlerpTest("test_my_test_name") unittest
{
    writeln("My Unittest");
}

```

## Example output

The below shows an example of some test output, including multiple modules, and
a failed test.

```

Generating test runner configuration 'blerp-test-library' for 'library' (library).
Performing "unittest" build using /usr/bin/dmd for x86_64.
blerp ~master: building configuration "blerp-test-library"...
Linking...
Running ./lib/blerp-test-library 
==================================  BLERP  ==================================
1 Tests Failed 0 Tests Succeeded
source/example.d:14
unittest failure
core.exception.AssertError@source/example.d(14): unittest failure
PRunning ./lib/blerp-test-library 
==================================  blerp.example  ==================================

PASSED    blerp.example.unittest_one
FAILED    blerp.example.Unittest_two
PASSED    blerp.example.hello

3 Tests Ran
1 Tests Failed and 2 Tests Succeeded.

==================================  blerp.example.Unittest_two  ==================================

source/example.d:35
unittest failure
??:? _d_unittestp [0x560115687add]
source/example.d:35 void blerp.example.__unittest_L33_C28() [0x560115685111]
source/blerp/blerp.d:69 bool blerp.blerp.runTests!("blerp.example").runTests() [0x560115683d20]
source/example.d:11 void blerp.example._staticCtor_L9_C20() [0x560115685090]
??:? void blerp.example.__modctor() [0x560115685124]
??:? void rt.minfo.runModuleFuncs!(rt.minfo.ModuleGroup.runTlsCtors().__lambda1).runModuleFuncs(const(immutable(object.ModuleInfo)*)[]) [0x5601156aacca]
??:? void rt.minfo.ModuleGroup.runTlsCtors() [0x5601156aa994]
??:? int rt.minfo.rt_moduleTlsCtor().__foreachbody1(ref rt.sections_elf_shared.DSO) [0x56011568ce60]
??:? int rt.sections_elf_shared.DSO.opApply(scope int delegate(ref rt.sections_elf_shared.DSO)) [0x56011568d384]
??:? rt_moduleTlsCtor [0x56011568ce40]
??:? rt_init [0x5601156892d3]
??:? void rt.dmain2._d_run_main2(char[][], ulong, extern (C) int function(char[][])*).runAll() [0x560115689883]
??:? void rt.dmain2._d_run_main2(char[][], ulong, extern (C) int function(char[][])*).tryExec(scope void delegate()) [0x560115689820]
??:? _d_run_main2 [0x560115689788]
??:? _d_run_main [0x560115689505]
/usr/include/dlang/dmd/core/internal/entrypoint.d:29 main [0x560115673951]
??:? __libc_start_main [0x7fc9184e6022]


==================================  example2  ==================================

          Ignoring test example2, it is not marked as a BlerpTest

0 Tests Ran
0 Tests Failed and 0 Tests Succeeded.



All unit tests have been run successfully.
Program exited with code 1

```


## FAQ

1: Will Blerp have coloured output

Ugh, eventually. But most existing terminal colouring libraries won't work at compile
time, and I have yet to write my own.

2: Can I run tests selectively?

Not at the moment, this is something I'd like to support.

3: Why do I have to put stuff at the top of every file. Why isnt it magic!

Because Blerp needs the name of the module do discover and run tests.
`moduleUnitTester` gets defined in only one module, and therefore you can only
pass through the name of the module you defined it in.
So, we must call a test runner with the module name, in each module.

This might change if I figure out how to get a list of all modules in the package.

4: Will you put this on dub?

At some point.

5: Can I use this in production?

Probably? Its not got *that* many moving parts.
If you do, I'd be thrilled to know.
