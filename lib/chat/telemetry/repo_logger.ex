defmodule Chat.Telemetry.RepoLogger do
  require Logger

  def handle_event([:chat, :repo, :query], measurements, metadata, _config) do
    duration_ms = System.convert_time_unit(measurements.total_time, :native, :millisecond)

    Logger.info(
      "Query executed (#{duration_ms / 1000}s)",
      query: metadata.query,
      params: inspect(metadata.params),
      duration_ms: duration_ms,
      source: metadata.source,
      repo: metadata.repo
    )
  end
end
