open Colors_lib

let can_take_substrings () =
  let input = "It's dangerous to go alone! Take this." in
  let output = "It's dangerous" in

  Alcotest.(check string) "should be equal" output (Parser.take 14 input)

let equality = [ ("substrings", `Quick, can_take_substrings) ]
