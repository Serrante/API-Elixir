defmodule VotingWeb.Admin.ElectionViewTest do
  use ExUnit.Case, async: true

  alias VotingWeb.Admin.ElectionView

  import Voting.Factory

  test "render/2 returns ok and the election data" do
    elections = [build(:election, id: 1), build(:election, id: 2)]

    assert [
             %{
               id: 1,
               name: "Election 2020",
               cover: "http-to-an-image",
               notice: "http-to-a-pdf",
               starts_at: ~U[2020-02-01 11:00:00Z],
               ends_at: ~U[2020-02-29 20:59:59Z]
             },
             %{
               id: 2,
               name: "Election 2020",
               cover: "http-to-an-image",
               notice: "http-to-a-pdf",
               starts_at: ~U[2020-02-01 11:00:00Z],
               ends_at: ~U[2020-02-29 20:59:59Z]
             }
           ] == ElectionView.render("index.json", %{elections: elections})
  end

  describe "election.json" do
    test "render/2 returns ok and the election data" do
      election = build(:election, id: 1)

      assert %{
               status: "ok",
               data: %{
                 id: 1,
                 name: "Election 2020",
                 cover: "http-to-an-image",
                 notice: "http-to-a-pdf",
                 starts_at: ~U[2020-02-01 11:00:00Z],
                 ends_at: ~U[2020-02-29 20:59:59Z]
               }
             } = ElectionView.render("election.json", %{election: election})
    end
  end
end
