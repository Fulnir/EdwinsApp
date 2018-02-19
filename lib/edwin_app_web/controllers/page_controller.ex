defmodule EdwinAppWeb.PageController do
  use EdwinAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
