defmodule Chat.Telemetry.RepoLogger do
  require Logger

  # 2 seconds
  @slow_threshold_ms 2000

  def handle_event([:chat, :repo, :query], measurements, metadata, _config) do
    duration_ms = System.convert_time_unit(measurements.total_time, :native, :millisecond)

    if duration_ms > @slow_threshold_ms do
      Logger.warning(
        "⚠️ Slow query detected (#{duration_ms / 1000}s)",
        query: metadata.query,
        params: inspect(metadata.params),
        duration_ms: duration_ms,
        source: metadata.source,
        repo: metadata.repo
      )
    end
  end
end
