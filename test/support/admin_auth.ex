defmodule VotingWeb.AdminAuth do
  @moduledoc """
  Authenticate request as admin
  """

  import Voting.Factory
  import Plug.Conn

  alias VotingWeb.Guardian

  def authenticate(conn, admin \\ insert(:admin)) do
    {:ok, token, _} = Guardian.encode_and_sign(admin)

    put_req_header(conn, "authorization", "Bearer " <> token)
  end
end
