# frozen_string_literal: true

class SavedTracksController < ApplicationController
  def index
    @current_page = :saved_tracks
    @crumbs = [{ name: "Saved Tracks", path: "/saved_tracks" }]

    @pagination, @saved_tracks = helpers.paginate(page_params) do |limit:, offset:|
      spotify.saved_tracks(limit: limit, offset: offset)
    end
  end

  private

  def page_params
    params.permit(:page)
  end
end
