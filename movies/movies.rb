movie_srt = "movie.srt"

class Movie 
	def initialize(subtitle, shiftAmmount, shiftDirection)
		@sub = IO.read(subtitle)
		@subtitle = subtitle

		#let's parse the text and format it so we can work on it on some of the following methods
		text = @sub.gsub!("\r\n\r\n", "<-jumpline->")
		#let's put the different parts of the srt into an array so we can work on them
		@parts = text.split("<-jumpline->")
	end
	def showSub
		return @sub
	end
	def shift(shiftAmmount, shiftDirection)
		newSub = @sub
		#we search for any timestamp on the file and iterate through them
		newSub.scan(/\d{2}[:]\d{2}[:]\d{2}[,]\d{3}/) {|w|
			#we split the tim:est:amp to get "hours" "minutes" and "seconds,milliseconds"
			hourstominutes = w.split(":")
			#then we split the "seconds,milliseconds" to get the seconds and milliseconds
			secondstomilliseconds = hourstominutes[2].split(",")
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
			newSub = newSub.gsub(w, newdate)
		}
		newSub.gsub!("<-jumpline->", "\r\n\r\n")
		#then just save the file!
		dest_file = "shifted_#{@subtitle}"
		IO.write(dest_file, newSub)
		puts "A new shifted file has been created"
	end
	def checkTypos
		newParts = @parts
		#we load the list of words to check against
		dictionary = IO.read("words").split("\n")
		#we load the list of words to ignore
		ignored = IO.read("ignored_words.txt").split("\r\n")
		#this hash will contain an ID (the word), and an array of the times where the word appears
		typos = Hash.new {|h,k| h[k] = Array.new }
		#let's loop each part of the SRT
		newParts.each {|x|
			
			text = x.gsub("\r\n", " ")
			current_timestamp = text.match(/\d{2}[:]\d{2}[:]\d{2}[,]\d{3}/)
			#remove the timestamps so we are left with just the text
			text = text.gsub(/[0-9]+.\d{2}:\d{2}:\d{2},\d{3}.-->.\d{2}:\d{2}:\d{2},\d{3}./, "")
			#remove all punctuation signs except ' 
			text = text.gsub(/[^a-z0-9\s']/i, '')
			#put all the words into an array so we can loop it
			text = text.split(" ")
			text.each{|y|	
				unless ignored.include?(y)
					#if the word is not inside the dictionary list, we add it inside our array
					unless dictionary.include?(y.downcase)
						typos[y].push(current_timestamp)
					end
				end
			}
		}
		#once we have the array with all the info, we just need to output it in the correct format
		outputPotentialTypos = ""
		typos.each {|k,v|
			outputPotentialTypos << "#{k}: " << v.join(" , ") << "\r\n"
		}
		#and voilà, save the file
		IO.write("potential_typos.txt", outputPotentialTypos)
		puts "A file called potential_typos.txt has been created containing potential typos."
	end
	def createProfanity
		newParts = @parts
		#let's read the censored words ant put them into an array
		profanity_words = IO.read("profanity_words.txt").split("\r\n")
		#let's loop each part of the subtitles
		newParts.each {|x|
			#we grab the current timestamp so we can check the minute later on
			current_timestamp = x.match(/\d{2}[:]\d{2}[:]\d{2}[,]\d{3}/).to_s
			hourstominutes = current_timestamp.split(":")
			#set the minutes into a variable
			minutes = hourstominutes[1].to_i
			#if the minute is equal over 30 we exit the loop
			if minutes >= 30
				break		
			else
				#else we keep censoring words
				profanity_words.each{|y|
					x.gsub!(y, "CENSORED")
				}	
			end
		}
		#we join the array again to output it into a new file
		outPutCensoredSrt = newParts.join("\r\n\r\n")
		IO.write("childsafe_subtitles.srt", outPutCensoredSrt)
		puts "A file called childsafe_subtitles.srt has been created. Now your kids can watch!"
	end
end

scream = Movie.new(movie_srt, nil, nil)

#this is how we call them...
scream.shift(2500,'forward')
scream.checkTypos()
scream.createProfanity()