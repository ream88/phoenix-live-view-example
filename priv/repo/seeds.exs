# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     App.Repo.insert!(%App.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

__DIR__
|> Path.join("./countries.txt")
|> File.stream!()
|> Enum.map(fn country ->
  %App.Country{name: country}
end)
|> Enum.each(&App.Repo.insert!/1)
