#function sort
def sortAlphabetically(string)
	#lets remove the dots
	string = string.gsub!(/[^a-z0-9\s]/i, '')
	#we transofrm the string into a words array
	words = words = string.split(" ")
	#we sort the array ignoring downcase
	words = words.sort_by{|word| word.downcase}
	#lets turn the array into a string
	words = words.join(' ')
	return words
end
#let's try it
word = "Hola que ase.!"
puts sortAlphabetically(word)