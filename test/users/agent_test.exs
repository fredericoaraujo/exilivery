defmodule Exlivery.Users.AgentTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent

  describe "save/1" do
    test "when saves the user" do
      user = build(:user)
      UserAgent.start_link(%{})
      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})

      :user
      |> build(cpf: "98765432100")
      |> UserAgent.save()

      :ok
    end

    test "when the user is found, returns the user" do
      response = UserAgent.get("98765432100")

      expected =
        {:ok,
         %Exlivery.Users.User{
           address: "Guara",
           age: 38,
           cpf: "98765432100",
           email: "frederico@test.com",
           name: "Frederico"
         }}

      assert response == expected
    end

    test "when the user is not found, returns error" do
      response = UserAgent.get("00000000000")

      expected = {:error, "User not found!"}

      assert response == expected
    end
  end
end
