Fruits = {
	"apples" => 10,
	"oranges" => 5,
	"grapes" => 15,
	"banana" => 20,
	"watermelon" => 50
}

apples     10$
oranges     5$
grapes     15$
banana     20$
watermelon 50$

class Product
	def initialize(product, quantity, loyal)
		@product = product
		@price = price
		@quantity = quantity
		@shopping_list = {}

		if loyal == true && @quantity > 5<w
			@@startDiscount = 10
		else
			@@startDiscount = 0
		end
	end
	def addItem(product, quantity)
		@shopping_list[product] = quantity unless @shopping_list[product]
		@shopping_list[product] += quantity
	end
	def discount(product, )

	end
end

class Fruit < Product
	def initialize(product, price, quantity, loyal, weekday)
		super(product, price, quantity, loyal)
		@weekday = weekday
	end
	def discount
		
		if @weekday > 5
			extraDiscount = 10;
		else
			extraDiscount = 0;
		end

		totalPrice = @price * @quantity
		discount = extraDiscount + @@startDiscount
		if discount > 0
			totalDiscount = totalPrice / discount
		else
			totalDiscount = 0
		end
		totalPriceDiscount = totalPrice - totalDiscount

		puts "You bought:\n#{@quantity} #{@product}\nUnits: #{@quantity}\nPrice per unit: #{@price}\nTotal price:#{totalPrice}\nDiscount: #{discount}%\nTotal discount:#{totalDiscount}\nTotal price with discount:#{totalPriceDiscount}\n=================="
	end
end

class Houseware < Product
	def initialize(product, price, quantity, loyal)
		super(product, price, quantity, loyal)
	end
	def discount
		
		if @price > 100
			extraDiscount = 5;
		else
			extraDiscount = 0;
		end

		totalPrice = @price * @quantity
		discount = extraDiscount + @@startDiscount
		if discount > 0
			totalDiscount = totalPrice / discount
		else
			totalDiscount = 0
		end
		totalPriceDiscount = totalPrice - totalDiscount

		puts "You bought:\n#{@quantity} #{@product}\nUnits: #{@quantity}\nPrice per unit: #{@price}\nTotal price:#{totalPrice}\nDiscount: #{discount}%\nTotal discount:#{totalDiscount}\nTotal price with discount:#{totalPriceDiscount}\n=================="

	end
end

class NormalItem < Product
	def initialize(product, price, quantity, loyal)
		super(product, price, quantity, loyal)
	end
	def discount
		extraDiscount = 0
		totalPrice = @price * @quantity
		discount = extraDiscount + @@startDiscount
		if discount > 0
			totalDiscount = totalPrice / discount
		else
			totalDiscount = 0
		end
		totalPriceDiscount = totalPrice - totalDiscount

		puts "You bought:\n#{@quantity} #{@product}\nUnits: #{@quantity}\nPrice per unit: #{@price}\nTotal price:#{totalPrice}\nDiscount: #{discount}%\nTotal discount:#{totalDiscount}\nTotal price with discount:#{totalPriceDiscount}\n=================="
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

