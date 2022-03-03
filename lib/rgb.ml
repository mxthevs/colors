type rgb =
  | RGB  of int * int * int
  | RGBa of int * int * int * float

type t = rgb option

exception Invalid_rgb_format of string

let invalid_rgb_format () =
  raise (Invalid_rgb_format "trying to call to_string on an invalid rgb value")

let is_valid_rgb (r, g, b) ~alpha =
  (r >= 0 && r <= 255)
  && (g >= 0 && g <= 255)
  && (b >= 0 && b <= 255)
  && alpha >= 1.0
  && alpha <= 255.0

let from_hex_string hex_s =
  try
    let r = hex_s |> Parser.skip 1 |> Parser.take 2 |> Helpers.cat "0x" |> int_of_string in
    let g = hex_s |> Parser.skip 3 |> Parser.take 2 |> Helpers.cat "0x" |> int_of_string in
    let b = hex_s |> Parser.skip 5 |> Parser.take 2 |> Helpers.cat "0x" |> int_of_string in

    if String.length hex_s = 7 then
      match is_valid_rgb (r, g, b) ~alpha:1.0 with
      | true -> Some (RGB (r, g, b))
      | false -> None
    else if String.length hex_s = 9 then
      let alpha =
        hex_s
        |> Parser.skip 7
        |> Parser.take 2
        |> Helpers.cat "0x"
        |> float_of_string
        |> (fun a -> a /. 255.)
        |> Helpers.to_fixed 3
      in

      match is_valid_rgb (r, g, b) ~alpha with
      | true -> Some (RGBa (r, g, b, alpha))
      | false -> None
    else
      None
  with
  | Failure _ -> None

let from_hex hex =
  let hex_string = Hex.to_string hex in
  from_hex_string hex_string

(* Maybe we can just fail if t is None *)
let to_string = function
  | Some (RGB (r, g, b)) -> Printf.sprintf "rgb(%d, %d, %d)" r g b
  | Some (RGBa (r, g, b, a)) -> Printf.sprintf "rgba(%d, %d, %d, %f)" r g b a
  | None -> invalid_rgb_format ()
