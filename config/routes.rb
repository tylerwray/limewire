# frozen_string_literal: true

Rails.application.routes.draw do
  root "playlists#index"

  get "/playlists/:id", to: "playlists#show"
  get "/login", to: "login#index"
  get "/logout", to: "login#destroy"
  get "/albums", to: "albums#index"
  get "/albums/:id", to: "albums#show"
  get "/saved_tracks", to: "saved_tracks#index"
  get "/settings", to: "settings#index"
  get "/search", to: "search#index"

  put "/playback/play", to: "playback#play"

  get "/auth/spotify/callback", to: "login#spotify_login"
end
