defmodule Exlivery.Users.CreteOrUpdate do
  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.User

  def call(%{address: address, age: age, cpf: cpf, email: email, name: name}) do
    address
    |> User.build(age, cpf, email, name)
    |> save_user()
  end

  defp save_user({:ok, %User{} = user}), do: UserAgent.save(user)
  defp save_user({:error, _reason} = error), do: error
end
