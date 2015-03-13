staload "elvysh/errno.sats"

(* Define a POSIX entry point
 *
 * When this header is #included, the user is expected to implement posix_main
 * instead of main. In addition to argc and argv, posix_main's interface
 * takes views corresponding to initial global program state in the POSIX
 * environment.
 *
 * Currently, an errno_v ( free ) proof is passed. In the future, proofs
 * corresponding to open file descriptors for stdin, stdout, and stderr will
 * be passed as well.
 *
 * It is expected to include this file directly into the file which implements
 * posix_main
 *)

(* posix_main interface *)
extern fun posix_main { n:int | n >= 1 } ( ev: !errno_v ( free )
                                         | argc: int n
                                         , argv: !argv ( n )
                                         ): int = "sta#elvysh_main_posix_main"

(* main impl *)
implement main ( argc, argv ) = let
  extern praxi { v: view } __assert_view (): v
  prval ev = __assert_view< errno_v(free) > ()
  val res = posix_main ( ev | argc, argv )
  extern praxi { v: view } __unassert_view ( x: v ): ()
  prval _ = __unassert_view ( ev )
in res end
