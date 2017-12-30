defmodule Shelter do
  use Application
  require Logger
  alias Shelter.Worker

  def start(type, _args) do
    import Supervisor.Spec

    children = [
      worker(Worker, [])
    ]

    case type do
      :normal ->
        Logger.info("Application is started on #{node()}")

      {:takeover, old_node} ->
        Logger.info("#{node()} is taking over #{old_node}")

      {:failover, old_node} ->
        Logger.info("#{old_node} is failing over to #{node()}")
    end

    opts = [strategy: :one_for_one, name: {:global, Shelter.Supervisor}]
    Supervisor.start_link(children, opts)
  end

  defdelegate clear(), to: Worker
  defdelegate get(), to: Worker
  defdelegate get(k), to: Worker
  defdelegate set(k, v), to: Worker
end
