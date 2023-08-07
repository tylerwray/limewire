# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    puts "spotify_user: #{spotify_user.playlists}"

    @playlists = []
  end
end
