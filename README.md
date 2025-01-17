# prometheus_cowboy #

Copyright (c) 2016,2017 Ilya Khaprov. (c) 2025 Erlang Solutions LTD.

[![Hex.pm](https://img.shields.io/hexpm/v/prometheus_cowboy.svg?maxAge=2592000?style=plastic)](https://hex.pm/packages/prometheus_cowboy)
[![Hex.pm](https://img.shields.io/hexpm/dt/prometheus_cowboy.svg?maxAge=2592000)](https://hex.pm/packages/prometheus_cowboy)
[![Hex
Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/prometheus_cowboy/)
[![GitHub Actions](https://github.com/NelsonVides/prometheus_cowboy/actions/workflows/main.yml/badge.svg)](https://github.com/NelsonVides/prometheus_cowboy/actions/workflows/main.yml)
[![Codecov](https://codecov.io/github/NelsonVides/prometheus_cowboy/graph/badge.svg?token=G9HB5UKNIY)](https://codecov.io/github/NelsonVides/prometheus_cowboy)

## Exporting metrics with handlers

Cowboy 1:

```erlang

Routes = [
          {'_', [
                 {"/metrics/[:registry]", prometheus_cowboy1_handler, []},
                 {"/", toppage_handler, []}
                ]}
         ]

```

Cowboy 2:

```erlang

Routes = [
          {'_', [
                 {"/metrics/[:registry]", prometheus_cowboy2_handler, []},
                 {"/", toppage_handler, []}
                ]}
         ]

```

## Exporting Cowboy2 metrics

```erlang

  {ok, _} = cowboy:start_clear(http, [{port, 0}],
                               #{env => #{dispatch => Dispatch},
                                 metrics_callback => fun prometheus_cowboy2_instrumenter:observe/1,
                                 stream_handlers => [cowboy_metrics_h, cowboy_stream_h]})

```

## Contributing

Section order:

- Types
- Macros
- Callbacks
- Public API
- Deprecations
- Private Parts

Install the `git` pre-commit hook:

```bash

./bin/pre-commit.sh install

```

The pre-commit check can be skipped by passing `--no-verify` to `git commit`.

## License

MIT
