require 'colorize'
require_relative 'story'

class Game

  attr_reader :name,:total_score,:top_scores

  def initialize
    @maingame = Story.new
    @total_score = 0
  end

  def instructions
  puts ""
  puts "Welcome to the game of".center(80)

  File.open("forks/instructions.txt", "r").each_line { |file| puts file }
  puts ""
  puts "~~~~ A Choose Your Own Adventure Game ~~~~".center(80)
  puts "\nThis is a game where you choose what happens next in the story. It all depends on the choices you make. How does the story end? Only you can find out! And the best part is that you can start over and go ahead until you've had not one but many incredibly daring experiences!\n\n"
  puts "Each step of the way you'll pick which path you take by typing the corresponding number and pressing Enter.\n\n"
  puts "To get started, type your name."
  end

  def get_user_name
    @name = gets.chomp.capitalize
  end

  def load_next(id)
    item = @maingame.get_fork(id)
    while item.finish == "FALSE"
      clear_screen
      puts item.story.split(/\\n/)
      route = Integer(gets)
      until route == 1 || route == 2
        puts "Please enter a 1 or 2."
        route = Integer(gets)
      end
      next_fork = item.path1 if route == 1
      next_fork = item.path2 if route == 2
      item = @maingame.get_fork(next_fork)
      @total_score += item.score.to_i
    end
    clear_screen
    puts item.story.split(/\\n/)
    game_over
  end

  def clear_screen
    puts "\e[H\e[2J"
  end

  def game_over
    puts "   ____                         ___                 _
    / ___| __ _ _ __ ___   ___   / _ \\__   _____ _ __| |
   | |  _ / _` | '_ ` _ \\ / _ \\ | | | \\ \\ / / _ \\ '__| |
   | |_| | (_| | | | | | |  __/ | |_| |\\ V /  __/ |  |_|
    \\____|\\__,_|_| |_| |_|\\___|  \\___/  \\_/ \\___|_|  (_)"

    puts "You scored #{@total_score} points #{@name.chomp}!".upcase.colorize(:green).center(70)
    add_to_high_scores
    show_high_scores
  end

  def get_top_scores
    #get all existing scores from csv file
    @top_scores = {}
    CSV.foreach("scores.csv", :headers => false) do |row|
      @top_scores[row[0].to_i] = {:id => row[0].to_i,:score => row[1].to_i,:name => row[2],:date => row[3].to_s}
    end
  end

  def add_to_high_scores
    get_top_scores
    if @top_scores.length > 0 #if there are 1 or more high scores
      lowest_score = @top_scores.values.min_by {|v| v[:score]}
      low_score = lowest_score[:score].to_i
    else
      low_score = 0  #if there are no high scores
    end
    if @total_score > low_score #if score should be in top ten
      if @top_scores.length < 10
        @top_scores[@top_scores.length + 1] = {:id => @top_scores.length + 1,:score => @total_score,:name => @name,:date => Date.today.to_s}
      else
        @top_scores.delete(lowest_score[:id]) #delete lowest score
        @top_scores[lowest_score[:id]] = {:id => lowest_score[:id],:score => @total_score,:name => @name,:date => Date.today.to_s} #update with new score
      end
    end
    #rewrite the file
    CSV.open("scores.csv","w") do |csv|
      @top_scores.each do |k,v|
      csv << [v[:id],v[:score],v[:name],v[:date]]
      end
    end
  end

  def show_high_scores
    puts "\n~~~Here are the top scores!~~~\n".upcase.center(80).colorize(:red)
    @top_scores = @top_scores.sort_by { |k, v| v[:score] }.reverse
    @top_scores.each do |key,value|
      puts "#{value[:name].colorize(:yellow)} scored #{value[:score].to_s.colorize(:yellow)} points on #{value[:date]}."
    end
  end

end