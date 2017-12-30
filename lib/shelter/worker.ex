defmodule Shelter.Worker do
  use GenServer
  require Logger

  # API

  def start_link() do
    GenServer.start_link(__MODULE__, [], [name: {:global, __MODULE__}])
  end

  def set(k, v) do
    :ok = GenServer.cast({:global, __MODULE__}, {:set, k, v})
  end

  def get() do
    GenServer.call({:global, __MODULE__}, {:get})
  end

  def get(k) do
    GenServer.call({:global, __MODULE__}, {:get, k})
  end

  def clear() do
    :ok = GenServer.cast({:global, __MODULE__}, :clear)
  end

  # Callbacks

  def init([]), do: {:ok, zero_state()}

  def handle_call({:get}, _from, state) do
    log_from_node("get/0")
    {:reply, state, state}
  end

  def handle_call({:get, k}, _from, state) do
    log_from_node("get/1")
    {:reply, Map.get(state, k), state}
  end

  def handle_cast({:set, k, v}, state) do
    log_from_node("set/2")
    {:noreply, Map.put(state, k, v)}
  end

  def handle_cast(:clear, _state) do
    log_from_node("clear/0")
    {:noreply, zero_state()}
  end

  defp zero_state(), do: %{}
  defp log_from_node(func_name), do: Logger.info("#{func_name} performed on #{node()}")
end
