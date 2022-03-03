open Colors_lib

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

  List.rev (aux file [])

let get_color_string show_rgb hex =
  if not show_rgb then
    hex
  else
    let rgb = Rgb.to_string (Rgb.from_hex_string hex) in
    hex ^ " - " ^ rgb

let run (conf : Cli.conf) =
  let file_name =
    match conf.input_file with
    | Some file -> file
    | None -> failwith "No file path provided"
  in

  file_name
  |> File.read
  |> handle_file
  |> List.filter (fun hex -> not @@ Hex.is_invalid hex)
  |> List.map Hex.to_string
  |> Helpers.dedup
  |> List.map (get_color_string conf.show_rgb)
  |> List.iter print_endline

let safe_run conf =
  try run conf with
  | Failure message ->
    Printf.eprintf "Error: %s!\n" message;
    exit 1
  | error ->
    let trace = Printexc.get_backtrace () in
    Printf.eprintf "Error: exception %s\n%s" (Printexc.to_string error) trace

let main () =
  Printexc.record_backtrace true;
  let conf = Cli.parse_command_line () in
  safe_run conf

let () = main ()
