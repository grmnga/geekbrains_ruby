require_relative 'game'

def get_y(string)
  if Game.letters.include?(string[0].upcase)
    Game.letters.find_index(string[0].upcase)
  end
end

def get_x(string)
  if (1..10).include?(string[1,2].to_i)
    string[1,2].to_i - 1
  end
end

def get_coors(string)
  y = get_y(string)
  x = get_x(string)
  unless x && y
    puts 'Неправильное значение!'
    return
  end
  [x, y]
end

game = Game.new
puts 'start new game'
game.fill_the_field

Ship.info
game.print_field

loop do
  puts 'Введите координаты для выстрела (A1..J10)'
  target = gets.chomp
  next unless (x, y = get_coors(target))
  if Shot.shots_coords.any? { |shot_c| shot_c == Coord.new(x, y) }
    puts 'Такой выстрел уже был!'
    next
  end
  game.make_shot(x, y)
  game.print_field
  break if Ship.total_ships == 0
end
