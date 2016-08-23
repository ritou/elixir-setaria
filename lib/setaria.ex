defmodule Setaria do

  @default_timestep 30

  # hotp
  def hotp(encoded_secret, counter) do
    :pot.hotp(encoded_secret, counter)
  end

  def hotp(raw_secret, counter, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    hotp(encoded_secret,counter)
  end

  # hotp validation
  def valid_hotp(token, encoded_secret, counter) do
    :pot.valid_hotp(token, encoded_secret, [{:last, counter - 1}]) == counter
  end

  def valid_hotp(token, raw_secret, counter, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_hotp(token, encoded_secret, counter)
  end

  # totp
  def totp(encoded_secret) do
    timestamp = System.system_time(:seconds)
    totp(encoded_secret, timestamp)
  end

  def totp(raw_secret, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    totp(encoded_secret)
  end

  def totp(encoded_secret, timestamp) do
    counter = get_counter_from_timestamp(timestamp, @default_timestep)
    hotp(encoded_secret, counter)
  end

  def totp(raw_secret, timestamp, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    totp(encoded_secret, timestamp)
  end

  def totp(encoded_secret, timestamp, timestep) do
    counter = get_counter_from_timestamp(timestamp, timestep)
    hotp(encoded_secret, counter)
  end

  def totp(raw_secret, timestamp, timestep, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    totp(encoded_secret, timestamp, timestep)
  end

  # totp validation
  def valid_totp(token, encoded_secret) do
    timestamp = System.system_time(:seconds)
    counter = get_counter_from_timestamp(timestamp, @default_timestep)
    valid_hotp(token, encoded_secret, counter)
  end

  def valid_totp(token, raw_secret, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_totp(token, encoded_secret)
  end

  def valid_totp(token, encoded_secret, timestamp) do
    counter = get_counter_from_timestamp(timestamp, @default_timestep)
    valid_hotp(token, encoded_secret, counter)
  end

  def valid_totp(token, raw_secret, timestamp, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_totp(token, encoded_secret, timestamp)
  end

  def valid_totp(token, encoded_secret, timestamp, timestep) do
    counter = get_counter_from_timestamp(timestamp, timestep)
    valid_hotp(token, encoded_secret, counter)
  end

  def valid_totp(token, raw_secret, timestamp, timestep, encoded_secret: false) do
    encoded_secret = Base.encode32(raw_secret, padding: false)
    valid_totp(token, encoded_secret, timestamp, timestep)
  end

  defp get_counter_from_timestamp(timestamp, timestep) do
    # TODO: timestamp MUST be int
    # TODO: timestep MUST be int
    trunc(timestamp / timestep)
  end
end
