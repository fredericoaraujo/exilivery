defmodule Exlivery do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreteOrUpdate

  def start_links do
    UserAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreteOrUpdate, as: :call
end
