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

  @required_fields ~w(url title description)
  @optional_fields ~w()

  @doc false
  def changeset(%Video{} = video, attrs \\ %{}) do
    video
    |> cast(attrs, @required_fields, @optional_fields)
    |> assoc_constraint(:category)
  end
end
