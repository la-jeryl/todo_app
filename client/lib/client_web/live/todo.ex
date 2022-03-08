defmodule ClientWeb.Live.Todo do
  use ClientWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="self-center h-100 w-full flex items-center justify-center font-sans">
      <div class="section-main">
        <%= live_component(__MODULE__.Input) %>
        <%= live_component(__MODULE__.List) %>
      </div>
    </div>
    """
  end
end
