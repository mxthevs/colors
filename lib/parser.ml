let take n s = String.sub s 0 n

let lsplit2 s ~on =
  let open String in
  match index_opt s on with
  | Some pos -> Some (sub s 0 pos, sub s (pos + 1) (length s - pos - 1))
  | None -> None
