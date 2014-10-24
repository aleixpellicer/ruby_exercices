movie_srt = "movie.srt"

class Movie 
	def initialize(subtitle, shiftAmmount, shiftDirection)
		@sub = IO.read(subtitle)
		@subtitle = subtitle
	end
	def showSub
		return @sub
	end
	def shift(shiftAmmount, shiftDirection)
		#we search for any timestamp on the file and iterate through them
		@sub.scan(/\d{2}[:]\d{2}[:]\d{2}[,]\d{3}/) {|w|
			#we split the tim:est:amp to get "hours" "minutes" and "seconds,milliseconds"
			hourstominutes = w.split(':')
			#then we split the "seconds,milliseconds" to get the seconds and milliseconds
			secondstomilliseconds = hourstominutes[2].split(',')
			#we set each value of the array into its corresponent variable
			hours = hourstominutes[0].to_i
			minutes = hourstominutes[1].to_i
			seconds = secondstomilliseconds[0].to_i
			milliseconds = secondstomilliseconds[1].to_i
			#we turn it all to milliseconds so we can add the shift milliseconds to it
			totalmilliseconds = (hours*3600000)+(minutes*60000)+(seconds*1000)+milliseconds
			#if its rewind substract, else add (as it's the most common option)
			if shiftDirection == "rewind"
				totalmilliseconds = totalmilliseconds - shiftAmmount
			else
				totalmilliseconds = totalmilliseconds + shiftAmmount
			end
			#let's make it go back to normal timestamp with just some basic math
			milliseconds = totalmilliseconds.to_s[-3,3]
			x = totalmilliseconds / 1000
			seconds = (x % 60).to_s.rjust(2, "0")
			x /= 60
			minutes = (x % 60).to_s.rjust(2, "0")
			x /= 60
			hours = (x % 24).to_s.rjust(2, "0")
			#set it back to the timestamp format
			newdate = "#{hours}:#{minutes}:#{seconds},#{milliseconds}"			
			#and replace the old timestamp with the new one
			@sub = @sub.gsub(w, newdate)
		}
		#then just save the file!
		dest_file = "shifted_#{@subtitle}"
		IO.write(dest_file, @sub)
		puts "A new shifted file has been created"
	end
end

scream = Movie.new(movie_srt, nil, nil)

scream.shift(2500,'forward')