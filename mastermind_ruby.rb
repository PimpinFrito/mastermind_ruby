# game class- display board and gives the code breaker feedback on guess
# code maker - sends code to board
# code breaker - send guess to board

# May need to create superclass for creator and breaker for guess method
# Need to finish feedback method on creator
# Need to finish game won method
# Need to create AI for both sides

class Board
  MAX_GUESSES = 3
  attr_accessor :guesses
  attr_reader :creator, :breaker

  def initialize
    start_message
    @guesses = MAX_GUESSES
    @code_length = 4
    @breaker = Breaker.new
    @creator = CreatorAI.new
    @creator.create_code
  end

  def play
    while guesses >= 0
      if guess
        game_won
        return
      end

      self.guesses -= 1
      puts "Guesses left: #{guesses}"
      puts ''
    end
    game_over
  end

  def guess
    breaker_guess = @breaker.guess
    return true if creator.correct? breaker_guess

    creator.feedback(breaker_guess)
    false
  end

  def game_over
    puts 'Game Over!'
    puts "Code was #{creator.code}"
  end

  def game_won
    puts 'Correct! You guessed correctly!'
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
    return false if guess.uniq.length != 4

    guess.all? { |number| number > 0 || number < 9 }
  end

  def guess(question = 'Guess: ') # Question variable is so I can reuse for Creator class easier
    puts question
    guess = gets.chomp.split('')
    guess = guess.map { |string_value| string_value.to_i }
    while passable?(guess) == false
      puts 'Must be 4 digits long'
      puts 'Possible choices are number 1-8'
      puts 'No duplicate numbers'
      guess = gets.chomp.split('')
      guess = guess.map { |string_value| string_value.to_i }
    end
    guess
  end
end

class Creator < Breaker
  attr_reader :code

  def create_code
    puts "You're the code creator"
    @code = guess('Enter code: ')
  end

  def correct?(guess)
    guess == @code
  end

  def feedback(_guess)
    return_feedback = ''
    _guess.each do |element|
      if @code.include? element
        if @code.index(element) == _guess.index(element)
          return_feedback.prepend('X')
        else
          return_feedback += 'O'
        end
      end
    end
    puts 'Feedback: '
    puts return_feedback
    puts ''
  end
end

class CreatorAI < Creator
  LEGAL_NUMBERS = [1, 2, 4, 5, 6, 7, 8]
  def create_code
    shuffled_numbers = LEGAL_NUMBERS.shuffle
    @code = shuffled_numbers[0, 4]
  end
end

board = Board.new
board.play
