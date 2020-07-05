import gleam/bool
import gleam/string_builder
import gleam/list
import gleam/string
import gleam/result

// This library will support *nix systems first, and possibly add Windows
// support later
fn separator() {
  "/"
}

// Direction and Grapheme needed in order to use string.trim from Erlang
type Direction {
  Both
  Leading
  Trailing
}
external type Grapheme

external fn to_graphemes(String) -> List(Grapheme) = "string" "to_graphemes"
external fn trim(String, Direction, List(Grapheme)) -> String = "string" "trim"

external fn slice(String, Int, Int) -> String = "string" "slice"
external fn find(String, String, Direction) -> String = "string" "find"

// trim_separator/1 removes the path separator from the beginning and end of a
// string
pub fn trim_separator(fragment: String) -> String {
  trim(fragment, Both, to_graphemes(separator()))
}

// join/1 concatenates a number of path fragments with the path separator,
// trimming any leftover separator characters from each fragment.
pub fn join(input_paths: List(String)) -> String {
  input_paths
  |> list.map(_, trim_separator)
  |> list.intersperse(_, with: separator())
  |> string_builder.from_strings
  |> string_builder.prepend(_, separator())
  |> string_builder.to_string
}

// split/1 splits a full path into its component path fragments
pub fn split(input_path: String) -> List(String) {
  input_path
  |> string.split(_, on: separator())
  |> list.filter(_, fn(x) { x != "" })
}

// is_absolute/1 tests if a path is rooted at the root of the filesystem
pub fn is_absolute(input_path: String) -> Bool {
  let root = slice(input_path, 0, 1)
  root == separator()
}

// is_relative/1 tests if a path is not rooted
pub fn is_relative(input_path: String) -> Bool {
  bool.negate(is_absolute(input_path))
}

// basename/1 returns the base name of a path, the final non-delimited fragment
pub fn basename(input_path: String) -> String {
  input_path
  |> string.split(_, on: separator())
  |> list.reverse
  |> list.head
  |> result.unwrap(_, or: "")
}

// dirname/1 returns the full directory of a path, trimming any basename
pub fn dirname(input_path: String) -> String {
  input_path
  |> string.reverse
  |> find(_, separator(), Leading)
  |> trim(_, Leading, to_graphemes(separator()))
  |> string.reverse
}
