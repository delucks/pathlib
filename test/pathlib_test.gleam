import pathlib
import gleam/expect

pub fn trim_separator_test() {
  pathlib.trim_separator("/usr")
  |> expect.equal(_, "usr")
  pathlib.trim_separator("//toomany/extra/slashes//")
  |> expect.equal(_, "toomany/extra/slashes")
}

pub fn join_test() {
  pathlib.join(["usr", "local", "bin"])
  |> expect.equal(_, "/usr/local/bin")
  pathlib.join(["/usr", "/local", "/bin"])
  |> expect.equal(_, "/usr/local/bin")
  pathlib.join(["/usr/", "/local/", "/bin/"])
  |> expect.equal(_, "/usr/local/bin")
  pathlib.join([])
  |> expect.equal(_, "/")
}

pub fn split_test() {
  pathlib.split("/usr/local/bin")
  |> expect.equal(_, ["usr", "local", "bin"])
  pathlib.split("proc/fd/1")
  |> expect.equal(_, ["proc", "fd", "1"])
  pathlib.split("//shoddy/constructed//path//")
  |> expect.equal(_, ["shoddy", "constructed", "path"])
}

pub fn relative_and_absolute_test() {
  expect.equal(pathlib.is_absolute("/usr/bin"), True)
  expect.equal(pathlib.is_relative("/usr/bin"), False)
  expect.equal(pathlib.is_relative("dev/pathlib"), True)
  expect.equal(pathlib.is_absolute("dev/pathlib"), False)
}

pub fn basename_test() {
  pathlib.basename("/usr/local/bin/ssh")
  |> expect.equal(_, "ssh")
  pathlib.basename("/usr/local/bin/")
  |> expect.equal(_, "")
  pathlib.basename("/usr/local/bin")
  |> expect.equal(_, "bin")
}

pub fn dirname_test() {
  pathlib.dirname("/usr/local/bin/ssh")
  |> expect.equal(_, "/usr/local/bin")
  pathlib.dirname("/usr/local/bin/")
  |> expect.equal(_, "/usr/local/bin")
  pathlib.dirname("/usr/local/bin")
  |> expect.equal(_, "/usr/local")
}
