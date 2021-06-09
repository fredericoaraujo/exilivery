defmodule Exlivery.Users.User do
  @keys [:name, :email, :cpf, :age, :address]
  @enforce_keys @keys
  defstruct @keys

  def build(address, age, cpf, email, name) when age >= 18 and is_bitstring(cpf) do
    {:ok,
     %__MODULE__{
       address: address,
       age: age,
       cpf: cpf,
       email: email,
       name: name
     }}
  end

  def build(_address, age, _cpf, _email, _name) when age < 18, do: {:error, "Age is invalid!"}

  def build(_address, _age, cpf, _email, _name) when not is_bitstring(cpf) do
    {:error, "CPF is invalid!"}
  end
end
