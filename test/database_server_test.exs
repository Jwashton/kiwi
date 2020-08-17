defmodule DatabaseServerTest do
  use ExUnit.Case, async: true

  test "Running a query" do
    server_pid = DatabaseServer.start()
    query = "query 1"

    DatabaseServer.run_async(server_pid, query)
    result = DatabaseServer.get_result()

    assert Regex.match?(~r{Connection \d+: #{query} result}, result)
  end
end
