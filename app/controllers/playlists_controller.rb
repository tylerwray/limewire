# frozen_string_literal: true

class PlaylistsController < ApplicationController
  def index
    @current_page = :playlists

    @pagination, @playlists = helpers.paginate(page_params) do |limit:, offset:|
      spotify.playlists(limit: limit, offset: offset)
    end
  end

  private

  def page_params
    params.permit(:page)
  end
end
