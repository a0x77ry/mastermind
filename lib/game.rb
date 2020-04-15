# frozen_string_literal: true

# A game class for Mastermind
class Game
  require_relative 'board'

  attr_accessor :player, :ai_player, :code

  def initialize(player, ai_player)
    self.player = player
    self.ai_player = ai_player
    @board = Board.new
    self.code = random_code
  end

  def guess_input
    guess = ''
    until valid_code?(guess)
      puts "\nGuess the secret code with a four letter string. "\
           "Example : gbrw \n"
      guess = gets.chomp.downcase
    end

    guess
  end

  def next_round
    puts "\nAvailabe colors are:\n\n"
    Board.colors.each { |k, v| puts "Color: #{v}, code letter: #{k}\n" }
    guess = guess_input

    exit if guess == 'exit'

    evaluate_guess(guess, code)
  end

  def valid_code?(code)
    return true if code == 'exit'
    return false unless code.split('').length == 4

    code.split('').each do |l|
      return false unless Board.colors.keys.include?(l.to_sym)
    end
    true
  end

  def find_matching_colors(guess, code)
    matching_colors = []
    guess_letters = guess.split('')
    code_letters = code.split('')

    guess_letters.each do |guess_letter|
      code_letters.each do |code_letter|
        matching_colors << code_letter if guess_letter == code_letter
      end
    end

    matching_colors
  end

  def evaluate_guess(guess, code)
    matching_positions = 0
    4.times { |i| matching_positions += 1 if guess[i] == code[i] }
    matching_colors = find_matching_colors(guess, code)

    matching_colors_number = matching_colors.uniq.length
    { colors: matching_colors_number, positions: matching_positions }
  end

  private

  def random_code
    rand_code = ''
    until valid_code?(rand_code)
      rand_col = Board.colors.keys.sample.to_s
      rand_code += rand_col unless rand_code.include?(rand_col)
    end
    rand_code
  end
end
