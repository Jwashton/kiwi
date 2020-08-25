defmodule TodoServerTest do
  use ExUnit.Case, async: true

  setup do
    {:ok, server} = TodoServer.start()

    TodoServer.add_entry(server, %{date: ~D[2018-12-19], title: "Dentist"})
    TodoServer.add_entry(server, %{date: ~D[2018-12-20], title: "Shopping"})
    TodoServer.add_entry(server, %{date: ~D[2018-12-19], title: "Movies"})

    %{server: server}
  end

  test "Getting entries by day", %{server: server} do
    entries =
      server
      |> TodoServer.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist", "Movies"]
  end

  test "Updating an entry", %{server: server} do
    TodoServer.update_entry(server, 1, &Map.put(&1, :date, ~D[2019-12-20]))

    entries =
      server
      |> TodoServer.entries(~D[2019-12-20])
      |> Enum.map(& &1.title)

    assert entries == ["Dentist"]
  end

  test "Deleting an entry", %{server: server} do
    TodoServer.delete_entry(server, 1)

    entries =
      server
      |> TodoServer.entries(~D[2018-12-19])
      |> Enum.map(& &1.title)

    assert entries == ["Movies"]
  end
end
