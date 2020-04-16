# frozen_string_literal: true

# A game class for Mastermind
class Game
  require_relative 'board'

  attr_accessor :codebreaker, :codemaker, :code

  def self.valid_code?(code)
    return true if code == 'exit'
    return false unless code.split('').length == 4

    code.split('').each do |l|
      return false unless Board.colors.keys.include?(l.to_sym)
    end
    true
  end

  def self.evaluate_guess(guess, code)
    matching_positions = 0
    4.times { |i| matching_positions += 1 if guess[i] == code[i] }
    matching_colors = find_matching_colors(guess, code)

    matching_colors_number = matching_colors.uniq.length
    { colors: matching_colors_number, positions: matching_positions }
  end

  def self.find_matching_colors(guess, code)
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

  def initialize(codebreaker, codemaker)
    self.codebreaker = codebreaker
    self.codemaker = codemaker
    @board = Board.new
    self.code = codemaker.code
  end

  def next_round
    guess = codebreaker.guess
    exit if guess == 'exit'
    puts "\nTrying guess: #{guess}."
    codebreaker.last_evaluation = Game.evaluate_guess(guess, code)
  end
end
