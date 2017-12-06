require_relative 'coord'

# Класс для выстрела
class Shot
  attr_accessor :hit
  attr_reader :shots_coords, :coord
  @@shots_coords = []

  def initialize(coord)
    self.coord = coord
    @@shots_coords.push(coord)
    self.hit = false
  end

  def hit?(ship)
    if ship.coordinates.any? { |item| Coord.eql?(item, coord) }
      ship.damaged_decks += 1
      self.hit = true
    else
      self.hit = false
    end
  end

  def self.shots_coords
    @@shots_coords
  end

  private

  attr_writer :coord
end
