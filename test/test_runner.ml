open Colors_test

(**
  Entrypoint for the test runner.
  This aggregates all the tests and call Alcotest to run them. When
  creating a new test suite, don't forget to add it here!
*)

let () =
  let open Alcotest in
  run "Colors" [ ("parser equality", Parser.equality) ]
