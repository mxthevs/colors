open Colors_lib

let usage = "USAGE: esy x colors <path/to/file>"

let handle_file file =
  let rec aux rest colors =
    let splitted = Parser.lsplit2i ~on:'#' rest in
    let hex_size = 7 in

    match splitted with
    | None -> colors
    | Some (_, rest) ->
      let color = String.trim rest |> Parser.take hex_size |> Hex.of_string in
      aux (Parser.skip hex_size rest) (color :: colors)
  in

  aux file []

let () =
  match Array.to_list Sys.argv with
  | [ _program; file_name ] ->
    file_name
    |> File.read
    |> handle_file
    |> List.map Hex.to_string
    |> List.filter (fun c -> not (Hex.is_nocolor c))
    |> Helpers.dedup
    |> List.iter print_endline
  | _ ->
    prerr_endline usage;
    exit 1
