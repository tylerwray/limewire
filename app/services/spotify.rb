# frozen_string_literal: false

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

  def find_playlist(user_id, id)
    RSpotify::Playlist.find(user_id, id)
  end

  def saved_albums(limit:, offset:)
    RSpotify.raw_response = true
    response = @spotify_user.saved_albums(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Album.new(i["album"]) } }
  ensure
    RSpotify.raw_response = false
  end

  def find_album(id)
    RSpotify::Album.find(id)
  end

  def saved_tracks(limit:, offset:)
    RSpotify.raw_response = true
    response = @spotify_user.saved_tracks(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Track.new(i["track"]) } }
  ensure
    RSpotify.raw_response = false
  end

  def playlist_tracks(playlist, limit:, offset:)
    RSpotify.raw_response = true
    response = playlist.tracks(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    { total: parsed["total"], items: parsed["items"].map { |i| RSpotify::Track.new(i["track"]) } }
  ensure
    RSpotify.raw_response = false
  end

  def album_tracks(album, limit:, offset:)
    RSpotify.raw_response = true
    response = album.tracks(limit: limit, offset: offset)
    parsed = JSON.parse(response) unless response.nil? || response.empty?
    tracks = parsed["items"].map { |i| RSpotify::Track.new(i) }
    { total: parsed["total"], items: tracks }
  ensure
    RSpotify.raw_response = false
  end

  def search(query)
    RSpotify::Base.search(query, "artist, album, track")
  end
end
