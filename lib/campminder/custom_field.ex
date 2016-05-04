defmodule CampMinder.CustomField do
  @moduledoc """
  Custom field management for entities.
  """

  def getDefinitions(ids, since \\ "") do
    params = %{
      FieldIDs: ids,
      Since: since
    }

    headers = [
      "Authorization-Token": CampMinder.api_key,
      "Content-type": "application/javascript"
    ]

    CampMinder.get(
      "/api/entity/CustomField/GetFieldDefs",
      headers,
      params: params
    )
    |> CampMinder.convert_result
  end
end
