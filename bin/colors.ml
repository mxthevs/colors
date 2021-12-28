open Colors_lib

let usage = "USAGE: esy x colors <path/to/file>"

let () =
  match Array.to_list Sys.argv with
  | [ _program; file_name ] -> print_endline file_name
  | _ ->
    prerr_endline usage;
    exit 1
