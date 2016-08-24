defmodule Setaria do
  @moduledoc """

  ## Setaria

  Setaria is OATH One Time Passwords Library for Elixir.  
  This is wrapper of [POT](https://hex.pm/packages/pot).

  NOTE: Some parameters are fixed now. The timestep is 30, digits is 6, and digest method is sha.
  """

  @default_timestep 30

  # hotp
  @doc """
  Create HOTP with base32 encoded secret and counter.
  """
  @spec hotp(String.t, Integer.t) :: String.t
  def hotp(encoded_secret, counter) do
    :pot.hotp(encoded_secret, counter)
  end

  @doc """
  Create HOTP with raw secret and counter.
  """
  @spec hotp(String.t, Integer.t, Keyword.t) :: String.t
  def hotp(raw_secret, counter, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    hotp(encoded_secret,counter)
  end

  # hotp validation
  @doc """
  Validate HOTP with base32 encoded secret and counter.
  """
  @spec valid_hotp(String.t, String.t, Integer.t) :: boolean
  def valid_hotp(token, encoded_secret, counter) do
    :pot.valid_hotp(token, encoded_secret, [{:last, counter - 1}]) == counter
  end

  @doc """
  Validate HOTP with raw secret and counter.
  """
  @spec valid_hotp(String.t, String.t, Integer.t, Keyword.t) :: boolean
  def valid_hotp(token, raw_secret, counter, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_hotp(token, encoded_secret, counter)
  end

  # totp
  @doc """
  Create TOTP with base32 encoded secret and current timestamp.
  """
  @spec totp(String.t) :: String.t
  def totp(encoded_secret) do
    timestamp = System.system_time(:seconds)
    totp(encoded_secret, timestamp)
  end

  @doc """
  Create TOTP with raw secret and current timestamp.
  """
  @spec totp(String.t, Keyword.t) :: String.t
  def totp(raw_secret, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    totp(encoded_secret)
  end

  @doc """
  Create TOTP with base32 encoded secret and timestamp.
  """
  @spec totp(String.t, integer) :: String.t
  def totp(encoded_secret, timestamp) do
    counter = get_counter_from_timestamp(timestamp, @default_timestep)
    hotp(encoded_secret, counter)
  end

  @doc """
  Create TOTP with raw secret and timestamp.
  """
  @spec totp(String.t, integer, Keyword.t) :: String.t
  def totp(raw_secret, timestamp, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    totp(encoded_secret, timestamp)
  end

  # totp validation
  @doc """
  Validate TOTP with token, base32 encoded secret and current timestamp.
  """
  @spec valid_totp(String.t, String.t) :: boolean
  def valid_totp(token, encoded_secret) do
    timestamp = System.system_time(:seconds)
    counter = get_counter_from_timestamp(timestamp, @default_timestep)
    valid_hotp(token, encoded_secret, counter)
  end

  @doc """
  Validate TOTP with token, raw secret and current timestamp.
  """
  @spec valid_totp(String.t, String.t, Keyword.t) :: boolean
  def valid_totp(token, raw_secret, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_totp(token, encoded_secret)
  end

  @doc """
  Validate TOTP with token, base32 encoded secret and timestamp.
  """
  @spec valid_totp(String.t, String.t, integer) :: boolean
  def valid_totp(token, encoded_secret, timestamp) do
    counter = get_counter_from_timestamp(timestamp, @default_timestep)
    valid_hotp(token, encoded_secret, counter)
  end

  @doc """
  Validate TOTP with token, raw secret and timestamp.
  """
  @spec valid_totp(String.t, String.t, integer, Keyword.t) :: boolean
  def valid_totp(token, raw_secret, timestamp, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_totp(token, encoded_secret, timestamp)
  end

  defp get_counter_from_timestamp(timestamp, timestep) do
    trunc(timestamp / timestep)
  end
end
