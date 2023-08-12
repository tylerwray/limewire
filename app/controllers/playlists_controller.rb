# frozen_string_literal: true

class PlaylistsController < ApplicationController
  def index
    @current_page = :playlists
    @crumbs = [{ name: "Playlists", path: "/" }]

    @pagination, @playlists = helpers.paginate(page_params) do |limit:, offset:|
      spotify.playlists(limit: limit, offset: offset)
    end
  end

  def show
    @current_page = :playlists
    @playlist = spotify.find_playlist(current_user.spotify_user_id, params[:id])
    params = page_params.merge(limit: 20)
    @pagination, @tracks = helpers.paginate(params) do |limit:, offset:|
      spotify.playlist_tracks(@playlist, limit: limit, offset: offset)
    end
    @crumbs = [{ name: "Playlists", path: "/" }, { name: @playlist.name, path: "/playlists/#{@playlist.id}" }]
  end

  private

  def page_params
    params.permit(:page, :id)
  end
end
