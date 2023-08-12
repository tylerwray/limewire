class SearchController < ApplicationController
  def index
    @current_page = :search_results
    @results = spotify.search(page_params[:query])
    puts "results: #{@results.count}"
  end

  private
  
  def page_params
    params.permit(:query)
  end
end