class Movie
	def initialize(title, rank=0)
		@title = title.capitalize
		@rank = rank
		#puts "Created a movie object with title #{@title} and rank of #{@rank}."
	end

	def to_s
		"#{@title} has a rank of #{@rank}."
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

	attr_accessor :title, :rank

end