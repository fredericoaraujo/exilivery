defmodule Exlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.CreteOrUpdate
  alias Exlivery.Users.Agent, as: UserAgent

  describe "call/1" do
    setup do
      Exlivery.start_links()

      cpf = "001234567890"

      item1 = %{
        description: "Pizza Peperoni",
        category: :pizza,
        unity_price: "50.99",
        quantity: 1
      }

      item2 = %{
        description: "Pizza Calabresa",
        category: :pizza,
        unity_price: "30.00",
        quantity: 1
      }

      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{cpf: cpf, items: [item1, item2]}

      assert {:ok, _uuid} = CreteOrUpdate.call(params)
    end

    test "when cpf is invalid, returns error", %{
      user_cpf: _cpf,
      item1: item1,
      item2: item2
    } do
      params = %{cpf: "00000000000", items: [item1, item2]}

      response = CreteOrUpdate.call(params)
      expected = {:error, "User not found!"}

      assert response == expected
    end

    test "when item is invalid, returns error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{cpf: cpf, items: [%{item1 | quantity: 0}, item2]}

      response = CreteOrUpdate.call(params)
      expected = {:error, "Any item is invalid!"}

      assert response == expected
    end

    test "when do not have items, returns error", %{
      user_cpf: cpf
    } do
      params = %{cpf: cpf, items: []}

      response = CreteOrUpdate.call(params)
      expected = {:error, "Order is invalid!"}

      assert response == expected
    end
  end
end
