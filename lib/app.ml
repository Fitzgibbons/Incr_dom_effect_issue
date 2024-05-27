open Core
open Incr_dom

let should_fail_immediately = false

module Model = struct
  type t =
    { bool : bool
    ; fancy_not : bool -> bool [@compare.ignore]
    }
  [@@deriving fields, compare]

  let init ~fancy_not = { bool = false; fancy_not }

  let do_not t =
    let bool = t.fancy_not t.bool in
    { t with bool }
  ;;

  let cutoff t1 t2 = compare t1 t2 = 0
end

module Action = struct
  type t = Do_not [@@deriving sexp]
end

module State = struct
  type t = unit
end

let apply_action model action _ ~schedule_action:_ =
  match (action : Action.t) with
  | Do_not -> Model.do_not model
;;

let on_startup ~schedule_action:_ _ = Async_kernel.return ()

let view (m : Model.t Incr.t) ~inject =
  let open Incr.Let_syntax in
  let open Vdom in
  let button =
    Node.button
      ~attrs:
        [ Attr.many_without_merge
            [ Attr.id (String.lowercase "do_not")
            ; Attr.on_click (fun _ev -> inject Action.Do_not)
            ]
        ]
      [ Node.text "Do Not" ]
  in
  let%map input =
    let%map input_text = m >>| Model.bool in
    Node.textarea
      ~attrs:
        [ Attr.many
            [ Attr.id "bool"
            ; Attr.type_ "text"
            ; Attr.string_property "value" (Bool.to_string input_text)
            ]
        ]
      [ Node.text "" ]
  in
  Node.body ~attrs:[] [ input; Node.br (); button ]
;;

let create model ~old_model:_ ~inject =
  let open Incr.Let_syntax in
  let%map apply_action =
    let%map model = model in
    apply_action model
  and view = view model ~inject
  and model = model in
  if should_fail_immediately then Fn.ignore (model.fancy_not true);
  Component.create ~apply_action model view
;;

let initial_model = Model.init
