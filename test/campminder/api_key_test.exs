defmodule APIKeyTest do
  use ExUnit.Case
  doctest CampMinder

  setup_all do
    Application.put_env(:campminder, :camp_id, 500)
    Application.put_env(:campminder, :token, "xxxxxxxx-yyyy-aaaa-bbbb-112233445566")

    on_exit fn ->
      Application.delete_env(:campminder, :camp_id)
      Application.delete_env(:campminder, :token)
    end
  end

  test "includes camp ID" do
    assert CampMinder.api_key =~ ~r{^500.*}
  end

  test "includes current time stamp" do
    {:ok, now} = DateTime.utc_now |> Timex.format("%Y-%m-%dT%H:%M:%S", :strftime)
    assert String.contains?(CampMinder.api_key, now) == true
  end
end
