defmodule Rumbl.Accounts.UserRepoTest do Line
  use Rumbl.DataCase
  alias Rumbl.Accounts.User

  @valid_attrs %{name: "A User", username: "beta"}

  test "converts unique_constraint on username to error" do
    insert_user(%{username: "charlie"})
    attrs = Map.put(@valid_attrs, :username, "charlie")
    changeset = User.changeset(%User{}, attrs)
  
    assert {:error, changeset} = Repo.insert(changeset)
    assert "has already been taken" in errors_on(changeset, :username)
  end
end 