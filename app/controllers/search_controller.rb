# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @current_page = :search_results
    @results = spotify.search(page_params[:query])
    @crumbs = [{ name: "Search Results", path: "#{request.path}?query=#{page_params[:query]}" }]
  end

  private

  def page_params
    params.permit(:query)
  end
end
