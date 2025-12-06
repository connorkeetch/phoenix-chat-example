defmodule Chat.Workers.MessageCleanup do
  use Oban.Worker, queue: :default

  require Logger
  import Ecto.Query

  @impl Oban.Worker
  def perform(_job) do
    # Log start to verify timing
    Logger.info("🧹 [MessageCleanup] Starting...")

    # Delete messages older than 24 hours (for real use)
    # Using 1 minute for aggressive testing if needed, but let's stick to a safe default
    # and just rely on the query execution itself being logged.
    cutoff = DateTime.utc_now() |> DateTime.add(-24, :hour)

    {count, _} =
      from(m in Chat.Message, where: m.inserted_at < ^cutoff)
      |> Chat.Repo.delete_all()

    Logger.info("✨ [MessageCleanup] Finished. Deleted #{count} messages.")

    :ok
  end
end
