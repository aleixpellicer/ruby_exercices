#function sort
def sortAlphabetically(string)
	#lets remove the dots
	string.gsub!('.','')
	#we transofrm the string into a words array
	words = string.split(" ")
	words = words.sort
	puts words.inspect

end

word = "hola que ase."

sortAlphabetically(word)