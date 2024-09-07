defmodule RustyApp.RhaiFunctions do
  alias RustyApp.RedisStore

  def execute_function(name, params) do
    with {:ok, body} <- RedisStore.get_function(name) do
      RustyApp.RhaiRustler.execute_rhai(body, params)
    end
  end

  def save_function(name, body) do
    RedisStore.save_function(name, body)
  end

  def delete_function(name) do
    RedisStore.delete_function(name)
  end

  def list_functions do
    RedisStore.list_functions()
  end
end
