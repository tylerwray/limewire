# frozen_string_literal: true

require "rspotify/oauth"

SCOPES = [
  "playlist-read-private",
  "streaming",
  "user-follow-read",
  "user-library-read",
  "user-modify-playback-state",
  "user-read-email",
  "user-read-private",
]

Rails.application.config.middleware.use(OmniAuth::Builder) do
  provider :spotify, ENV["SPOTIFY_CLIENT_ID"], ENV["SPOTIFY_CLIENT_SECRET"], scope: SCOPES.join(" ")
end

OmniAuth.config.logger = Rails.logger

OmniAuth.config.allowed_request_methods = [:post, :get]
