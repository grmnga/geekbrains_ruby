require_relative 'ship'
require_relative 'game'

# 4.times do
#   ship = Ship.new(1)
#   Ship.how_many_now(ship)
#   Ship.info
# end
#
# 3.times do
#   ship = Ship.new(2)
#   Ship.how_many_now(ship)
#   Ship.info
# end

game = Game.new
# ship = game.create_ship(rand(10) + 1, rand(10) + 1, 4)
# ship.print_coords
# Ship.info
puts 'start new game'
game.fill_the_field

Ship.info
game.print_field
#game.field.each { |item| p item }

loop do
  puts 'Введите Х для выстрела:'
  x = gets.to_i
  puts 'Введите У для выстрела:'
  y = gets.to_i
  if Shot.shots_coords.any? { |shot_c| shot_c == Coord.new(x, y) }
    puts 'Такой выстрел уже был!'
    next
  end
  game.make_shot(x, y)
  game.print_field
  break if Ship.total_ships == 0
end
