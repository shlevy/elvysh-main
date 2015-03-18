(* A view which may or may not have been consumed.
 *
 * Indexed by wrapped view.
 *
 * Because the constructors are indistinguishable by type index, it is
 * impossible to pattern match on a maybe_consumed view, and thus impossible
 * to consume it or access the "wrapped" view. As such, it is probably only
 * useful in the context of main wrappers, where we want to signify that some
 * view is accessible at the beginning of the program but may optionally be
 * consumed in the course of it.
 *)
dataview maybe_consumed ( v: view ) =
  | { v: view } not_consumed ( v ) of ( v )
  | { v: view } was_consumed ( v )
