#!/usr/bin/env ruby

# frozen_string_literal: true

require_relative '../lib/board.rb'
require_relative '../lib/game.rb'
require_relative '../lib/player.rb'
require_relative '../lib/ai.rb'

puts "Welcome to Matermind\n"
cmaker = ''
until [1, 2].include?(cmaker)
  puts "Who you want to be the codemaker?\n"
  puts "[1] Human\n"
  puts "[2] Computer\n"
  cmaker = gets.chomp.to_i
end

if cmaker == 1
  codemaker = Player.new('Human Player')
  codebreaker = AI.new('Computer')
else
  codebreaker = Player.new('Human Player')
  codemaker = AI.new('Computer')
end
game = Game.new(codebreaker, codemaker)

win = false

12.times do
  results = game.next_round

  if results[:colors] == 4 && results[:positions] == 4
    puts "#{codebreaker.name} broke the code!"
    win = true
    break
  else
    puts "Correct colors guessed: #{results[:colors]}\n"
    puts "Correct colors at the correct positions: #{results[:positions]}\n"
  end
end

puts "#{codebreaker.name} lose!" unless win == true
