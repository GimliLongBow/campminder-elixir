defmodule CampMinder do
  @moduledoc """
  An HTTP client for CampMinder.
  https://webapi.campminder.com/help
  """

  use Application
  use HTTPoison.Base

  @endpoint "https://webapi.campminder.com"

  @doc """
  http://elixir-lang.org/docs/stable/elixir/Application.html
  """
  def start(_type, _args) do
    CampMinder.Supervisor.start_link()
  end

  @doc """
  Prepend the CampMinder API URL to each request:
  """
  def process_url(url) do
    @endpoint <> url
  end

  @doc """
  Decode and convert the body into a keyword list.
  ERROR: This should be cleaner but the get_id_success test fails if it isn't broken into two steps...
  """
  def process_response_body(body) do
    #body_decoded = body |> Poison.decode!
    #body_decoded |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
    body
    |> Poison.decode!
    |> Enum.map(fn({k, v}) -> {String.to_atom(k), v} end)
  end

  @doc """
  Generates a time-locked use API header key.
  How long is this valid for?
  """
  def api_key do
    # Get the current time formatted appropriately.
    {:ok, now} = Timex.DateTime.now |> Timex.format("{ISOz}")
    # Hash it through SHA1.
    hash = :crypto.hash(:sha, "#{camp_id}#{now}#{token}") |> Base.encode16 |> String.downcase
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
