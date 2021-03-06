defmodule Battleship.PlayerSocket do
  @moduledoc """
  Player socket
  """
  use Phoenix.Socket

  ## Channels
  channel "lobby", Battleship.LobbyChannel
  channel "game:*", Battleship.GameChannel

  ## Transports
  transport :websocket,
    Phoenix.Transports.WebSocket,
    timeout: :infinity

  # transport :longpoll, Phoenix.Transports.LongPoll

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  def connect(%{"id" => player_id}, socket) do
    {:ok, assign(socket, :player_id, player_id)}
  end
  def connect(_, _socket), do: :error

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "users_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     Battleship.Endpoint.broadcast("users_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  def id(socket), do: "players_socket:#{socket.assigns.player_id}"
end
