class Movie
	def initialize(title, rank=0)
		@title = title.capitalize
		@rank = rank
		@snack_carbs = Hash.new(0)
	end

	def carbs_consumed
		@snack_carbs.values.reduce(0, :+)
	end	

	def ate_snack(snack)
		@snack_carbs[snack.name] += snack.carbs
		puts "#{title} showing sold #{snack.carbs} #{snack.name} units."
		puts "#{title}'s snacks: #{@snack_carbs}"
	end	

	def to_s
		"#{@title} has a rank of #{@rank}. (#{status})"
	end	

	def thumbs_up
		@rank += 1
	end	

	def thumbs_down
		@rank -= 1
	end	

	def normalized_rank
		@rank / 10
	end	

	def hit?
		@rank >= 10
	end

	def status
		# This code does the same thing as the if/else below: hit? ? "Hit" : "Flop"
		if hit?
		 "Hit"
		else
		 "Flop" 
		end	
	end

	def <=>(other_movie)
		other_movie.rank <=> @rank
	end	

	def each_snack
		@snack_carbs.each do |name, carbs|
			snack = Snack.new(name, carbs)
			yield snack
		end	
	end		

	attr_accessor :title, :rank

end