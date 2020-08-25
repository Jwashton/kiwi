defmodule TodoServer do
  def start() do
    ServerProcess.start(TodoServer)
  end
  
  def init() do
    TodoList.new()
  end

  def add_entry(server, new_entry) do
    ServerProcess.cast(server, {:add_entry, new_entry})
  end

  def delete_entry(server, entry_id) do
    ServerProcess.cast(server, {:delete_entry, entry_id})
  end

  def update_entry(server, entry_id, entry_updater) do
    ServerProcess.cast(server, {:update_entry, entry_id, entry_updater})
  end

  def entries(server, date) do
    ServerProcess.call(server, {:entries, date})
  end

  def handle_cast({:add_entry, new_entry}, todo_list) do
    TodoList.add_entry(todo_list, new_entry)
  end

  def handle_cast({:delete_entry, entry_id}, todo_list) do
    TodoList.delete_entry(todo_list, entry_id)
  end

  def handle_cast({:update_entry, entry_id, entry_updater}, todo_list) do
    TodoList.update_entry(todo_list, entry_id, entry_updater)
  end

  def handle_call({:entries, date}, todo_list) do
    {TodoList.entries(todo_list, date), todo_list}
  end
end
