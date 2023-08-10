# frozen_string_literal: true

class Spotify
  def initialize(params)
    @spotify_user = RSpotify::User.new(params)
  end

  def playlists(limit:, offset:)
    RSpotify.raw_response = true
    response = @spotify_user.playlists(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Playlist.new(i) } }
  ensure
    RSpotify.raw_response = false
  end

  def saved_albums(limit:, offset:)
    RSpotify.raw_response = true
    response = @spotify_user.saved_albums(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Album.new(i["album"]) } }
  ensure
    RSpotify.raw_response = false
  end
end
