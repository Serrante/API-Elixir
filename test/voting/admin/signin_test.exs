defmodule Voting.SignInAdminTest do
  use Voting.DataCase, async: true

  import Voting.Factory

  alias Voting.Admin
  alias Voting.Admins.SignIn

  setup do
    admin = insert(:admin)
    %{ok: admin}
  end

  describe "run/2" do
    test "returns ok when email and password match", %{ok: admin} do
      assert {:ok, %Admin{}} = SignIn.run(admin.email, "12345678")
    end

    test "returns error when there is no admin with this email" do
      assert {:error, :email_or_password_invalid} = SignIn.run("foo@example.com", "12345678")
    end

    test "returns error when the password is invalid", %{ok: admin} do
      assert {:error, :email_or_password_invalid} = SignIn.run(admin.email, "1")
    end
  end
end
