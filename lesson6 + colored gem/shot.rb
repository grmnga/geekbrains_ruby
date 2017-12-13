require_relative 'coord'

# Класс для выстрела
class Shot
  attr_accessor :hit
  attr_reader :coord

  def initialize(x, y)
    self.coord = Coord.new(x, y)
    self.hit = false
  end

  private

  attr_writer :coord
end
