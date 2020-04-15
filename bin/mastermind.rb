# frozen_string_literal: true

require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ai.rb'

puts 'Welcome to Matermind'
player = Player.new('Human Player')
ai_player = AI.new('Computer')
game = Game.new(player, ai_player)

12.times do
  results = game.next_round

  if results[:colors] == 4 && results[:positions] == 4
    puts 'Congratulations! You broke the code'
    break
  else
    puts "Correct colors guessed: #{results[:colors]}\n"
    puts "Correct colors at the correct positions: #{results[:positions]}\n"
  end
end
