# game class- display board and gives the code breaker feedback on guess
# code maker - sends code to board
# code breaker - send guess to board

# Need to finish feedback method on creator
# Need to finish game won method
# Need to create AI for both sides

class Board
  STARTING_GUESSES = 12
  attr_accessor :guesses
  attr_reader :creator, :breaker

  def initialize
    start_message
    @guesses = STARTING_GUESSES
    @code_length = 4
    @breaker = Breaker.new
    @creator = Creator.new
    @creator.create_code
  end

  def guess
    guess = @breaker.guess()
    if creator.is_correct? guess
      game_won
    else
      self.guesses -= 1
      creator.feedback(guess)
    end
  end

  def game_won
    puts 'Correct! You guessed correctly!'
    puts 'Play again? Y or N'
  end

  def start_message
    puts "\n\n"
    puts "\tCode is 4 digits long"
    puts "\tPossible choices 1-8"
    puts "\n\n"
  end
end

class Breaker
  def passable?(guess = [])
    return false if guess.length != 4

    guess.all? { |number| number > 0 || number < 9 }
  end

  def guess
    puts 'Guess: '
    guess = gets.chomp.split('')
    guess = guess.map { |string_value| string_value.to_i }
    while passable?(guess) == false
      puts 'Must be 4 digits long'
      puts 'Possible choices are number 1-8'
      guess = gets.chomp.split('')
      guess = guess.map { |string_value| string_value.to_i }
    end
    guess
  end
end

class Creator < Breaker
  def initialize; end

  def create_code
    @code = guess
  end

  def is_correct?(guess)
    guess == @code
  end

  def feedback(_guess)
    puts 'Here is feedback'
  end
end

board = Board.new
board.guess
