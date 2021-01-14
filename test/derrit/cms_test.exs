defmodule Derrit.CMSTest do
  use Derrit.DataCase

  alias Derrit.CMS

  describe "authors" do
    alias Derrit.CMS.Author

    @valid_attrs %{bio: "some bio", name: "some name"}
    @update_attrs %{bio: "some updated bio", name: "some updated name"}
    @invalid_attrs %{bio: nil, name: nil}

    def author_fixture(attrs \\ %{}) do
      {:ok, author} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_author()

      author
    end

    test "list_authors/0 returns all authors" do
      author = author_fixture()
      assert CMS.list_authors() == [author]
    end

    test "get_author!/1 returns the author with given id" do
      author = author_fixture()
      assert CMS.get_author!(author.id) == author
    end

    test "create_author/1 with valid data creates a author" do
      assert {:ok, %Author{} = author} = CMS.create_author(@valid_attrs)
      assert author.bio == "some bio"
      assert author.name == "some name"
    end

    test "create_author/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_author(@invalid_attrs)
    end

    test "update_author/2 with valid data updates the author" do
      author = author_fixture()
      assert {:ok, %Author{} = author} = CMS.update_author(author, @update_attrs)
      assert author.bio == "some updated bio"
      assert author.name == "some updated name"
    end

    test "update_author/2 with invalid data returns error changeset" do
      author = author_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_author(author, @invalid_attrs)
      assert author == CMS.get_author!(author.id)
    end

    test "delete_author/1 deletes the author" do
      author = author_fixture()
      assert {:ok, %Author{}} = CMS.delete_author(author)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_author!(author.id) end
    end

    test "change_author/1 returns a author changeset" do
      author = author_fixture()
      assert %Ecto.Changeset{} = CMS.change_author(author)
    end
  end

  describe "boards" do
    alias Derrit.CMS.Board

    @valid_attrs %{description: "some description", name: "some name"}
    @update_attrs %{description: "some updated description", name: "some updated name"}
    @invalid_attrs %{description: nil, name: nil}

    def board_fixture(attrs \\ %{}) do
      {:ok, board} =
        attrs
        |> Enum.into(@valid_attrs)
        |> CMS.create_board()

      board
    end

    test "list_boards/0 returns all boards" do
      board = board_fixture()
      assert CMS.list_boards() == [board]
    end

    test "get_board!/1 returns the board with given id" do
      board = board_fixture()
      assert CMS.get_board!(board.id) == board
    end

    test "create_board/1 with valid data creates a board" do
      assert {:ok, %Board{} = board} = CMS.create_board(@valid_attrs)
      assert board.description == "some description"
      assert board.name == "some name"
    end

    test "create_board/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = CMS.create_board(@invalid_attrs)
    end

    test "update_board/2 with valid data updates the board" do
      board = board_fixture()
      assert {:ok, %Board{} = board} = CMS.update_board(board, @update_attrs)
      assert board.description == "some updated description"
      assert board.name == "some updated name"
    end

    test "update_board/2 with invalid data returns error changeset" do
      board = board_fixture()
      assert {:error, %Ecto.Changeset{}} = CMS.update_board(board, @invalid_attrs)
      assert board == CMS.get_board!(board.id)
    end

    test "delete_board/1 deletes the board" do
      board = board_fixture()
      assert {:ok, %Board{}} = CMS.delete_board(board)
      assert_raise Ecto.NoResultsError, fn -> CMS.get_board!(board.id) end
    end

    test "change_board/1 returns a board changeset" do
      board = board_fixture()
      assert %Ecto.Changeset{} = CMS.change_board(board)
    end
  end
end