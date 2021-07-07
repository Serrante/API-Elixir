defmodule Voting.Elections.Repo do
  @moduledoc """
  Election Repository
  """

  alias Voting.{Election, Repo}

  def get_election!(id), do: Repo.get!(Election, id)
end
