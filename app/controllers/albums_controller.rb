# frozen_string_literal: true

class AlbumsController < ApplicationController
  def index
    @current_page = :albums
    @albums = []
  end
end
