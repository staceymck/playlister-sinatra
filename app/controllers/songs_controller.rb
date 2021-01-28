require 'rack-flash'

class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
    song = Song.create(params[:song])
    if !params[:artist][:name].empty?
      song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    end
    song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{song.slug}"
  end

  get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    song = Song.find_by_slug(params[:slug])
    song.update(params[:song])

    if !params[:artist][:name].empty?
      song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    end
    song.save
    flash[:message] = "Successfully updated song."
    
    redirect to "/songs/#{song.slug}"
  end

end

# params = {
#   "song" => {"name" => "Hello", "artist_id" => 5, "genre_ids" => [1, 3, 5]},
#   "artist" => {"name" => "usr submits name"}
# }