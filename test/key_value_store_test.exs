defmodule KeyValueStoreTest do
  use ExUnit.Case, async: true
  
  test "general usage" do
    {:ok, pid} = KeyValueStore.start()
    
    KeyValueStore.put(pid, :some_key, :some_value)
    assert KeyValueStore.get(pid, :some_key) == :some_value
  end
end
