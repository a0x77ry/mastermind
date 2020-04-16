# frozen_string_literal: true

require_relative 'player'
require_relative 'board'
require_relative 'game'

# AI class for Mastermind
class AI < Player
  require_relative 'board'

  attr_accessor :last_evaluation

  def initialize(name)
    super(name)
    @s = make_s
    @guess_str = ''
    @last_guess = 'rrbb'
  end

  # Based on the five-guess algorithm
  # https://en.wikipedia.org/wiki/Mastermind_(board_game)
  def guess
    @guess_str = @guess_str == '' ? 'rrbb' : @s.sample
    unless last_evaluation.nil?
      @s.select! do |code|
        Game.evaluate_guess(@last_guess, code) == last_evaluation
      end
      @last_guess = @guess_str
    end
    @guess_str
  end

  def code
    rand_code = ''
    until Game.valid_code?(rand_code)
      rand_col = Board.colors.keys.sample.to_s
      rand_code += rand_col unless rand_code.include?(rand_col)
    end
    rand_code
  end

  private

  def make_s
    keys = Board.colors.keys
    s = []
    keys.each do |k1|
      keys.each do |k2|
        keys.each do |k3|
          keys.each { |k4| s << "#{k1}#{k2}#{k3}#{k4}" }
        end
      end
    end
    s
  end
end
