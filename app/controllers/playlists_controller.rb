# frozen_string_literal: true

class PlaylistsController < ApplicationController
  def index
    @current_page = :playlists
    @current_user_profile_image_url = current_user.spotify_profile_image_url
    @playlists = spotify_user.playlists
  end
end
