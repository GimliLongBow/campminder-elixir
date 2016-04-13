defmodule PersonTest do
  use ExUnit.Case
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest CampMinder.Person

  setup_all do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    :ok
  end

  test "login returns a Success status" do
    use_cassette "login_success" do
      {:ok, resp} = CampMinder.Person.login("nobody@testing.com", "none1234")
      assert resp.body[:Success] == true
    end
  end

  test "login returns a redirect URL" do
    use_cassette "login_redirect" do
      {:ok, resp} = CampMinder.Person.login("nobody@testing.com", "none1234")
      assert String.length(resp.body[:Result]["RedirectUrl"]) == 104
    end
  end

  test "get_id returns a Success status" do
    use_cassette "get_id_success" do
      {:ok, resp} = CampMinder.Person.get_id("nobody@testing.com")
      assert resp.body[:Success] == true
    end
  end

  test "get_id returns a user ID as the result" do
    use_cassette "get_id_result" do
      {:ok, resp} = CampMinder.Person.get_id("nobody@testing.com")
      assert resp.body[:Result] == 7772574
    end
  end

end
