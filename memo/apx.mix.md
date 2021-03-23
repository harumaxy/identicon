# mix compile

compile した結果は、`_build/dev/lib/<module>` 以下に配置される。


`.app`ファイルは Erlang のアプリケーションファイル
`.beam`は BEAM マシンのバイトコード

# iex -S mix

mix プロジェクト内で実行すると、モジュールを全部読み込んだ状態でシェルを開始
`-S mix`がどういうオプションなのかドキュメントがない


# mix test
mix project では
`lib` と `test` のディレクトリ構造を対照的にして、
モジュールがあるファイルには `<filename>_test.exs` を置くようにすることが習慣になってる

`mix test`コマンドは、`test`ディレクトリにある`.exs`を全て実行する
なお、`test_helper.exs` はいつも最初に起動される
`ExUnit.start()`がエントリーポイント

また、乱数のシードも毎回ランダムなので、自動的にランダムにできる

# re:test

`test/path/to/file.exs:line`  を指定すると、
テストが失敗したころだけ再テストできる

```sh
mix test test/kv_test.exs:5
```

# mix format

フォーマットを実行
`.formatter.exs`の設定に従う

`mix format --check-formatted` を実行すると、フォーマットされているかチェック。
exit コードで成功/失敗

# environment

mix project では環境の概念がある
`:dev`, `:test`, `:prod`

- プロジェクトに追加したライブラリ/パッケージ等の `deps`は、`:prod`の設定で動作する
- 自分が書いたコードを `compile`などをする時、デフォルトで `:dev` でコンパイルされる


## Mix.env/0
実行中のmix環境のアトムを返す関数

## start_permanent:
`def project do [...] end` の設定にあるもの
デフォルトだと、`Mix.env == :prod`

`true`だと、クラッシュした時 Erlang VM を落とす
スタックトレースのため、:dev と :test では false にする


# MIX_ENV 

`mix compile` に関連する環境変数
文字列をセットして、モードを変更する

次のビルドだけ設定
```sh
MIX_ENV=prod mix compile
```

なお、Mix はビルドツールであり、本番環境でのバンドルは期待できない。
Elixir Module としては、 `mix.exs` と configuration files の中でのみ使う

(`Mix.env/0` など)

# Source

https://github.com/elixir-lang/elixir/tree/master/lib/mix

`Elixir` のライブラリは、`doctes` や `@moduledoc` などが推奨されているせいか、
ソース自体を見ると全容を把握しづらい。

`ex_doc` で生成された HTML ページを見るべし


# Doc

