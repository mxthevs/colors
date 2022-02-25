type rgb =
  | RGB  of int * int * int
  | RGBa of int * int * int * float

type t = rgb option

let from_string hex_s =
  try
    let r = hex_s |> Parser.skip 1 |> Parser.take 2 |> Helpers.cat "0x" |> int_of_string in
    let g = hex_s |> Parser.skip 3 |> Parser.take 2 |> Helpers.cat "0x" |> int_of_string in
    let b = hex_s |> Parser.skip 5 |> Parser.take 2 |> Helpers.cat "0x" |> int_of_string in

    if (r >= 0 && r <= 255) && (g >= 0 && g <= 255) && b >= 0 && b <= 255 then
      Some (RGB (r, g, b))
    else
      None
  with
  | Failure _ -> None

let from_hex hex =
  let hex_string = Hex.to_string hex in
  from_string hex_string

(* Maybe we can just fail if t is None *)
let to_string = function
  | Some (RGB (r, g, b)) -> Printf.sprintf "rgb(%d, %d, %d)" r g b
  | Some (RGBa (r, g, b, a)) -> Printf.sprintf "rgba(%d, %d, %d, %f)" r g b a
  | None -> "[NO_COLOR]"
