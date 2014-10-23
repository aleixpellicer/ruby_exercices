puts "Write the filename to copy!"
fileToCopy = gets.chomp
fileToCopyContents = IO.read(fileToCopy)
puts "Write the name of the destination file!"
fileDestination = gets.chomp
IO.write(fileDestination, fileToCopyContents)
puts "Your file has been copied!"