defmodule Rumbl.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Accounts.User

  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    has_many :videos, Rumbl.Media.Video
    has_many :annotations, Rumbl.Media.Annotation

    timestamps()
  end

  def changeset(model, params \\ :invalid) do
    model
    |> cast(params, ~w(name username)a, [])
    |> validate_required(~w(name username)a)
    |> validate_length(:username, min: 1, max: 20)
    |> unique_constraint(:username)
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password)a, [])
    |> validate_required(~w(password)a)
    |> validate_length(:password, min: 6, max: 100)
    |> put_pass_hash()
  end

  defp put_pass_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end

end