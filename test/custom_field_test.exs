defmodule CustomFieldTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest CampMinder.CustomField

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "get field definitions" do
    use_cassette "get_field_definitions" do
      {:ok, resp} = CampMinder.CustomField.getDefinitions(113621)
      assert resp.body[:Success] == true
    end
  end

  @tag :skip
  test "get field definitions since a date" do
    use_cassette "get_field_definitions_date" do
      {:ok, resp} = CampMinder.CustomField.getDefinitions(113621)
      assert resp.body[:Success] == true
    end
  end
end

