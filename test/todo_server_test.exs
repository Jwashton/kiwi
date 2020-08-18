defmodule TodoServerTest do
  use ExUnit.Case, async: true

  setup do
    TodoServer.start()

    TodoServer.add_entry(%{date: ~D[2018-12-19], title: "Dentist"})
    TodoServer.add_entry(%{date: ~D[2018-12-20], title: "Shopping"})
    TodoServer.add_entry(%{date: ~D[2018-12-19], title: "Movies"})
    
    %{}
  end

  test "Getting entries by day" do
    entries =
      TodoServer.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist", "Movies"]
  end

  test "Updating an entry" do
    TodoServer.update_entry(1, &Map.put(&1, :date, ~D[2019-12-20]))

    entries =
      TodoServer.entries(~D[2019-12-20])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist"]
  end

  test "Deleting an entry" do
    TodoServer.delete_entry(1)

    entries =
      TodoServer.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Movies"]
  end
end
