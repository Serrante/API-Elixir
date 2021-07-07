defmodule Voting.Admins.Create do
  @moduledoc """
  Creating a new admin
  """
  import Ecto.Changeset

  alias Voting.{Admin, Repo}

  @fields [:email, :password, :name]

  def run(params) do
    %Admin{}
    |> cast(params, @fields)
    |> validate_required(@fields)
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/^[\w.!#$%&’*+\-\/=?\^`{|}~]+@[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*$/i)
    # |> unique_constraint(:email, name: :administrators_email_index)
    |> unique_constraint(:email)
    |> put_password()
    |> Repo.insert()
  end

  defp put_password(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password(changeset), do: changeset
end
