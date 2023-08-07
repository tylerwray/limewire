# frozen_string_literal: true

class LoginController < ApplicationController
  def spotify_oauth_callback
    spotify_user = RSpotify::User.new(request.env["omniauth.auth"])

    puts "images: #{spotify_user.images}"

    # Assuming the last image in the array is the largest one.
    image = spotify_user.images.last

    User.upsert({
      display_name: spotify_user.display_name,
      email: spotify_user.email,
      country: spotify_user.country,
      spotify_user_id: spotify_user.id,
      spotify_profile_image_url: image["url"],
      spotify_profile_image_height: image["height"],
      spotify_profile_image_width: image["width"],
    },
      on_duplicate: :update,
      unique_by: :spotify_user_id)

    redirect_to("/")
  end
end
