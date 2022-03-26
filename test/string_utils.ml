open Colors_lib

let can_take_substrings () =
  let open Alcotest in
  let input = "It's dangerous to go alone! Take this." in
  let output = "It's dangerous" in

  (check string) "should be equal" output (String_utils.take 14 input)

let can_split_a_string_in_two () =
  let open Alcotest in
  let input = "I think that #7159C1 is a nice color" in
  let output = ("I think that ", "7159C1 is a nice color") in

  (check (pair string string))
    "should be equal" output
    (Option.get (String_utils.lsplit2 input ~on:'#'))

let cant_split_if_char_is_inexistent () =
  let open Alcotest in
  let input = "Never gonna give you up" in
  let output = None in

  (check (option (pair string string)))
    "should be equal" output
    (String_utils.lsplit2 input ~on:'#')

let can_split_a_string_in_two_inclusive () =
  let open Alcotest in
  let input = "I think that #7159C1 is a nice color" in
  let output = ("I think that ", "#7159C1 is a nice color") in

  (check (pair string string))
    "should be equal" output
    (Option.get (String_utils.lsplit2i input ~on:'#'))

let can_combine_take_and_lsplit () =
  let open Alcotest in
  let input = "I think that #7159C1 is a nice color" in
  let output = "#7159C1" in

  let result =
    input
    |> String_utils.lsplit2i ~on:'#'
    |> Option.fold ~none:"Could not find `#`. So sad." ~some:snd
    |> String_utils.take 7
  in

  (check string) "should be equal" output result

let equality =
  [
    ("substrings", `Quick, can_take_substrings);
    ("lsplit2", `Quick, can_split_a_string_in_two);
    ("lsplit2 fail", `Quick, cant_split_if_char_is_inexistent);
    ("lsplit2i", `Quick, can_split_a_string_in_two_inclusive);
    ("lsplit2i + take", `Quick, can_combine_take_and_lsplit);
  ]
