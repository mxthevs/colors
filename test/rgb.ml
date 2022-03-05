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

let equality =
  [
    ("from_hex_string", `Quick, can_create_rgb_string);
    ("from_hex_string rgba", `Quick, can_create_rgba_string);
  ]
