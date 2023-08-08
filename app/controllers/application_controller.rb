# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :require_login
  attr_accessor :current_page

  def session_login(current_user_id)
    session[:current_user_id] = current_user_id
  end

  def session_logout
    session.delete(:current_user_id)
    @_current_user = nil
  end

  def logged_in?
    !!session[:current_user_id]
  end

  # Finds the User with the ID stored in the session with the key
  # :current_user_id This is a common way to handle user login in
  # a Rails application; logging in sets the session value and
  # logging out removes it.
  def current_user
    user = User.find_by(id: session[:current_user_id])
    unless user
      session_logout
      redirect_to(login_path)
      return
    end

    @_current_user ||= session[:current_user_id] && user
  end
  helper_method :current_user

  def spotify_user
    callback_proc = proc do |new_access_token|
      @_current_user = User.update(current_user.id, spotify_access_token: new_access_token)
    end

    @spotify_user ||= RSpotify::User.new(
      {
        "credentials" => {
          "token" => current_user.spotify_access_token,
          "refresh_token" => current_user.spotify_refresh_token,
          "access_refresh_callback" => callback_proc,
        },
        "id" => current_user.spotify_user_id,
      }
    )
  end

  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to(login_path) # halts request cycle
    end
  end
end
