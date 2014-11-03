require 'sinatra'
require 'sinatra/reloader'

@@songs = Hash.new

get '/' do
 	erb :index
end

get '/enough' do
	@enough = 1
	erb :index
end

post '/songs/new/' do
 	@author = params["author"]
 	@song = params["song"]
 	@@songs[@author] = @song
 	if(@@songs.length > 3)
 		redirect "/enough"
 	else
	 	redirect "/"
	 end
end