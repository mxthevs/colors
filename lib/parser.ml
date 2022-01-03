let take n s = String.sub s 0 n

let lsplit2_aux s ?(padd = 0) ~on () =
  let open String in
  match index_opt s on with
  | Some pos -> Some (sub s 0 pos, sub s (pos + padd) (length s - pos - padd))
  | None -> None

let lsplit2 s ~on = lsplit2_aux s ~on ~padd:1 ()
let lsplit2i s ~on = lsplit2_aux s ~on ()
