defmodule CsvImporterTest do
  use ExUnit.Case, async: true

  test "can import a todo list" do
    todo_list = TodoList.CsvImporter.import("./todos.csv")

    entries =
      todo_list
      |> TodoList.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist", "Movies"]
  end
end
