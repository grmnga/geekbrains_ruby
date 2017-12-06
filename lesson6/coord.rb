# Класс для координат выстрелов и корабликов
class Coord
  attr_accessor :x, :y

  def initialize(x, y)
    self.x = x
    self.y = y
  end

  def ==(coord)
    [x, y] == [coord.x, coord.y]
  end
end

def to_coord(coordinates)
  if coordinates.all? { |item| (1..10).cover? item }
    return Coord.new(coordinates[0], coordinates[1]) if coordinates.size == 2
  end
  false
end
