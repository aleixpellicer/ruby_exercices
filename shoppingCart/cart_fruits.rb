class ShoppingCart
	attr_accessor :product, :price, :quantity, :listItem   
	def initialize
		@listItem = {}
		@price_list ={}
		# @banana = 10
	end
	def add_item (product, quantity)
		return @listItem[product] = quantity unless @listItem[product]
		@listItem[product] += quantity
	end
	def remove_item (product)
		@listItem.delete(product)
	end
	def price_item (product, quantity, price)
		# Definir cada product como una nueva clase, asociando les nombres y precios
		# # Recoger el array con la lista de productos y hacer un each para que coja cada 
		# item y le sume el precio. Diego ha convertido el array de items en objeto y luego hace el 
		# each con Key y Values. Para hacer el total se multiplica el precio por la quantity.
				@price_list ={}
		# puts "#{@listItem (0)}"
	end

	# crear funcion para aplicar discount definido en la clase items

end

# CREATION OF NEW SHOPPING CART

my_cart = ShoppingCart.new
my_cart.add_item("banana",2)
puts my_cart.listItem
my_cart.add_item("butter",2)
puts my_cart.listItem
# my_cart.remove_item("banana")
# puts my_cart.listItem