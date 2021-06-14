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

      {:ok, user_cpf: cpf, item1: item1, item2: item2}
    end

    test "when all params are valid, saves the order", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      :user
      |> build(cpf: cpf)
      |> UserAgent.save()

      params = %{cpf: cpf, items: [item1, item2]}

      assert {:ok, _uuid} = CreteOrUpdate.call(params)
    end

    test "when any params is/are not valid, returns error", %{
      user_cpf: cpf,
      item1: item1,
      item2: item2
    } do
      params = %{cpf: cpf, items: [item1, item2]}

      {response, _reason} = CreteOrUpdate.call(params)
      expected = :error

      assert response == expected
    end
  end
end
