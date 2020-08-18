defmodule TodoServer do
  @server :todo_server

  def start() do
    client = self()

    pid =
      spawn(fn ->
        Process.register(self(), @server)
        send(client, :todo_ready)
        loop(TodoList.new())
      end)

    receive do
      :todo_ready ->
        pid
    after
      5000 ->
        {:error, :timeout}
    end
  end

  def add_entry(new_entry) do
    send(@server, {:add_entry, new_entry})
  end

  def delete_entry(entry_id) do
    send(@server, {:delete_entry, entry_id})
  end

  def update_entry(entry_id, entry_updater) do
    send(@server, {:update_entry, entry_id, entry_updater})
  end

  def entries(date) do
    send(@server, {:entries, self(), date})

    receive do
      {:todo_entries, entries} -> entries
    after
      5000 ->
        {:error, :timeout}
    end
  end

  defp loop(todo_list) do
    new_todo_list =
      receive do
        message -> process_message(todo_list, message)
      end

    loop(new_todo_list)
  end

  defp process_message(todo_list, {:add_entry, new_entry}) do
    TodoList.add_entry(todo_list, new_entry)
  end

  defp process_message(todo_list, {:delete_entry, entry_id}) do
    TodoList.delete_entry(todo_list, entry_id)
  end

  defp process_message(todo_list, {:update_entry, entry_id, entry_updater}) do
    TodoList.update_entry(todo_list, entry_id, entry_updater)
  end

  defp process_message(todo_list, {:entries, caller, date}) do
    send(caller, {:todo_entries, TodoList.entries(todo_list, date)})
    todo_list
  end
end
