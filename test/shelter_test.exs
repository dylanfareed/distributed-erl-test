defmodule ShelterTest do
  use ExUnit.Case
  doctest Shelter

  test "greets the world" do
    assert Shelter.hello() == :world
  end
end
