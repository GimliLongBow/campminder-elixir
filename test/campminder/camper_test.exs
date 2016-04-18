defmodule CamperTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest CampMinder.Camper

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "single household lead addition" do
    household = %CampMinder.Household{Parent1: %CampMinder.Person{FirstName: "John", LastName: "Doe", LoginEmail: "john@doe.com"}, Phone: "555-555-1212"}
    lead_source = "Testing"

    use_cassette "camper_add_single_household" do
      {:ok, resp} = CampMinder.Camper.add(household, %{}, %{}, "", lead_source)
      assert resp.body[:Success] == true
    end
  end

  test "both household lead addition" do
    household1 = %CampMinder.Household{Parent1: %CampMinder.Person{FirstName: "Sara", LastName: "Doe", LoginEmail: "sarah@doe.com"}, Phone: "555-555-1111"}
    household2 = %CampMinder.Household{Parent1: %CampMinder.Person{FirstName: "Willard", LastName: "Williams", LoginEmail: "willard@williams.com"}, Phone: "555-555-3333"}
    lead_source = "Testing"

    use_cassette "camper_add_both_household" do
      {:ok, resp} = CampMinder.Camper.add(household1, household2, %{}, "", lead_source)
      assert resp.body[:Success] == true
    end
  end

  test "household and camper lead addition" do
    household = %CampMinder.Household{Parent1: %CampMinder.Person{FirstName: "Mary", LastName: "Doe", LoginEmail: "mary@doe.com"}, Phone: "555-555-2323"}
    camper = %CampMinder.Person{FirstName: "Jane", LastName: "Doe", LoginEmail: "jane@doe.com"}
    lead_source = "Testing"

    use_cassette "camper_add_household_and_camper" do
      {:ok, resp} = CampMinder.Camper.add(household, %{}, camper, "", lead_source)
      assert resp.body[:Success] == true
    end
  end
end
