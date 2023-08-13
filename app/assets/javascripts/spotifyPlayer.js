window.SPOTIFY = {
  device_id: null,
  playTrack: (track_id) => {
    fetch("/playback/play", {
      credentials: 'include',
      method: "PUT",
      body: JSON.stringify({ device_id: window.SPOTIFY.device_id, track_id }),
      headers: { "Content-Type": "application/json" },
    });
  },
};

window.onSpotifyWebPlaybackSDKReady = () => {
  const player = new window.Spotify.Player({
    name: "Limewire - Web Playback",
    getOAuthToken: (cb) => {
      console.log("TOKEN", window.env.SPOTIFY_ACCESS_TOKEN);
      cb(window.env.SPOTIFY_ACCESS_TOKEN);
    },
    volume: 0.5,
  });

  // Ready
  player.addListener("ready", ({ device_id }) => {
    window.SPOTIFY.device_id = device_id;
    console.log("Ready with Device ID", device_id);
  });

  // Not Ready
  player.addListener("not_ready", ({ device_id }) => {
    console.log("Device ID has gone offline", device_id);
  });

  player.addListener("initialization_error", ({ message }) => {
    console.error(message);
  });

  player.addListener("authentication_error", ({ message }) => {
    console.error(message);
  });

  player.addListener("account_error", ({ message }) => {
    console.error(message);
  });

  player.addListener("autoplay_failed", () => {
    console.log("Autoplay is not allowed by the browser autoplay rules");
  });

  player.connect().then((success) => {
    if (success) {
      console.log("Connected!");
      player.activateElement();
    }
  });
};
