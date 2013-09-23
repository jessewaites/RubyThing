require_relative 'movie'
require_relative 'reviewer'
require_relative 'snack_bar'


class Playlist
	def initialize(name)
		@name = name
		@movies = []
	end
	
	def add_movie(movie)
		@movies << movie
	end

	
	def play(viewings=1)	
	puts "#{@name}'s playlist:"
	puts
	puts @movies.sort	
	snacks = Snackbar::SNACKS 
	puts "\nThere are #{snacks.size} snacks available in the snackbar:"
	snacks.each do |s|
		puts "-#{s.name} has #{s.carbs} carbs."
				end	

		puts
		1.upto(viewings) do |count|
	    	puts "\nViewing #{count}:"
			@movies.each do |movie|
				Reviewer.review(movie)
				snack = Snackbar.random
				movie.ate_snack(snack)			
				puts movie
				puts "--------------"
			end
		end
	end
	


	def print_stats
		puts "\n#{@name}'s Stats:"
		puts "--------------"

		@movies.sort.each do |movie|
			puts "\n#{movie.title}'s snack totals:"
			movie.each_snack do |snack|
				puts "#{snack.carbs} total #{snack.name} carbs."
			end
			puts "\n#{movie.carbs_consumed} grand total carbs."
		end	

		hits, flops = @movies.partition { |movie| movie.hit? }

		puts "\nHits:"
		puts hits.sort
		puts "\nFlops:"
		puts flops.sort
		
	end		

end 
