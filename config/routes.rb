# frozen_string_literal: true

Rails.application.routes.draw do
  root "playlists#index"

  get "/login", to: "login#index"
  get "/logout", to: "login#destroy"
  get "/albums", to: "albums#index"
  get "/artists", to: "artists#index"
  get "/saved", to: "saved#index"
  get "/settings", to: "settings#index"

  get "/auth/spotify/callback", to: "login#spotify_login"
end
