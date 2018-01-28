defmodule Database.Data do
  use Database.Web, :model
  use Rummage.Ecto

  schema "datas" do
    field :code, :string
    field :idcode, :string
    field :inst, :string
    field :time, :string
    field :first, :string
    field :last, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:code, :idcode, :inst, :time, :first, :last, :email])
    |> validate_required([:code, :idcode, :inst, :time, :first, :last, :email])
  end
end
