defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.Item
  alias Exlivery.Users.User

  def user_factory do
    %User{
      address: "Guara",
      age: 38,
      cpf: "12345678900",
      email: "frederico@test.com",
      name: "Frederico"
    }
  end

  def item_factory do
    %Item{
      category: :pizza,
      description: "Pizza Peperoni",
      quantity: 1,
      unity_price: Decimal.new("35.5")
    }
  end
end
