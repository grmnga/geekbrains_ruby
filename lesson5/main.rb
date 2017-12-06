require_relative 'ship'
require_relative 'game'

4.times do
  ship = Ship.new(1)
  Ship.how_many_now(ship)
  Ship.info
end

3.times do
  ship = Ship.new(2)
  Ship.how_many_now(ship)
  Ship.info
end

game = Game.new
ship = game.create_ship(1, 2, 4)
ship.print_coords
Ship.info

loop do
  puts 'Введите Х для выстрела:'
  x = gets.to_i
  puts 'Введите У для выстрела:'
  y = gets.to_i
  if Shot.shots_coords.any? { |shot_c| shot_c == Coord.new(x, y) }
    puts 'Такой выстрел уже был!'
    next
  end
  if game.make_shot(x, y, ship)
    puts 'Попадание!'
  else
    puts 'Мимо!'
  end
  break if ship.damaged_decks == ship.size
end
