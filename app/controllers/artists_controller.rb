# frozen_string_literal: true

class ArtistsController < ApplicationController
  def index
    @current_page = :playlists
    @current_page = :artists

    response = spotify.followed_artists(limit: 7, after: page_params[:after])

    @pagination = response.slice(:before, :after)
    puts "pagination: #{@pagination.inspect}"
    @artists = response[:items]
  end

  private

  def page_params
    params.permit(:after)
  end
end
