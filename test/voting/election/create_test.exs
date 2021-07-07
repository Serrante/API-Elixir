defmodule Voting.CreateElectionTest do
  use Voting.DataCase, async: true

  alias Voting.Election
  alias Voting.Elections.Create

  import Voting.Factory

  describe "run/1" do
    test "returns a struct when the params are valid" do
      admin = insert(:admin)

      params = %{
        name: "Foo",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:59Z],
        created_by_id: admin.id
      }

      assert {:ok, %Election{} = election} = Create.run(params)
      assert election.name == "Foo"
      assert election.cover == "url"
      assert election.notice == "url"
      assert election.starts_at == ~U[2020-02-01 11:00:00Z]
      assert election.ends_at == ~U[2020-02-29 20:59:59Z]
      assert election.created_by_id == admin.id
    end

    test "returns error when name is missing" do
      admin = insert(:admin)

      params = %{
        name: "",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:59Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when starts_at is missing" do
      admin = insert(:admin)

      params = %{
        name: "Foo",
        cover: "url",
        notice: "url",
        starts_at: nil,
        ends_at: ~U[2020-02-29 20:59:59Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{starts_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when ends_at is missing" do
      admin = insert(:admin)

      params = %{
        name: "Foo",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: nil,
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{ends_at: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when created_by_id is invalid" do
      params = %{
        name: "Foo",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-02-01 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:59Z],
        created_by_id: 77
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{created_by_id: ["is invalid"]} = errors_on(changeset)
    end

    test "returns error when starts_at grather than ends_at" do
      admin = insert(:admin)

      params = %{
        name: "Foo",
        cover: "url",
        notice: "url",
        starts_at: ~U[2020-03-01 11:00:00Z],
        ends_at: ~U[2020-02-29 20:59:59Z],
        created_by_id: admin.id
      }

      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{starts_at: ["should be before ends_at"]} = errors_on(changeset)
    end
  end
end
