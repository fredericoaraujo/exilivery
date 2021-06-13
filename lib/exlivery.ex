defmodule Exlivery do
  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.CreteOrUpdate, as: OrderCreateOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreteOrUpdate, as: UserCreateOrUpdate

  def start_links do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: UserCreateOrUpdate, as: :call
  defdelegate create_or_update_order(params), to: OrderCreateOrUpdate, as: :call
end
