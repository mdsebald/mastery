defmodule Mastery.Core.Utils do
  @discard_threshold 10
  @keep_threshold 9
  @sync_threshold 8
  @async_threshold 7

  # Working through logging modes example in book, not used in quiz application

  def compute_mode(mode) do
    messages = message_queue_length()

    case mode do
      _ when messages >= @discard_threshold -> :discard
      :discard when messages > @keep_threshold -> :discard
      _ when messages >= @sync_threshold -> :sync
      :sync when messages > @async_threshold -> :sync
      _ -> :async
    end
  end

  defp message_queue_length() do
    {:message_queue_len, messages} = Process.info(self(), :message_queue_len)
    messages
  end
end
