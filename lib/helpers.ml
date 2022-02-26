let list_to_option = function
  | x :: _ -> Some x
  | _ -> None

let uniq_cons x xs = if List.mem x xs then xs else x :: xs
let remove_from_right xs = List.fold_right uniq_cons xs []
let dedup = remove_from_right
let cat s1 s2 = s1 ^ s2
let round x = floor (x +. 0.5)

let round_dfrac d x =
  if x -. round x = 0. then
    x
  else
    let m = 10. ** float d in
    floor ((x *. m) +. 0.5) /. m

let to_fixed = round_dfrac
