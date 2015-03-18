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

Optionally-consumed views
--------------------------

In some cases, an entry point may want to define a view that may be consumed
before the end of the program, but doesn't have to be. For example, POSIX allows
you to `close` file descriptor `0`. `maybe-consumed.sats` addresses this by
defining a dataview that can wrap a prval of a given view *or* wrap nothing
without changing the type.

For example, a function whose type includes
`!filedes ( 0 )  >> maybe_consumed ( filedes ( 0 ) )` can either close the
file that is passed in and construct a `was_consumed ( )` in its place *or*
keep the file open and construct a `not_consumed ( prf )` in its place. Note
that neither case allows the caller to tell which occurred or to extract out
the view if it was not consumed, so this is only useful when all following code
is indifferent to the state of the proof.

posix-main
----------

`posix-main.hats` defines the `posix_main` interface, to represent `main` on
`POSIX` systems. In addition to `argc` and `argv`, `posix_main` takes an
`errno_v ( free )` view (see [elvysh-errno][1]) that must end up unconsumed,
as well as `filedes` views (see [elvysh-filedes][3]) for `stdin`, `stdout`, and
`stderr` that may optionally be consumed.

Future work
-----------

Further entry points may be added as need arises.


Part of the [elvysh][2] project.

[1]: https://github.com/shlevy/elvysh-errno
[2]: https://github.com/shlevy/elvysh-project-documentation
[3]: https://github.com/shlevy/elvysh-filedes
