defmodule Camping.Guardian.AuthPipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :camping,
    module: Camping.Guardian,
    error_handler: Camping.AuthErrorHandler

  plug Guardian.Plug.VerifyHeader, realm: "Bearer"
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
