#!/usr/bin/env ruby

require_relative 'lib/numeron'

game = Numeron::Game.new
player = Numeron::Player.new(game, [1, 2, 3])

loop do
  puts "Call your numbers:"
  while call_str = gets.chomp
    # TODO validate call_str: length, is number?, number duplication
    if /^\d{#{game.secret_length}}$/ =~ call_str
      break
    else
      puts "[Error] please input number, 3 digit"
      puts "Call your numbers:"
    end
  end
  numbers = call_str.chars.map(&:to_i)
  eat, bite = player.judge(numbers)
  puts "%s: %d eat, %d bite" % [numbers.join, eat, bite]

  if player.finish?(numbers)
    break
  end
end
