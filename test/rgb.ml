open Colors_lib

let pprint_rgb ppf rgb = Fmt.pf ppf "%s" (Rgb.to_string rgb)
let eq_rgb a b = Rgb.to_string a = Rgb.to_string b

let rgb =
  let open Alcotest in
  testable pprint_rgb eq_rgb

let pprint_rgb_tuple ppf tup =
  let r, g, b, a = tup in
  Fmt.pf ppf "(%d, %d, %d, %f)" r g b a

let eq_rgb_tuple a b =
  let r1, g1, b1, a1 = a in
  let r2, g2, b2, a2 = b in
  r1 = r2 && g1 = g2 && b1 = b2 && a1 = a2

let rgb_tuple =
  let open Alcotest in
  testable pprint_rgb_tuple eq_rgb_tuple

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

let can_unwrap_rgb () =
  let open Alcotest in
  let output = (255, 255, 255, 1.0) in

  (check rgb_tuple) "should be equal" output (Rgb.unwrap (Rgb.from_hex_string "#FFFFFF"))

let equality =
  [
    ("from_hex_string", `Quick, can_create_rgb_string);
    ("from_hex_string rgba", `Quick, can_create_rgba_string);
    ("of_string invalid", `Quick, cannot_create_rgb_from_invalid_hex_string);
    ("unwrap", `Quick, can_unwrap_rgb);
  ]
