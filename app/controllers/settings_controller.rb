# frozen_string_literal: true

class SettingsController < ApplicationController
  def index
    @current_page = :settings
    @crumbs = [{ name: "Settings", path: "/settings" }]
  end
end
