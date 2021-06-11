defmodule Exlivery.Orders.ItemTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Item

  describe "build/4" do
    test "when all params is correct, returns an item" do
      response = Item.build("Pizza Peperoni", :pizza, "35.5", 1)

      expected = {:ok, build(:item)}

      assert response == expected
    end

    test "when there is an invalid category, returns category is invalid!" do
      response = Item.build("Pizza Peperoni", :italiana, "35.5", 1)
      expected = {:error, "Category is invalid!"}
      assert response == expected
    end

    test "when there is an invalid price, returns price is invalid!" do
      response = Item.build("Pizza Peperoni", :pizza, "invalid_price", 1)
      expected = {:error, "Unit price is invalid!"}
      assert response == expected
    end

    test "when there is an invalid quantity, returns quantity is invalid!" do
      response = Item.build("Pizza Peperoni", :pizza, "35.5", 0)
      expected = {:error, "Quantity is invalid!"}
      assert response == expected
    end
  end
end
