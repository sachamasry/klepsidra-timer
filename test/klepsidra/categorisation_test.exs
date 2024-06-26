defmodule Klepsidra.CategorisationTest do
  use Klepsidra.DataCase

  alias Klepsidra.Categorisation

  describe "tags" do
    alias Klepsidra.Categorisation.Tag

    import Klepsidra.CategorisationFixtures

    @invalid_attrs %{name: nil, description: nil, colour: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Categorisation.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Categorisation.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{name: "some tag", description: "some description", colour: "some colour"}

      assert {:ok, %Tag{} = tag} = Categorisation.create_tag(valid_attrs)
      assert tag.name == "some tag"
      assert tag.description == "some description"
      assert tag.colour == "some colour"
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categorisation.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()

      update_attrs = %{
        name: "some updated tag",
        description: "some updated description",
        colour: "some updated colour"
      }

      assert {:ok, %Tag{} = tag} = Categorisation.update_tag(tag, update_attrs)
      assert tag.name == "some updated tag"
      assert tag.description == "some updated description"
      assert tag.colour == "some updated colour"
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Categorisation.update_tag(tag, @invalid_attrs)
      assert tag == Categorisation.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Categorisation.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Categorisation.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Categorisation.change_tag(tag)
    end
  end

  describe "project_tags" do
    alias Klepsidra.Categorisation.ProjectTag

    import Klepsidra.CategorisationFixtures

    @invalid_attrs %{tag_id: nil, project_id: nil}

    # test "list_project_tags/0 returns all project_tags" do
    #   project_tag = project_tag_fixture()
    #   assert Categorisation.list_project_tags() == [project_tag]
    # end

    # test "get_project_tag!/1 returns the project_tag with given id" do
    #   project_tag = project_tag_fixture()
    #   assert Categorisation.get_project_tag!(project_tag.id) == project_tag
    # end

    # test "create_project_tag/1 with valid data creates a project_tag" do
    #   valid_attrs = %{tag_id: 42, project_id: 42}

    #   assert {:ok, %ProjectTag{} = project_tag} = Categorisation.create_project_tag(valid_attrs)
    #   assert project_tag.tag_id == 42
    #   assert project_tag.project_id == 42
    # end

    # test "create_project_tag/1 with invalid data returns error changeset" do
    #   assert {:error, %Ecto.Changeset{}} = Categorisation.create_project_tag(@invalid_attrs)
    # end

    # test "update_project_tag/2 with valid data updates the project_tag" do
    #   project_tag = project_tag_fixture()
    #   update_attrs = %{tag_id: 43, project_id: 43}

    #   assert {:ok, %ProjectTag{} = project_tag} = Categorisation.update_project_tag(project_tag, update_attrs)
    #   assert project_tag.tag_id == 43
    #   assert project_tag.project_id == 43
    # end

    # test "update_project_tag/2 with invalid data returns error changeset" do
    #   project_tag = project_tag_fixture()
    #   assert {:error, %Ecto.Changeset{}} = Categorisation.update_project_tag(project_tag, @invalid_attrs)
    #   assert project_tag == Categorisation.get_project_tag!(project_tag.id)
    # end

    # test "delete_project_tag/1 deletes the project_tag" do
    #   project_tag = project_tag_fixture()
    #   assert {:ok, %ProjectTag{}} = Categorisation.delete_project_tag(project_tag)
    #   assert_raise Ecto.NoResultsError, fn -> Categorisation.get_project_tag!(project_tag.id) end
    # end

    # test "change_project_tag/1 returns a project_tag changeset" do
    #   project_tag = project_tag_fixture()
    #   assert %Ecto.Changeset{} = Categorisation.change_project_tag(project_tag)
    # end
  end
end
