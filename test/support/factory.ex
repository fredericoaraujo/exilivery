defmodule Exlivery.Factory do
  use ExMachina

  alias Exlivery.Orders.{Item, Order}
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

  def order_factory do
    %Order{
      delivery_address: "Guara",
      items: [
        build(:item),
        build(:item,
          description: "Temaki",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.5")
        )
      ],
      total_price: Decimal.new("76.50"),
      user_cpf: "12345678900"
    }
  end
end
