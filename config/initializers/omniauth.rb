# frozen_string_literal: true

require "rspotify/oauth"

Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"],
    scope: "user-read-private user-read-email playlist-read-private user-library-read user-follow-read"
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.allowed_request_methods = [:post, :get]
