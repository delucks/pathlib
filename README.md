# pathlib

`pathlib` is a Gleam library for working with filesystem paths on Unix systems. Analogous modules are Elixir's `Path` or Python's `os.path`.

## Usage

```gleam
let test_path = "/opt/installation/bin/client"

// Test if the path is rooted
pathlib.is_absolute(test_path) // -> True
pathlib.is_relative(test_path) // -> False

// Remove root and trailing slash
pathlib.trim_separator(test_path) // -> "opt/installation/bin/client"

// basename & dirname
pathlib.basename(test_path) // -> "client"
pathlib.dirname(test_path)  // -> "/opt/installation/bin"

// split & join
pathlib.split(test_path)           // -> ["opt", "installation", "bin", "client"]
pathlib.join(["usr", "bin", "ls"]) // -> "/usr/bin/ls"
```

## Quick start

```sh
# Build the project
rebar3 compile

# Run the eunit tests
rebar3 eunit

# Run the Erlang REPL
rebar3 shell
```


## Installation

If [available in Hex](https://www.rebar3.org/docs/dependencies#section-declaring-dependencies)
this package can be installed by adding `pathlib` to your `rebar.config` dependencies:

```erlang
{deps, [
    pathlib
]}.
```
