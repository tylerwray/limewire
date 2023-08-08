# frozen_string_literal: true

class Spotify
  def initialize(params)
    @spotify_user = RSpotify::User.new(params)
  end

  def playlists(limit:, offset:)
    RSpotify.raw_response = true
    response = @spotify_user.playlists(limit: limit, offset: offset)
    RSpotify.raw_response = false
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Playlist.new(i) } }
  end
end
