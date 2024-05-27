# `Incr_dom` effect issue

This repository is meant to demonstrate an undesirable interaction between `Incr_dom` and effect handlers in OCaml 5. In this example an effect handler for a simple effect (`Not`, which just negates a bool) is regeistered at the top-level. While it can be used outside of `incr_dom`, any attempts to use the effect cause an unhandled effect exception once `Start_app.start` is called. I would appreciate help in interpreting why this happens, and how to make `incr_dom` work with effects.

Alternatively, all I really want for now is the ability to call asyncronous javascript functions directly from synchronous OCaml code (specifically the `apply_action` function). I was able to get this to work by using effect handlers to synchonously wait for the javascript function to return, but this doesn't work with `incr_dom`. If there's a already better way to achieve this, I'd be interested to find out, but it would also be nice to understand what is happening with effects.

## To Reproduce
1. `dune build`
2. open `_build/default/bin/index.html`
3. click the "Do Not" button

Alternatively:
1. set `should_fail_immediately` to `true` in `lib/app.ml`
2. `dune build`
3. open `_build/default/bin/index.html`
