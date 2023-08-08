# frozen_string_literal: true

class LoginController < ApplicationController
  layout "login"
  skip_before_action :require_login

  def spotify_login
    puts "spotify_login: #{request.env["omniauth.auth"]}"
    spotify_user = RSpotify::User.new(request.env["omniauth.auth"])

    # Assume last image is the largest
    image = spotify_user.images.last

    User.upsert({
      display_name: spotify_user.display_name,
      email: spotify_user.email,
      country: spotify_user.country,
      birthdate: spotify_user.birthdate,
      spotify_user_id: spotify_user.id,
      spotify_product: spotify_user.product,
      spotify_followers: spotify_user.product,
      spotify_access_token: spotify_user.credentials.token,
      spotify_refresh_token: spotify_user.credentials.refresh_token,
      spotify_profile_image_url: image["url"],
      spotify_profile_image_width: image["width"],
      spotify_profile_image_height: image["height"],
    },
      on_duplicate: :update,
      unique_by: :spotify_user_id)

    user = User.find_by(spotify_user_id: spotify_user.id)

    # Set user session.
    session_login(user.id)

    redirect_to(root_url)
  end

  def destroy
    session_logout
    flash[:notice] = "You have successfully logged out."
    redirect_to(root_url, status: :see_other)
  end
end
