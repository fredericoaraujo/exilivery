defmodule Exlivery.Orders.Item do
  @categories [:pizza, :hamburguer, :carne, :prato_feito, :japonesa, :sobremesa]
  @keys [:description, :category, :unity_price, :quantity]
  @enforce_keys @keys

  defstruct @keys

  def build(description, category, unity_price, quantity)
      when quantity > 0 and category in @categories do
    unity_price
    |> Decimal.cast()
    |> build_item(description, category, quantity)
  end

  def build(_description, category, _unity_price, _quantity) when category not in @categories do
    {:error, "Category is invalid!"}
  end

  def build(_description, _category, _unity_price, quantity) when quantity < 1 do
    {:error, "Quantity is invalid!"}
  end

  def build(_description, _category, unity_price, _quantity) when unity_price < 0 do
    {:error, "Unity price is invalid!"}
  end

  defp build_item({:ok, unity_price}, description, category, quantity) do
    {:ok,
     %__MODULE__{
       description: description,
       category: category,
       unity_price: unity_price,
       quantity: quantity
     }}
  end

  defp build_item(:error, _description, _category, _quantity) do
    {:error, "Unit price is invalid!"}
  end
end
