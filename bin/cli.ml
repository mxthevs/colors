open Cmdliner

let file =
  let info = Arg.info [] ~docv:"FILE" ~doc:"Path to file" in
  Arg.value (Arg.pos 0 (Arg.some Arg.file) None info)

let rgb =
  let default = false in
  let info =
    Arg.info [ "rgb" ] ~docv:"BOOL" ~doc:"Print RGB values of the parsed hexadecimals to console."
  in
  Arg.value (Arg.opt Arg.bool default info)

let colors_t fn = Term.(const fn $ file $ rgb)

let cmd fn =
  let doc = "Extract colors from any text file." in
  let man =
    [
      `S Manpage.s_description;
      `P "Extract colors from any text file.";
      `S Manpage.s_authors;
      `P "Matheus Henrique <mxthevsh@gmail.com>";
      `S Manpage.s_bugs;
      `P "You can report bugs at https://github.com/mxthevs/colors/issues";
    ]
  in
  let info = Cmd.info "colors" ~doc ~man ~version:"0.0.1" in
  Cmd.v info (colors_t fn)

let run_command fn = exit (Cmd.eval (cmd fn))
