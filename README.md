# Setaria

Setaria is OATH One Time Passwords Library for Elixir.
This is wrapper of [POT](https://hex.pm/packages/pot).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `setaria` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:setaria, "~> 0.1.0"}]
    end
    ```

  2. Ensure `setaria` is started before your application:

    ```elixir
    def application do
      [applications: [:setaria]]
    end
    ```

## Usage

  NOTE: Some parameters are fixed now. The timestep is 30, digits is 6, and digest method is sha.

  * create hotp

    ```elixir
    # base32encoded secret
    hotp = Setaria.hotp(encoded_secret, counter)

    # raw secret
    hotp = Setaria.hotp(secret, counter, encoded_secret: false)
    ```

  * validate hotp

    ```elixir
    # base32encoded secret
    is_valid = Setaria.valid_hotp(expected_token, encoded_secret, counter)

    # raw secret
    is_valid = Setaria.valid_hotp(expected_token, secret, counter, encoded_secret: false)
    ```

  * create totp

    ```elixir
    # base32encoded secret
    totp = Setaria.totp(encoded_secret)
    totp = Setaria.totp(encoded_secret, timestamp)

    # raw secret
    totp = Setaria.totp(secret, encoded_secret: false)
    totp = Setaria.totp(secret, timestamp, encoded_secret: false)
    ```

  * validate hotp

    ```elixir
    # base32encoded secret
    is_valid = Setaria.valid_totp(expected_token, encoded_secret)
    is_valid = Setaria.valid_totp(expected_token, encoded_secret, timestamp)

    # raw secret
    is_valid = Setaria.valid_totp(expected_token, secret, encoded_secret: false)
    is_valid = Setaria.valid_totp(expected_token, secret, timestamp, encoded_secret: false)
    ```



