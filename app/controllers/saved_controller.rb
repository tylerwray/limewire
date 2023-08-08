# frozen_string_literal: true

class SavedController < ApplicationController
  def index
    @current_page = :saved
    @saved = []
  end
end
