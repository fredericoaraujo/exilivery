defmodule Exlivery.Orders.ReportTest do
  use ExUnit.Case

  import Exlivery.Factory

  alias Exlivery.Orders.Agent, as: OrderAgent
  alias Exlivery.Orders.Report

  describe "call/1" do
    test "creates the report file" do
      OrderAgent.start_link(%{})

      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      expected =
        "12345678900,pizza,1,35.5,japonesa,2,20.5,76.5012345678900," <>
          "pizza,1,35.5,japonesa,2,20.5,76.50"

      Report.create("report_test.csv")

      response = File.read!("report_test.csv")

      assert response == expected
    end
  end
end
