# frozen_string_literal: true

class AlbumsController < ApplicationController
  def index
    @current_page = :albums

    @pagination, @albums = helpers.paginate(page_params) do |limit:, offset:|
      spotify.saved_albums(limit: limit, offset: offset)
    end
  end

  private

  def page_params
    params.permit(:page)
  end
end
