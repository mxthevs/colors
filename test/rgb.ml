open Colors_lib

let pprint_rgb ppf rgb = Fmt.pf ppf "%s" (Rgb.to_string rgb)
let eq_rgb a b = Rgb.to_string a = Rgb.to_string b

let rgb =
  let open Alcotest in
  testable pprint_rgb eq_rgb

let can_create_rgb_string () =
  let open Alcotest in
  let input = "#dd4b3a" in
  let output = Rgb.from_hex_string "#DD4b3A" in

  (check rgb) "should be equal" output (Rgb.from_hex_string input)

let can_create_rgba_string () =
  let open Alcotest in
  let output = Rgb.from_hex_string "#dd4b3a55" in

  (check bool) "should be equal" true (Rgb.is_valid output)

let cannot_create_rgb_from_invalid_hex_string () =
  let open Alcotest in
  let inputs = [ "#715"; "LOL"; "#110YAB"; "#7159C12"; "#" ] in
  let outputs = List.map Rgb.from_hex_string inputs in

  let all_invalid = outputs |> List.filter Rgb.is_valid |> List.length = 0 in

  (check bool) "should be equal" true all_invalid

let equality =
  [
    ("from_hex_string", `Quick, can_create_rgb_string);
    ("from_hex_string rgba", `Quick, can_create_rgba_string);
    ("of_string invalid", `Quick, cannot_create_rgb_from_invalid_hex_string);
  ]
