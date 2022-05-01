open Colors_lib

let handle_file file =
  let rec aux rest colors =
    let splitted = String_utils.lsplit2i ~on:'#' rest in
    let hex_size = 7 in

    match splitted with
    | None -> colors
    | Some (_, rest) ->
      let color = String.trim rest |> String_utils.take hex_size |> Hex.of_string in
      aux (String_utils.skip hex_size rest) (color :: colors)
  in

  List.rev (aux file [])

let to_notty_color rgb =
  let open Notty in
  let r, g, b, _ = Rgb.unwrap rgb in
  A.rgb_888 ~r ~g ~b

let to_notty_image original color =
  let open Notty in
  I.string ~attr:A.(fg (to_notty_color color)) original

let color_string hex ~with_rgb =
  if with_rgb then
    let rgb = Rgb.to_string (Rgb.from_hex_string hex) in
    hex ^ " - " ^ rgb
  else
    hex

let run file show_rgb =
  let file_name =
    match file with
    | Some file -> file
    | None -> failwith (Ui.error "No file path provided!")
  in

  let colors =
    file_name
    |> File.read
    |> handle_file
    |> List.filter Hex.is_valid
    |> List.map Hex.to_string
    |> Helpers.dedup
    |> List.map @@ fun original ->
       (color_string original ~with_rgb:show_rgb, Rgb.from_hex_string original)
  in

  match colors with
  | [] -> print_endline (Ui.warn "No colors found in this file.")
  | colors ->
    print_endline (Ui.success "Found the following colors in this file:");

    colors
    |> List.iter @@ fun (color_string, rgb) ->
       let image = to_notty_image color_string rgb in
       Notty_unix.output_image image;
       print_string "\n"

let safe_run file show_rgb =
  try run file show_rgb with
  | Failure message ->
    Printf.eprintf "%s\n" message;
    exit 1
  | error ->
    print_string (Ui.error "Oops! An unhandled error occured!");
    print_endline "If you can, please report this bug.";
    print_endline (Ui.info "https://github.com/mxthevs/colors/issues");

    let trace = Printexc.get_backtrace () in
    Printf.eprintf "Exception %s\n%s" (Printexc.to_string error) trace

let main () =
  Printexc.record_backtrace true;
  Cli.run_command safe_run

let () = main ()
