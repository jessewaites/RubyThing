Snack = Struct.new(:name, :carbs)

module Snackbar
	SNACKS = [
		Snack.new(:popcorn, 20),
		Snack.new(:kitkat, 15),
		Snack.new(:Snickers, 25),
		Snack.new(:Soda, 5)
	]

	def self.random
	SNACKS.sample
    end	
end

#puts Snackbar::SNACKS
# snack = Snackbar.random
# puts "Enjoy your #{snack.name}! (#{snack.carbs} carbs)"