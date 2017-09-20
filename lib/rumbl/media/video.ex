defmodule Rumbl.Media.Video do
  use Ecto.Schema
  import Ecto.Changeset
  alias Rumbl.Media.Video

  schema "videos" do
    field :url, :string
    field :title, :string
    field :description, :string
    belongs_to :user, Rumbl.Accounts.User, foreign_key: :user_id
    belongs_to :category, Rumbl.Media.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :title, :description])
    |> validate_required([:url, :title, :description])
  end
end
