# json-server Habitat Plan

This plan builds a [json-server](https://github.com/typicode/json-server)
[Habitat](https://www.habitat.sh/) package.

## Building

From this directory:

```bash
hab studio enter
build
```

## Running

Run `hab start smith/json-server`.

If you've built your own package, run:

```bash
hab start $HAB_ORIGIN/json-server
```

The server will now be running on the port specified in
[default.toml](default.toml).

## Configuring

The available configuration options are in default.toml. Use `hab config apply`
to apply configuration:

```bash
hab config apply json-server.default 1
port = 8080
delay = 200
^D
```

Where `1` is the version of the configuration (this is a number that must
increase every time you change the configuration; use `$(date +%s)` to generate
and use a timestamp).

Typing the command with no arguments creates a standard input prompt, into
which you can type [TOML](https://github.com/toml-lang/toml). Typing a blank
line then control-d `^D` will exit the prompt and apply the configuration.

You can also pass a TOML filename as an argument or pipe TOML text into the
`hab config apply` command. See the [Configuration
updates](https://www.habitat.sh/docs/run-packages-apply-config-updates/)
Habitat documentation for more about how to configure services.

### JSON Data

You can specify config like this:

```toml
[data]

[[data.users]]

id = 1
name = "Joe"
age = 23

[[data.users]]

id = 2
name = "Melinda"
age = 19
```

Then go to http://localhost:3000/users and see:

```json
[
  {
    "id": 1,
    "age": 23,
    "name": "Joe"
  },
  {
    "id": 2,
    "age": 19,
    "name": "Melinda"
  }
]
```

If you set the `source` configuration option to filename of a JSON or
JavaScript file it will use that file as the database. `source` can also be a
remote URL. Setting `source` takes precedence over any `[data]` setting.

See https://github.com/typicode/json-server for more.
