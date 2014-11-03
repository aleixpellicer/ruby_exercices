require 'sinatra'
require 'sinatra/reloader'

@@operation = ''
@@first_value = 0
@@second_value = 0
@@result = 0

def formatnum(num, fromform)
	if fromform == 1
		num = num.sub(",", ".")
	end

	if num == num.to_i
		return num.to_i
	else
		return num.to_f
	end
end

get '/' do
 	erb :index
end

post '/sum' do

	@@operation = 'addition'
	@@first_value = formatnum(params['first_value'],1)
	@@second_value = formatnum(params['second_value'],1)
	@@result = formatnum(@@first_value+@@second_value, 0)
 	redirect '/'
end

post '/substract' do
	@@operation = 'substraction'
	@@first_value = formatnum(params['first_value'],1)
	@@second_value = formatnum(params['second_value'],1)
	@@result = @@first_value-@@second_value
 	redirect '/'
end

post '/multiply' do
	@@operation = 'multiplication'
	@@first_value = formatnum(params['first_value'],1)
	@@second_value = formatnum(params['second_value'],1)
	@@result = @@first_value*@@second_value
 	redirect '/'
end

post '/divide' do
	@@operation = 'division'
	@@first_value = formatnum(params['first_value'],1)
	@@second_value = formatnum(params['second_value'],1)
	@@result = @@first_value/@@second_value
	@@result = formatnum(@@result,0)
 	redirect '/'
end

get '/count' do
	@enough = 1
	erb :index
end

