defmodule Exlivery.Users.UserTest do
  use ExUnit.Case

  alias Exlivery.Users.User

  describe "build/5" do
    test "when all params are valid, returns the user" do
      response = User.build("Guara", 38, "12345678900", "frederico@test.com", "Frederico")

      expected =
        {:ok,
         %User{
           address: "Guara",
           age: 38,
           cpf: "12345678900",
           email: "frederico@test.com",
           name: "Frederico"
         }}

      assert response == expected
    end

    test "when age < 18, return age is invalid" do
      response = User.build("Guara", 15, "12345678900", "frederico@test.com", "Frederico")

      expected = {:error, "Age is invalid!"}

      assert response == expected
    end

    test "when CPF not is string, return CPF is invalid" do
      response = User.build("Guara", 18, 12_345_678_900, "frederico@test.com", "Frederico")

      expected = {:error, "CPF is invalid!"}

      assert response == expected
    end
  end
end
