# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @current_user_image = spotify_user.images.first
    @playlists = spotify_user.playlists
  end
end
