# frozen_string_literal: true

class ArtistsController < ApplicationController
  def index
    @current_page = :artists
    @artists = []
  end
end
