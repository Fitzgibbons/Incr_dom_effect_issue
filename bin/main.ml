open! Core
open! Incr_dom
open! Js_of_ocaml
open Fancy_not
module App = Lib.App

let ready () =
  handle (fun () ->
    assert (not (fancy_not true));
    assert (fancy_not false);
    Start_app.start
      (module App)
      ~bind_to_element_with_id:"app"
      ~initial_model:(App.initial_model ~fancy_not))
;;

let () = ready ()
