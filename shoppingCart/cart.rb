class Product
	def initialize(product, price, quantity, loyal)
		@product = product
		@price = price
		@quantity = quantity

		if loyal == true && @quantity > 5
			@@startDiscount = 10
		else
			@@startDiscount = 0
		end

	end
end

class Fruit < Product
	def initialize(product, price, quantity, loyal, weekday)
		super(product, price, quantity, loyal)
		@weekday = weekday
	end
	def discount
		if @weekday > 5
			totalPrice = @price * @quantity
			discount = 10 + @@startDiscount
			totalDiscount = totalPrice / discount
			totalPriceDiscount = totalPrice - totalDiscount
			puts "You bought:\n#{@quantity} #{@product}\nUnits: #{@quantity}\nPrice per unit: #{@price}\nTotal price:#{totalPrice}\nDiscount: #{discount}%\nTotal discount:#{totalDiscount}\nTotal price with discount:#{totalPriceDiscount}\n=================="
		else
			puts "The discount on #{@quantity} #{@product} is #{@@startDiscount}"
		end
	end
end

class Houseware < Product
	def initialize(product, price, quantity, loyal)
		super(product, price, quantity, loyal)
	end
	def discount
		if @price > 100
			discount = (@price * @quantity) / (5 + @@startDiscount)
			puts "The discount on #{@quantity} #{@product} is #{discount}"
		else
			puts "The discount on #{@quantity} #{@product} is #{@@startDiscount}"
		end
	end
end

class NormalItem < Product
	def initialize(product, price, quantity, loyal)
		super(product, price, quantity, loyal)
	end
	def discount
		puts "The discount on #{@quantity} #{@product} is #{@startDiscount}"
	end
end

# Bananas, 10€, 4 units, is loyal, wednesday -> should output 
banana = Fruit.new("Bananas", 10, 4, true, 6)
banana.discount

orangeJuice = Fruit.new("Orange Juices", 10, 2, false, 6)
orangeJuice.discount

vacummer = Houseware.new("Vacummer", 150, 1, false)
vacummer.discount

vacummerC = Houseware.new("Cheap Vacummer", 90, 2, false)
vacummerC.discount

rice = NormalItem.new("Rice", 1, 2, false)
rice.discount

anchovies = NormalItem.new('Anchovies', 2, 3, true)
anchovies.discount

