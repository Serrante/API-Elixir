defmodule Voting.Admins.SignIn do
  @moduledoc """
  SignIn as admin
  """
  alias Voting.{Admin, Repo}

  def run(email, password) do
    case Repo.get_by(Admin, email: email) do
      %Admin{} = admin -> verifying_password(admin, password)
      nil -> {:error, :email_or_password_invalid}
    end
  end

  defp verifying_password(admin, password) do
    if Bcrypt.verify_pass(password, admin.password_hash) do
      {:ok, admin}
    else
      {:error, :email_or_password_invalid}
    end
  end
end
