open Colors_lib
open Cmdliner

type conf = {
  input_file : string option;
  show_rgb : bool;
}

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
    let rgb = Rgb.to_string (Rgb.from_string hex) in
    hex ^ " - " ^ rgb

let run conf =
  let file_name =
    match conf.input_file with
    | Some file -> file
    | None -> failwith "No file path provided"
  in

  file_name
  |> File.read
  |> handle_file
  |> List.map Hex.to_string
  |> List.filter (fun c -> not (Hex.is_nocolor c))
  |> Helpers.dedup
  |> List.map (get_color_string conf.show_rgb)
  |> List.iter print_endline

let input_file_term =
  let info = Arg.info [] ~docv:"FILE" ~doc:"Path to file" in
  Arg.value (Arg.pos 0 (Arg.some Arg.file) None info)

let show_rgb_term =
  let default = false in
  let info =
    Arg.info [ "rgb" ] ~docv:"BOOL" ~doc:"Print RGB values of the parsed hexadecimals to console."
  in
  Arg.value (Arg.opt Arg.bool default info)

let cmdline_term =
  let combine input_file show_rgb = { input_file; show_rgb } in
  Term.(const combine $ input_file_term $ show_rgb_term)

let doc = "Extract colors from any text file."

let man =
  [
    `S Manpage.s_description;
    `P
      "Extract colors from any text file. It can also convert values between different color \
       formats. Currently supported conversions: Hexadecimal to RGB.";
    `S Manpage.s_authors;
    `P "Matheus Henrique <mxthevsh@gmail.com>";
    `S Manpage.s_bugs;
    `P "You can report bugs at https://github.com/mxthevs/colors/issues";
  ]

let parse_command_line () =
  let info = Term.info ~doc ~man ~version:"0.0.1" "colors" in
  match Term.eval (cmdline_term, info) with
  | `Error _ -> exit 1
  | `Version -> exit 0
  | `Help -> exit 0
  | `Ok conf -> conf

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
  let conf = parse_command_line () in
  safe_run conf

let () = main ()
