open! Core
open Effect
open Effect.Deep

type _ Effect.t += Not : bool -> bool t

let handle f =
  try_with
    f
    ()
    { effc =
        (fun (type a) (eff : a t) ->
          match eff with
          | Not b -> Some (fun (k : (a, _) continuation) -> continue k (not b))
          | _ -> None)
    }
;;

let fancy_not (b : bool) : bool = perform (Not b)
