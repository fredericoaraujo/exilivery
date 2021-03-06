defmodule Exlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Users.Agent, as: UserAgent
  alias Exlivery.Users.CreteOrUpdate

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "when all params are valid, saves the user" do
      params = build(:user)

      response = CreteOrUpdate.call(params)
      expected = {:ok, "User created with successfully"}

      assert response == expected
    end

    test "when any params is/are not valid, returns error" do
      params = build(:user, cpf: 12_345_678_900)

      {response, _reason} = CreteOrUpdate.call(params)
      expected = :error

      assert response == expected
    end
  end
end
