# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login

  def logged_in?
    !!session[:current_user_id]
  end

  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    @_current_user ||= session[:current_user_id] &&
      User.find_by(id: session[:current_user_id])
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to(login_path) # halts request cycle
    end
  end
end
