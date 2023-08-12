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

  def saved_tracks(limit:, offset:)
    RSpotify.raw_response = true
    response = @spotify_user.saved_tracks(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Track.new(i["track"]) } }
  ensure
    RSpotify.raw_response = false
  end

  def followed_artists(limit:, after:)
    RSpotify.raw_response = true
    response = @spotify_user.following(type: "artist", limit: limit, after: after)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    puts "Cursors: #{parsed["artists"]["cursors"].inspect}"
    {
      after: parsed["artists"]["cursors"]["after"],
      before: parsed["artists"]["cursors"]["before"],
      items: parsed["artists"]["items"].map { |a| RSpotify::Artist.new(a) },
    }
  ensure
    RSpotify.raw_response = false
  end
end
