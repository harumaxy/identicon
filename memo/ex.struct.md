# Struct
構造体データ
フィールド名と値がセットになったものを複数持つ

内部的には Map と同一の処理らしい

# Struct vs Map

Struct を使うメリット
- デフォルト値を持てる
- コンパイル時にタイプチェックされる
- modularity


# Struct & Module

Module 内で defstruct して、
そのモジュールには struct を操作する関数を実装する

(`type t` と それを操作する関数群)


# Pattern matching