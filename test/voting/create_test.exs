defmodule Voting.CreateAdminTest do
  use Voting.DataCase, async: true

  alias Voting.Admin
  alias Voting.Admins.Create

  describe "run/1" do
    test "returns a struct when the params are valid" do
      params = %{name: "Foo", email: "foo@bar.com", password: "12345678"}
      assert {:ok, %Admin{} = admin} = Create.run(params)
      assert admin.name == "Foo"
      assert admin.email == "foo@bar.com"
      assert admin.password_hash != "12345678"
    end

    test "returns error when name is missing" do
      params = %{name: "", email: "foo@bar.com", password: "12345678"}
      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{name: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when email is missing" do
      params = %{name: "Foo", email: "", password: "12345678"}
      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{email: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when password is missing" do
      params = %{name: "Foo", email: "foo@bar.com", password: ""}
      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{password: ["can't be blank"]} = errors_on(changeset)
    end

    test "returns error when email contains incorrect format" do
      params = %{name: "Foo", email: "foobar.com", password: "12345678"}
      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{email: ["has invalid format"]} = errors_on(changeset)
    end

    test "returns error when password is missing characters" do
      params = %{name: "Foo", email: "foo@bar.com", password: "1"}
      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{password: ["should be at least 8 character(s)"]} = errors_on(changeset)
    end

    test "returns error when email already exists" do
      params = %{name: "Foo", email: "foo@bar.com", password: "12345678"}
      Create.run(params)

      assert {:error, %Ecto.Changeset{} = changeset} = Create.run(params)
      %{email: ["has already been taken"]} = errors_on(changeset)
    end
  end
end
