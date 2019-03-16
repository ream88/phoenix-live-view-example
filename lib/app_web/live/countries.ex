defmodule AppWeb.Countries do
  use Phoenix.LiveView
  alias App.Country

  def render(assigns) do
    ~L"""
    <form phx-change="suggest" phx-submit="search">
      <input name="query" list="matches" placeholder="Search for a Country…" value="<%= @query %>"
        <%= if @loading, do: "readonly" %>
      />

      <datalist id="matches">
      <%= for country <- @matches do %>
        <option value="<%= country.name %>"><%= country.name %></option>
      <% end %>
      </datalist>

      <%= if @loading do %>
        <div>Loading…</div>
      <% end %>
      <%= if @result do %>
        <div><%= @result %></div>
      <% end %>
    </form>
    """
  end

  def mount(_session, socket) do
    {:ok, assign(socket, query: nil, result: nil, loading: false, matches: [])}
  end

  def handle_event("suggest", %{"query" => query}, socket) do
    matches = Country.suggest(query)
    {:noreply, assign(socket, query: query, matches: matches)}
  end

  def handle_event("search", %{"query" => query}, socket) do
    send(self(), {:search, query})
    {:noreply, assign(socket, loading: true, result: [])}
  end

  def handle_info({:search, query}, socket) do
    :timer.sleep(1000)
    result = "Some info about #{query}"

    {:noreply, assign(socket, loading: false, matches: [], result: result)}
  end
end
