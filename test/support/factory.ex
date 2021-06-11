defmodule Exlivery.Factory do
  use ExMachina

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
end
