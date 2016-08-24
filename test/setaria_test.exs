defmodule SetariaTest do
  use ExUnit.Case
  doctest Setaria

  test "hotp" do
    secret = "1234567890"
    encoded_secret = Base.encode32(secret, padding: false)
    invalid_secret = "1234567891"
    encoded_invalid_secret = Base.encode32(invalid_secret, padding: false)
    counter = 1
    expected_token = "263420"
    unexpected_token = "263421"

    assert Setaria.hotp(encoded_secret, counter) == expected_token
    assert Setaria.hotp(secret, counter, encoded_secret: false) == expected_token

    # valid_hotp
    assert Setaria.valid_hotp(expected_token, encoded_secret, counter) == true
    assert Setaria.valid_hotp(expected_token, secret, counter, encoded_secret: false) == true

    ## counter
    assert Setaria.valid_hotp(expected_token, encoded_secret, counter + 1) == false

    ## token
    assert Setaria.valid_hotp(unexpected_token, encoded_secret, counter) == false

    ##secret
    assert Setaria.valid_hotp(expected_token, encoded_invalid_secret, counter) == false
    assert Setaria.valid_hotp(expected_token, invalid_secret, counter, encoded_secret: false) == false
  end

  test "totp" do
    timestamp = 1332083784
    secret = "1234567890"
    encoded_secret = Base.encode32(secret, padding: false)
    invalid_secret = "1234567891"
    encoded_invalid_secret = Base.encode32(invalid_secret, padding: false)
    expected_token = "142045"
    unexpected_token = "142046"
   
    # create 
    assert Setaria.totp(encoded_secret, timestamp) == expected_token
    assert Setaria.totp(secret, timestamp, encoded_secret: false) == expected_token

    # valide succes
    assert Setaria.valid_totp(expected_token, encoded_secret, timestamp) == true
    assert Setaria.valid_totp(expected_token, secret, timestamp, encoded_secret: false) == true

    # validate error
    ## token
    assert Setaria.valid_totp(unexpected_token, encoded_secret, timestamp) == false
    assert Setaria.valid_totp(unexpected_token, secret, timestamp, encoded_secret: false) == false

    ## secret
    assert Setaria.valid_totp(expected_token, encoded_invalid_secret, timestamp) == false
    assert Setaria.valid_totp(expected_token, invalid_secret, timestamp, encoded_secret: false) == false

    ## timestamp
    assert Setaria.valid_totp(expected_token, encoded_secret, timestamp + 30) == false
    assert Setaria.valid_totp(expected_token, secret, timestamp + 30, encoded_secret: false) == false

    # current timestamp
    assert Setaria.totp(encoded_secret) != expected_token
    assert Setaria.valid_totp(expected_token, encoded_secret) == false
    assert Setaria.valid_totp(expected_token, secret, encoded_secret: false) == false
  end
end
