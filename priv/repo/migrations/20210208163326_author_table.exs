defmodule BlogDB.Repo.Migrations.AuthorTable do
  use Ecto.Migration

  def change do
    create table(:authors, primary_key: false) do
      add :author_id, :serial, primary_key: true
      add :username, :string, null: false
      add :password, :string, null: false
      add :email, :string, null: false


      timestamps()
    end

    create unique_index(:authors, [:username])

    create table(:posts, primary_key: false) do
      add :post_id, :serial, primary_key: true
      add :author_id, references(:authors , column: :author_id, type: :integer, on_delete: :delete_all)
      add :title, :string, null: false
      add :content, :text, null: false


      timestamps()
    end

    create table(:comments, primary_key: false) do
      add :comment_id, :serial, primary_key: true
      add :author_id, references(:authors, column: :author_id, type: :integer, on_delete: :delete_all)
      add :post_id, references(:posts, column: :post_id, type: :integer, on_delete: :delete_all)
      add :content, :text, null: false

      timestamps()
    end

  end
end
