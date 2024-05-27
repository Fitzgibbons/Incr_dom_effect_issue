open! Core

module Model : sig
  type t

  val cutoff : t -> t -> bool
end

include Incr_dom.App_intf.S with type State.t = unit and module Model := Model

val initial_model : fancy_not:(bool -> bool) -> Model.t
