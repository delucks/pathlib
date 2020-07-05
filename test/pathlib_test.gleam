import pathlib
import gleam/should

pub fn trim_separator_test() {
  pathlib.trim_separator("/usr")
  |> should.equal(_, "usr")
  pathlib.trim_separator("//toomany/extra/slashes//")
  |> should.equal(_, "toomany/extra/slashes")
}

pub fn join_test() {
  pathlib.join(["usr", "local", "bin"])
  |> should.equal(_, "/usr/local/bin")
  pathlib.join(["/usr", "/local", "/bin"])
  |> should.equal(_, "/usr/local/bin")
  pathlib.join(["/usr/", "/local/", "/bin/"])
  |> should.equal(_, "/usr/local/bin")
  pathlib.join([])
  |> should.equal(_, "/")
}

pub fn split_test() {
  pathlib.split("/usr/local/bin")
  |> should.equal(_, ["usr", "local", "bin"])
  pathlib.split("proc/fd/1")
  |> should.equal(_, ["proc", "fd", "1"])
  pathlib.split("//shoddy/constructed//path//")
  |> should.equal(_, ["shoddy", "constructed", "path"])
}

pub fn relative_and_absolute_test() {
  should.equal(pathlib.is_absolute("/usr/bin"), True)
  should.equal(pathlib.is_relative("/usr/bin"), False)
  should.equal(pathlib.is_relative("dev/pathlib"), True)
  should.equal(pathlib.is_absolute("dev/pathlib"), False)
}

pub fn basename_test() {
  pathlib.basename("/usr/local/bin/ssh")
  |> should.equal(_, "ssh")
  pathlib.basename("/usr/local/bin/")
  |> should.equal(_, "")
  pathlib.basename("/usr/local/bin")
  |> should.equal(_, "bin")
}

pub fn dirname_test() {
  pathlib.dirname("/usr/local/bin/ssh")
  |> should.equal(_, "/usr/local/bin")
  pathlib.dirname("/usr/local/bin/")
  |> should.equal(_, "/usr/local/bin")
  pathlib.dirname("/usr/local/bin")
  |> should.equal(_, "/usr/local")
}
