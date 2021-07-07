defmodule Voting.Elections.Create do
  @moduledoc """
  Create an election
  """
  import Ecto.Changeset
  import Voting.DatesOverlap

  alias Voting.{Election, Repo}

  @fields [:name, :cover, :notice, :starts_at, :ends_at, :created_by_id]
  @fields_required [:name, :starts_at, :ends_at, :created_by_id]

  def run(params) do
    %Election{}
    |> cast(params, @fields)
    |> validate_required(@fields_required)
    |> validate_dates_overlap(:starts_at, :ends_at)
    |> foreign_key_constraint(:created_by_id)
    |> Repo.insert()
  end
end
