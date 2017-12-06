require_relative 'coord'

# Класс для выстрела
class Shot
  attr_accessor :hit
  attr_reader :coord
  @@shots_coords = []

  def initialize(coord)
    self.coord = coord
    @@shots_coords.push(coord)
    self.hit = false
  end

  def self.shots_coords
    @@shots_coords
  end

  private

  attr_writer :coord
end
