# frozen_string_literal: true

# Board class for Mastermind
class Board
  @@colors = {
    r: 'red',
    b: 'black',
    c: 'cyan',
    y: 'yellow',
    g: 'green',
    w: 'white'
  }

  def self.colors
    @@colors
  end
end
