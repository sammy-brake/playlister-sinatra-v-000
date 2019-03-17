class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    # binding.pry
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    ##########@songs=Song.all
    erb :'songs/new'
  end

  post '/songs' do
    @song = Song.create(name: params[:Name])

    @song.artist = Artist.find_or_create_by(name: params["artist"]["name"])
    # binding.pry
    @song.genres << Genre.find_by_id(params[:genres])
    @song.save
    # binding.pry
    redirect 'songs/<%=@song.name.slug%>'
  end
  #
  # post 'songs/new' do
  #
  # end

  get '/songs/:slug' do
    binding.pry
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
   @song = Song.find_by_slug(params[:slug])
   erb :'songs/edit'
  end

  patch '/songs/:slug/' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
    @song.save
  end
end
