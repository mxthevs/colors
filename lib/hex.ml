type t = string option

exception Invalid_hex_format of string

let invalid_hex_format () =
  raise (Invalid_hex_format "trying to call to_string on an invalid hexadecimal code")

let is_hex c =
  [ 'A'; 'B'; 'C'; 'D'; 'E'; 'F'; '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9' ]
  |> List.find_opt (Char.equal c)
  |> Option.is_some

let is_valid_hex hex =
  hex
  |> String.uppercase_ascii
  |> String.to_seq
  |> List.of_seq
  |> List.tl
  |> List.filter is_hex
  |> List.length
  |> fun n -> n = 6

let of_string input =
  (* TODO: allow parsing of hex with alpha value *)
  if input.[0] = '#' && String.length input = 7 then
    match is_valid_hex input with
    | true -> Some (String.uppercase_ascii input)
    | false -> None
  else if String.length input = 6 then
    input
    |> String.uppercase_ascii
    |> String.to_seq
    |> List.of_seq
    |> List.filter (fun c -> not (is_hex c))
    |> Helpers.list_to_option
    |> Option.fold ~none:(Some ("#" ^ String.uppercase_ascii input)) ~some:(fun _ -> None)
  else
    None

let to_string = function
  | Some hex -> hex
  | None -> invalid_hex_format ()

let is_valid = function
  | Some _ -> true
  | None -> false
