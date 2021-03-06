defmodule CampMinder.Person do
  @moduledoc """
  Person struct and management.
  """

  defstruct FirstName: "", LastName: "", LoginEmail: ""

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
    |> CampMinder.convert_result
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
    |> CampMinder.convert_result
  end

end
