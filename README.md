elvysh-main
============

Headers to define alternative program entry points.

The `main` entry points provided by `ATS` expose the runtime components
of the traditional C `main` interface, but don't provide any means to pass in
proofs of initial global program state that only `ATS`'s rich type system can
express. For example, on `POSIX` systems, the file descriptor `0` is open and
readable at the beginning of `main`, and it would be nice to leverage `ATS`'s
rich linear typesystem to express that fact.

Each entry point is represented by a `.hats` file that is to be imported with
`#include`. Each defines a prototype for the alternate `main` function to be
used, and it is expected that the file which includes the `.hats` file also
implements the new function. Each `.hats` file implements `main`.

posix-main
----------

`posix-main.hats` defines the `posix_main` interface, to represent `main` on
`POSIX` systems. In addition to `argc` and `argv`, `posix_main` takes an
`errno_v ( free )` view (see [elvysh-errno][1]), and is required to return with
that view unconsumed and in the same state.

Future work
-----------

Views for the `stdin`, `stdout`, and `stderr` file descriptors will eventually
be added to `posix-main`. Further entry points may be added as need arises.

[1] https://github.com/shlevy/elvysh-errno
