Blerp
=======================


Blerp is a library for D which blerps out an enumerated, ordered list of all
unittests that were ran and logs the number of succeeded and failed tests.

Because by default, D doesnt really print anything useful if all tests pass.

It doesnt do anything clever like colour the output atm.

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
Program exited with code 1
```
