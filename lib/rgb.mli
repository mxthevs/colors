type t

val from_hex_string : string -> t

val from_hex : Hex.t -> t

val to_string : t -> string

val unwrap : t -> (int * int * int * float)

val is_valid : t -> bool
