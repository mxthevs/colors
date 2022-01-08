type rgb =
  | RGB  of int * int * int
  | RGBa of int * int * int * float

type t = rgb option

val from_string : string -> t

val from_hex : Hex.t -> t

val to_string : t -> string
