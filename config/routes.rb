# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/login", to: "login#index"

  get "/auth/spotify/callback", to: "login#spotify_oauth_callback"

  # Defines the root path route ("/")
  # root "articles#index"
end
