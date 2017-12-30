# Shelter

> mix deps.get

> mix compile

In three different terminals

> iex --name a@127.0.0.1 -pa _build/dev/lib/shelter/ebin/ --app shelter --erl "-config config/a"
> iex --name b@127.0.0.1 -pa _build/dev/lib/shelter/ebin/ --app shelter --erl "-config config/b"
> iex --name c@127.0.0.1 -pa _build/dev/lib/shelter/ebin/ --app shelter --erl "-config config/c"
