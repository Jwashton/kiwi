defmodule TodoListTest do
  use ExUnit.Case
  doctest TodoList

  setup do
    todo_list =
      TodoList.new()
      |> TodoList.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
      |> TodoList.add_entry(%{date: ~D[2018-12-20], title: "Shopping"})
      |> TodoList.add_entry(%{date: ~D[2018-12-19], title: "Movies"})

    %{todo_list: todo_list}
  end

  test "retrieves entries for Dec 19", context do
    dec_19_entries =
      TodoList.entries(context.todo_list, ~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert dec_19_entries == ["Dentist", "Movies"]
  end

  test "retrieves entries for Dec 18", context do
    dec_18_entries = TodoList.entries(context.todo_list, ~D[2018-12-18])
    assert dec_18_entries == []
  end

  test "updates an entry", context do
    entries =
      context.todo_list
      |> TodoList.update_entry(1, &Map.put(&1, :date, ~D[2019-12-20]))
      |> TodoList.entries(~D[2019-12-20])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist"]
  end

  test "deletes an entry", context do
    entries =
      context.todo_list
      |> TodoList.delete_entry(1)
      |> TodoList.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Movies"]
  end

  test "creating a todolist from a list of entries" do
    todo_list =
      TodoList.new([
        %{date: ~D[2018-12-19], title: "Dentist"},
        %{date: ~D[2018-12-20], title: "Shopping"},
        %{date: ~D[2018-12-19], title: "Movies"}
      ])

    entries =
      todo_list
      |> TodoList.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist", "Movies"]
  end
end
