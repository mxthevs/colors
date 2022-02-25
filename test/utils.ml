let every predicate list =
  let r = ref true in

  let () =
    List.iter
      (fun el ->
        if not @@ predicate el then
          r := false)
      list
  in

  !r
