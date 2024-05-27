(lang dune 2.7)

(generate_opam_files true)

(package
 (name bonsai_effect_issue)
 (depends
  (core
   (= v0.16.1))
  (incr_dom
   (= v0.16.0))
  (ocaml
   (= 5.0.0))))
