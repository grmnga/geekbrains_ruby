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
