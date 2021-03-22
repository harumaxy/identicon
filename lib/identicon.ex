defmodule Identicon do
  @moduledoc """
    Generate 250 x 250 px icon from a string
  """

  def main(input) do
    input
    |> hash_md5()
    |> pick_color()
    |> build_grid()
    |> filter_odd_squares
    |> build_pixel_map()
    |> draw_image()
    |> save_image(input)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

    # egd の描画関数は、フレームバッファに状態を書いていく。
    # image struct を更新するので、破壊的な上書き操作。Elixir では他にあまり例を見ない
    Enum.each(pixel_map, fn {start, stop} -> :egd.filledRectangle(image, start, stop, fill) end)

    # binary の画像を出す。これは画面に出力したり、ファイルとしてセーブできる。

    :egd.render(image)
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, i} ->
        horizontal = rem(i, 5) * 50
        vertical = div(i, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}
        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  def filter_odd_squares(image) do
    filtered_grid =
      image.grid
      |> Enum.filter(fn {code, _i} -> rem(code, 2) == 0 end)

    %Identicon.Image{image | grid: filtered_grid}
  end

  # 引数パターンマッチ。 pat = variable という形にすると、パターン全体を変数に代入したものも使える (as)
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # image.color = {r, g, b} というのはできない。なぜなら immutable だから
    # struct を更新した新しい構造体を作って返す
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(image) do
    grid =
      image.hex
      |> Enum.chunk_every(3)
      |> Enum.filter(&(length(&1) == 3))
      |> Enum.map(fn [a, b, c] -> [a, b, c, b, a] end)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  # mapに関数を渡す時、無名関数じゃない場合は &func_name/arity の形になる

  def hash_md5(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
