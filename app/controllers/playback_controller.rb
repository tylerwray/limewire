# frozen_string_literal: true

class PlaybackController < ApplicationController
  # NOTE: Skipping because this is a fetch API request. Is there a better way?
  skip_before_action :verify_authenticity_token

  def play
    spotify.play_track(page_params[:device_id], page_params[:track_id])
  end

  private

  def page_params
    params.permit(:device_id, :track_id)
  end
end
