defmodule Voting.ListElectionTest do
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.Elections.List

  describe "run/0" do
    test "returns the elections ordered by name" do
      insert(:election, name: "Election B")
      insert(:election, name: "Election A")

      elections = List.run()
      assert is_list(elections)
      assert length(elections) == 2
      assert Enum.map(elections, & &1.name) == ["Election A", "Election B"]
    end
  end
end
