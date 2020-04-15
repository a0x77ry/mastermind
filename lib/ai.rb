# frozen_string_literal: true

require_relative 'player'

# AI class for Mastermind
class AI < Player
  require_relative 'board'

  def initialize(name)
    super(name)
  end

  def random_code
    random_code = ''
    4.times { random_code += Board.colors.keys.sample.to_s }
    random_code
  end
end
