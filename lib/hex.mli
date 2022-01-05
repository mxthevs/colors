type t = string option

val of_string : string -> t

val to_string : t -> string

val is_nocolor : string -> bool
