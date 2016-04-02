defmodule CampMinder do
  @moduledoc """
  An HTTP client for CampMinder.
  """

  use Application

  @doc """
  http://elixir-lang.org/docs/stable/elixir/Application.html
  """
  def start(_type, _args) do
    CampMinder.Supervisor.start_link()
  end

  @doc """
  Generates a time-locked use API header key.
  How long is this valid for?
  """
  def api_key do
    # Get the current time formatted appropriately.
    {:ok, now} = Timex.DateTime.now |> Timex.format("{ISOz}")
    # Hash it through SHA1.
    hash = :crypto.hash(:sha, "#{camp_id}#{now}#{token}") |> Base.encode16
    # Return a string with the camp ID, current time, and SHA1 hash together.
    "#{camp_id}#{now}#{hash}"
  end

  @doc """
  Returns the CampMinder camp ID from either the system or application environment.
  """
  def camp_id do
    Application.get_env(:campminder, :camp_id) || System.get_env "CAMPMINDER_CAMP_ID"
  end

  @doc """
  Returns the CampMinder token from either the system or application environment.
  """
  def token do
    Application.get_env(:campminder, :token) || System.get_env "CAMPMINDER_TOKEN"
  end
end
