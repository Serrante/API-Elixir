defmodule Voting.Factory do
  @moduledoc false

  # with Ecto
  use ExMachina.Ecto, repo: Voting.Repo

  def admin_factory do
    %Voting.Admin{
      name: "Jane Smith",
      email: sequence(:email, &"email#{&1}@example.com"),
      password_hash: Bcrypt.hash_pwd_salt("12345678")
    }
  end

  def election_factory do
    %Voting.Election{
      name: "Election 2020",
      cover: "http-to-an-image",
      notice: "http-to-a-pdf",
      starts_at: ~U[2020-02-01 11:00:00Z],
      ends_at: ~U[2020-02-29 20:59:59Z],
      created_by: build(:admin)
    }
  end
end
