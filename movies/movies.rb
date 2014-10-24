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
		
		@sub.scan(/\d{2}[:]\d{2}[:]\d{2}[,]\d{3}/) {|w|

			hourstominutes = w.split(':')
			secondstomilliseconds = hourstominutes[2].split(',')
			hours = hourstominutes[0].to_i
			minutes = hourstominutes[1].to_i
			seconds = secondstomilliseconds[0].to_i
			milliseconds = secondstomilliseconds[1].to_i
			
			totalmilliseconds = (hours*3600000)+(minutes*60000)+(seconds*1000)+milliseconds
			
			if shiftDirection == "rewind"
				totalmilliseconds = totalmilliseconds - shiftAmmount
			else
				totalmilliseconds = totalmilliseconds + shiftAmmount
			end

			#go back to normal time
			milliseconds = totalmilliseconds.to_s[-3,3]
			x = totalmilliseconds / 1000
			seconds = (x % 60).to_s.rjust(2, "0")
			x /= 60
			minutes = (x % 60).to_s.rjust(2, "0")
			x /= 60
			hours = (x % 24).to_s.rjust(2, "0")

			newdate = "#{hours}:#{minutes}:#{seconds},#{milliseconds}"			
			
			@sub = @sub.gsub(w, newdate)
		}
		dest_file = "shifted_#{@subtitle}"
		IO.write(dest_file, @sub)
		puts "A new shifted file has been created"

	end
end

scream = Movie.new(movie_srt, nil, nil)

scream.shift(2500,'forward')