# frozen_string_literal: false
require 'rspotify'

class SpotifyController < ActionController::Base
    skip_before_action :verify_authenticity_token

  
    def player
  
        RSpotify.authenticate("37dec3e9411741a594715dd2d926338b", "bd5c2bb0c3b448459ccf50bc6a78fe5c")

        # Now you can access playlists in detail, browse featured content and more
        
        me = RSpotify::User.find('guilhermesad')
        me.playlists #=> (Playlist array)
        
        # Find by id
        playlist = RSpotify::Playlist.find('guilhermesad', '1Xi8mgiuHHPLQYOw2Q16xv')
        playlist.name               #=> "d33p"
        playlist.description        #=> "d33p h0uz"
        playlist.followers['total'] #=> 1
        playlist.tracks             #=> (Track array)
        
        # Search by category
        party = RSpotify::Category.find('party')
        party.playlists #=> (Playlist array)
        categories = RSpotify::Category.list # See all available categories
        
        # Access featured content from Spotify's Browse tab
        featured_playlists = RSpotify::Playlist.browse_featured(country: 'US')
        new_releases = RSpotify::Album.new_releases(country: 'ES')
        
        # Access tracks' audio features
        sorry = RSpotify::Track.search("Sorry").first
        sorry.audio_features.danceability #=> 0.605
        sorry.audio_features.energy #=> 0.768
        sorry.audio_features.tempo #=> 100.209
        
        # Get recommendations
        recommendations = RSpotify::Recommendations.generate(seed_genres: ['blues', 'country'])
        recommendations = RSpotify::Recommendations.generate(seed_tracks: my_fav_tracks.map(&:id))
        recommendations = RSpotify::Recommendations.generate(seed_artists: my_fav_artists.map(&:id))
        recommendations.tracks #=> (Track array)
          
    end
end
