# Setaria [![GitHub Actions Test][test-img]][test] [![GitHub Actions CI][ci-img]][ci]

[test]: https://github.com/ritou/elixir-setaria
[test-img]: https://github.com/ritou/elixir-setaria/workflows/test/badge.svg
[ci]: https://github.com/ritou/elixir-setaria
[ci-img]: https://github.com/ritou/elixir-setaria/workflows/ci/badge.svg

Setaria is OATH One Time Passwords Library for Elixir.
This is wrapper of [POT](https://hex.pm/packages/pot).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `setaria` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:setaria, "~> 0.2.0"}]
    end
    ```

  2. Ensure `setaria` is started before your application:

    ```elixir
    def application do
      [applications: [:setaria]]
    end
    ```

## Usage

  see [hexdocs](https://hexdocs.pm/setaria/api-reference.html)
