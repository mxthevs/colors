open Colors_lib

let pprint_hex ppf hex = Fmt.pf ppf "%s" (Hex.to_string hex)
let eq_hex a b = Hex.to_string a = Hex.to_string b

let hex =
  let open Alcotest in
  testable pprint_hex eq_hex

let can_create_hex_string () =
  let open Alcotest in
  let input = "#7159c1" in
  let output = Hex.of_string "#7159C1" in

  (check hex) "should be equal" output (Hex.of_string input)

let can_create_hex_string_with_no_hash () =
  let open Alcotest in
  let input = "7159c1" in
  let output = Hex.of_string "#7159C1" in

  (check hex) "should be equal" output (Hex.of_string input)

let can_create_hex_string_with_alpha () =
  let open Alcotest in
  let input = "#7159c188" in
  let output = Hex.of_string "#7159c188" in

  (check hex) "should be equal" output (Hex.of_string input)

let can_create_hex_string_with_alpha_and_no_hash () =
  let open Alcotest in
  let input = "7159c188" in
  let output = Hex.of_string "7159c188" in

  (check hex) "should be equal" output (Hex.of_string input)

let cannot_create_invalid_hex () =
  let open Alcotest in
  let inputs = [ "#715"; "LOL"; "#110YAB"; "#7159C12"; "#" ] in
  let outputs = List.map Hex.of_string inputs in

  let all_invalid = outputs |> List.filter Hex.is_valid |> List.length = 0 in

  (check bool) "should be equal" true all_invalid

let equality =
  [
    ("of_string", `Quick, can_create_hex_string);
    ("of_string no hash", `Quick, can_create_hex_string_with_no_hash);
    ("of_string with alpha", `Quick, can_create_hex_string_with_alpha);
    ("of_string with alpha no hash", `Quick, can_create_hex_string_with_alpha_and_no_hash);
    ("of_string invalid", `Quick, cannot_create_invalid_hex);
  ]
