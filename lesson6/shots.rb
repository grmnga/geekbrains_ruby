require_relative 'shot'
require_relative 'coord'

class Shots
  attr_reader :coords

  def initialize
    @coords = []
  end

  def coords_include?(x, y)
    coords.any? { |shot| shot.coord == Coord.new(x, y) }
  end

  def add_shot(x, y)
    shot = Shot.new(x, y)
    @coords.push(shot)
    shot
  end
end
