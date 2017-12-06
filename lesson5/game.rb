require_relative 'coord'
require_relative 'ship'
require_relative 'shot'

# Здесь создаются кораблики
class Game
  def create_ship(x, y, size)
    ship = Ship.new(size)
    # false - кораблик будет расположен вдоль оси X
    # true - кораблик будет расположен вдоль оси Y
    direction = [true, false].sample(1)[0]
    i = 0
    loop do
      ship.add_coord(create_coord(x, y, direction, i))
      break if i == size - 1
      i += 1
    end
    ship
  end

  def make_shot(x, y, ship)
    coord = Coord.new(x, y)
    if ship.coordinates.any? { |ship_c| ship_c == coord }
      shot = Shot.new(coord)
      shot.hit = true
      ship.damaged_decks += 1
      return true
    end
    false
  end

  private

  def create_coord(x, y, direction, i)
    x += i * (direction ? 0 : 1)
    y += i * (direction ? 1 : 0)
    coord = Coord.new(x, y)
  end
end
