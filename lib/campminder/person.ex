defmodule CampMinder.Person do
  @moduledoc """
  Person management.
  """

  require IEx

  @doc """
  Returns a login token for remote login capabilities.
  """
  def login(username, password) do
    body = %{
      i: username,
      p: password,
      c: 2,
      apikey: CampMinder.api_key
    }

    headers = ["Content-type": "application/javascript"]

    CampMinder.get(
      "/api/security/user/GetRemoteLoginRedirect",
      headers,
      params: body
    )
    |> check_success
  end

  @doc """
  Returns a user ID token for remote login capabilities.
  """
  def get_id(email) do
    headers = [
      "Authorization-Token": CampMinder.api_key,
      "Content-type": "application/javascript"
    ]

    CampMinder.get(
      "/api/entity/person/getpersonidfromemail?email=#{email}",
      headers
    )
    |> check_success
  end

  defp check_success({:ok, resp}) do
    if resp.body[:Success] == true do
      {:ok, resp}
    else
      {:error, resp}
    end
  end

  # defp adjust_response(resp) when: resp[:Success] == false do
  #   {:error, resp}
  # end

end
