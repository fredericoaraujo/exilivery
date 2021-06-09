defmodule Exlivery.Orders.Order do
  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  @keys [:user_cpf, :delivery_address, :items, :total_price]
  @enforce_keys @keys

  defstruct @keys

  def build(%User{cpf: cpf, address: address}, [%Item{} | _items] = items) do
    {:ok,
     %__MODULE__{
       user_cpf: cpf,
       delivery_address: address,
       items: items,
       total_price: calculate_total_price(items)
     }}
  end

  def build(_user, _items), do: {:error, "Order is invalid!"}

  defp calculate_total_price(items) do
    Enum.reduce(items, Decimal.new("0.00"), &sum_prices(&1, &2))
  end

  defp sum_prices(%Item{quantity: quantity, unity_price: unity_price}, acc) do
    unity_price
    |> Decimal.mult(quantity)
    |> Decimal.add(acc)
  end
end
