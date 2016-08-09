# Scraper

> Scraping web pages as a way to learn more about Elixir, Erlang, tools, CSV, HTTP, and CSS.

```
edit mix.exs ... add deps
mix deps.get
... test:
iex -S mix
response = HTTPotion.get "http://cleesmith.github.io/"
HTTPotion.Response.success?(response)
response.headers
response.body

# the default timeout is 5000 ms, but can be changed:
response = HTTPotion.get "http://cleesmith.github.io/", [timeout: 10_000]

parsed = Floki.parse(response.body)
ttl = Floki.find(response.body, "title")
i ttl
... floki find returns a list []:
  [{"title", [], ["Thoughts about health, human nature, programming, GoLang, Ruby, Python, C, and Java"]}]
... get the 1st one from the list, ie the head:
ttt = hd ttl
i ttt
... returns a tuple {}:
  {"title", [], ["Thoughts about health, human nature, programming, GoLang, Ruby, Python, C, and Java"]}
tl = elem(ttt, 2)
i tl
... returns a list []:
  ["Thoughts about health, human nature, programming, GoLang, Ruby, Python, C, and Java"]
tls = hd tl
i tls
... returns a string:
  "Thoughts about health, human nature, programming, GoLang, Ruby, Python, C, and Java"


... how to get meta description:
meta_description = response.body |> Floki.find("meta[name='description']") |> Floki.attribute("content")

... CSV stuff:
File.stream!("cls.csv") |>
CSV.decode(separator: ?\t) |>
Enum.map(fn row ->
  Enum.map(row, &String.upcase/1)
end)

File.stream!("cls.csv") |>
CSV.decode(separator: ?\t) |>
Enum.each(&IO.puts/1) ... or Enum.each(&IO.puts &1)

1 .. 100 |>
Enum.map(fn (i) -> "http://localhost/?#{i}" end) |>
Enum.to_list

```
