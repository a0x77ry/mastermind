# frozen_string_literal: true

# Player class for Mastermind
class Player
  require_relative 'game'
  require_relative 'board'

  attr_accessor :name, :last_evaluation

  def initialize(name)
    self.name = name
  end

  def guess
    show_colors
    code_input("\nGuess the secret code with a four letter string. "\
                "Example : gbrw \n")
  end

  def code
    show_colors
    code_input("\nDefine a code: \n")
  end

  private

  def code_input(message)
    str = ''
    until Game.valid_code?(str)
      puts message
      str = gets.chomp.downcase
    end
    str
  end

  def show_colors
    linelength = 16
    puts "\nAvailabe colors are:\n\n"
    Board.colors.each do |k, v|
      puts "#{v.to_s.upcase.ljust(linelength / 2)}:"\
           "#{k.to_s.center(linelength / 2)}\n"
    end
  end
end
