defmodule Database.Repo.Migrations.CreateData do
  use Ecto.Migration

  def change do
    create table(:datas) do
      add :code, :string
      add :idcode, :string
      add :inst, :string
      add :time, :string
      add :first, :string
      add :last, :string
      add :email, :string

      timestamps()
    end
  end
end
