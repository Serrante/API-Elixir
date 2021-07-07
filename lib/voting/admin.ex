defmodule Voting.Admin do
  @moduledoc """
  Admin shema
  """
  use Ecto.Schema

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "administrators" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end
end
