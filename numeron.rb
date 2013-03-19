#!/usr/bin/env ruby

require_relative 'lib/numeron'

game = Numeron::Game.new
player = Numeron::Player.new(game, [1, 2, 3])

loop do
  begin 
    puts "Call your numbers (%d digits): " % game.secret_length
    call_str = gets.chomp
    unless /^\d+$/ =~ call_str
      puts "[Error] You should input digits"
      redo
    end
    numbers = call_str.chars.map(&:to_i)
    unless game.possible_secrets.include?(numbers)
      puts "[Error] %s is not acceptable call" % numbers.join 
      redo
    end
  end 
  eat, bite = player.judge(numbers)
  puts "%s: %d eat, %d bite" % [numbers.join, eat, bite]

  if player.finish?(numbers)
    break
  end
end
