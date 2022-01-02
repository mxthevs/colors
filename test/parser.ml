open Colors_lib

let can_take_substrings () =
  let open Alcotest in
  let input = "It's dangerous to go alone! Take this." in
  let output = "It's dangerous" in

  (check string) "should be equal" output (Parser.take 14 input)

let can_split_a_string_in_two () =
  let open Alcotest in
  let input = "I think that #7159C1 is a nice color" in
  let output = ("I think that ", "7159C1 is a nice color") in

  (check (pair string string)) "should be equal" output (Option.get (Parser.lsplit2 input ~on:'#'))

let cant_split_if_char_is_inexistent () =
  let open Alcotest in
  let input = "Never gonna give you up" in
  let output = None in

  (check (option (pair string string))) "should be equal" output (Parser.lsplit2 input ~on:'#')

let equality =
  [
    ("substrings", `Quick, can_take_substrings);
    ("lsplit2", `Quick, can_split_a_string_in_two);
    ("lsplit2 fail", `Quick, cant_split_if_char_is_inexistent);
  ]
