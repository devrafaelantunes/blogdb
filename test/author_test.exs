defmodule BlogDB.Internal.AuthorTest do
  use ExUnit.Case, async: true

  alias BlogDB.Internal.Author, as: AuthorInternal

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(BlogDB.Repo)
  end


  @params %{username: "Rafael", password: "123", email: "dev@ops.com"}

  test "insert author" do
      assert {:ok, author} = AuthorInternal.insert(@params)
      assert author.username == @params.username
      assert author.password == @params.password
      assert author.email == @params.email
  end

  test "query author by id" do
    {:ok, author} =
      AuthorInternal.insert(@params)

    fetched_author =
      AuthorInternal.fetch(author.author_id)

    assert fetched_author.author_id == author.author_id
  end

  test "delete author" do
    {:ok, author} =
      AuthorInternal.insert(@params)

    AuthorInternal.delete_by_id(author.author_id)

    assert AuthorInternal.fetch(author.author_id) == nil

  end

  test "update author's username" do
    new_username = "testing"

    {:ok, author} =
      AuthorInternal.insert(@params)

    AuthorInternal.update_username(author.author_id, new_username)

    fetched_author =
      AuthorInternal.fetch(author.author_id)

    assert fetched_author.username == new_username
  end

  test "testing :on_delete (posts,comments that belongs to the author)" do


  end

end
