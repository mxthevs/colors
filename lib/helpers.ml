let list_to_option = function
  | x :: _ -> Some x
  | _ -> None

let uniq_cons x xs = if List.mem x xs then xs else x :: xs
let remove_from_right xs = List.fold_right uniq_cons xs []
let dedup = remove_from_right
