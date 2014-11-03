require 'sinatra'
require 'sinatra/reloader'
require 'artii'

get '/' do
	@text = Artii::Base.new
	@text2 = @text.asciify('Ironhack!')
	erb :index
end
