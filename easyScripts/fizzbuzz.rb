i = 1
num = 101
while i < num  do   
	if i % 3 == 0
		puts "Fizz\n"
	elsif i % 5 == 0
		puts "Buzz\n"
	else
		puts "#{i}\n"
	end
   i +=1
end