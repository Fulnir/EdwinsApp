defmodule EdwinAppWeb.PageController do
  use EdwinAppWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def impressum(conn, _params) do
    render conn, "impressum.html", conn: conn #, body_class: "stretch"
  end
end
