class Movie
	def initialize(title, rank=0)
		@title = title.capitalize
		@rank = rank
		#puts "Created a movie object with title #{@title} and rank of #{@rank}."
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

	attr_accessor :title, :rank

end