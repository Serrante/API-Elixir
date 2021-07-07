defmodule VotingWeb.Guardian do
  @moduledoc """
  JWT Authentication
  """

  use Guardian, otp_app: :voting

  alias Voting.Admins.Repo

  def subject_for_token(resource, _claims) do
    sub = to_string(resource.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = Repo.get_admin!(id)
    {:ok, resource}
  end
end
