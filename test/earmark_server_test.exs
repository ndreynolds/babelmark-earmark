defmodule EarmarkServerTest do
  use ExUnit.Case
  doctest EarmarkServer

  test "greets the world" do
    assert EarmarkServer.hello() == :world
  end
end
