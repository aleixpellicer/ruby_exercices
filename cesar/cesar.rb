#function encrypt
def enCrypt(string, shift=nil, direction, alphabet)
	#we set the default shift to 3 if nil argument is passed
	shift ||= 3
	#we create a map of the alphabet to position it
	hash = Hash[alphabet.map.with_index.to_a]
	cesarWord = ""
	#delete punctuation signs
	string = string.gsub!(/[^a-z0-9\s]/i, '')
	#we loop each character
	string.split("").each do |i|
		#if the character it's an empty character we just add the space to the concatenation word (cesarWord)
		if string[i] == " "
			cesarWord << " "
		else
			#the position of the character(downcased) in our alphabet array
			positionInArray = hash[i.downcase]
			# if the shift is bigger than our alphabet, we should reduce it
			if shift > alphabet.length
				numIterations = (shift / alphabet.length).floor	
				shift = shift - (alphabet.length*numIterations)
			end
			#if the direction is right or left we add or substract
			if direction == "r"
				operation = positionInArray+shift
				#if the position exceeds the size of the array substract it to start from left again
				if operation > alphabet.length
					operation = operation - alphabet.length
				end
			else
				operation = positionInArray-shift
				#if the position is minor than 0, make it start from the right again
				if operation < 0
					operation = alphabet.length - operation.abs
				end
			end
			#concatenate the result
			cesarWord << alphabet[operation]
		end
	end
	return cesarWord
end

#our alphabet, we can use any other alphabet
alphabet = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
palabra = "Hola que ase."

#Encrypt (word, number of positions, direccion, array alphabet)
cesar = enCrypt(palabra, 131, "r", alphabet)
puts "la palabra '#{palabra}' encriptada es '#{cesar}'"

#Decrypt, in this case we can use the same function, but instead of left, we use right
cesar_decrypt = enCrypt(cesar, 131, "l", alphabet)
puts "la palabra '#{cesar} desencriptada es '#{cesar_decrypt}'"