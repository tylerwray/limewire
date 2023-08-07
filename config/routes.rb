# frozen_string_literal: true

Rails.application.routes.draw do
  root "home#index"

  get "/login", to: "login#index"
  get "/logout", to: "login#destroy"

  get "/auth/spotify/callback", to: "login#spotify_login"
end
