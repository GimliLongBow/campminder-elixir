defmodule CampMinder.Camper do
  @moduledoc """
  Manages leads.
  """

  def add(household1, household2, camper, lead_date, lead_source) do
    request_body = %{
      "Household1" => household1,
      "Household2" => household2,
      "Camper" => camper,
      "LeadDate" => lead_date,
      "LeadSource" => lead_source
    } |> Poison.encode!

    headers = [
      "Authorization-Token": CampMinder.api_key,
      "Content-Type": "application/javascript"
    ]


    CampMinder.post(
      "/api/entity/person/camper/camper/addnewcamper",
      request_body,
      headers
    )
  end

end
