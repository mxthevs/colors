open Cmdliner

type conf = {
  input_file : string option;
  show_rgb : bool;
}

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
