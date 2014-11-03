require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @date = DateTime.now 
  erb :index
end

# post '/hello' do
#   @name = params["username"]
#   "Hello #{@name}"
# end

get '/hello/:username' do
  @name = params["username"]
  "Hello #{@name}"
end