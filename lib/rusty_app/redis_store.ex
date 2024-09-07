defmodule RustyApp.RedisStore do
  def start_link do
    Redix.start_link("redis://localhost:6379", name: :redix)
  end

  def save_function(name, body) do
    Redix.command(:redix, ["SET", "rhai_function:#{name}", body])
  end

  def get_function(name) do
    case Redix.command(:redix, ["GET", "rhai_function:#{name}"]) do
      {:ok, nil} -> {:error, :not_found}
      {:ok, body} -> {:ok, body}
      error -> error
    end
  end

  def delete_function(name) do
    Redix.command(:redix, ["DEL", "rhai_function:#{name}"])
  end

  def list_functions do
    case Redix.command(:redix, ["KEYS", "rhai_function:*"]) do
      {:ok, keys} -> {:ok, Enum.map(keys, &String.replace(&1, "rhai_function:", ""))}
      error -> error
    end
  end
end
