# 別のモジュールの中にサブモジュールとして定義

# struct -> 要はタグ付きタプル
# 最初にタグ atom が入っていれば、後は自由
# defstruct されてないタグではタプルが作れない
# リテラルを作るときは %ModuleName{tag: value}

# :field1 default1, :field2 default2, ...

defmodule Identicon.Image do
  defstruct hex: nil, color: nil, grid: nil, pixel_map: nil
end
