val list_to_option : 'a list -> 'a option

val dedup : 'a list -> 'a list

val cat : string -> string -> string

val to_fixed : int -> float -> float
(**
  Rounds a floating point number precision to `n` decimal places
  Source: https://github.com/dbuenzli/gg/blob/8f761c278d0b2ee2adb94f9fbc033f1bfd76e536/src/gg.ml#L123-L126
*)
