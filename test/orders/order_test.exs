defmodule Exlivery.Orders.OrderTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Order

  describe "build/2" do
    test "when all params is corrected, returns an order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Temaki",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.5")
        )
      ]

      response = Order.build(user, items)

      expected = {:ok, build(:order)}

      assert response == expected
    end

    test "when items is nil, returns an error" do
      user = build(:user)

      items = []

      response = Order.build(user, items)

      expected = {:error, "Order is invalid!"}

      assert response == expected
    end

    test "when user is nil, returns an error" do
      user = nil

      items = [
        build(:item),
        build(:item,
          description: "Temaki",
          category: :japonesa,
          quantity: 2,
          unity_price: Decimal.new("20.5")
        )
      ]

      response = Order.build(user, items)

      expected = {:error, "Order is invalid!"}

      assert response == expected
    end
  end
end
