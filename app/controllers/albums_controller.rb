# frozen_string_literal: true

class AlbumsController < ApplicationController
  def index
    @current_page = :albums
    @crumbs = [{ name: "Albums", path: "/albums" }]

    @pagination, @albums = helpers.paginate(page_params) do |limit:, offset:|
      spotify.saved_albums(limit: limit, offset: offset)
    end
  end

  def show
    @current_page = :albums
    @album = spotify.find_album(params[:id])
    params = page_params.merge(limit: 20)
    @pagination, @tracks = helpers.paginate(params) do |limit:, offset:|
      spotify.album_tracks(@album, limit: limit, offset: offset)
    end
    @crumbs = [{ name: "Albums", path: "/albums" }, { name: @album.name, path: "/albums/#{@album.id}" }]
  end

  private

  def page_params
    params.permit(:page, :id)
  end
end
