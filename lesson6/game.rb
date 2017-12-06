require_relative 'coord'
require_relative 'ship'
require_relative 'shot'
require_relative 'field_methods'
require_relative 'ship_methods'

# Здесь создаются кораблики
class Game
  include FieldMethods
  include ShipMethods

  def initialize
    @field = Array.new(10){Array.new(10)}
    @letters = ('A'..'J').to_a
  end

  def fill_the_field
    4.downto(1) do |ship_size|
      ship_number = Ship.how_many(ship_size)
      ship_number.times do
        ship = create_ship(ship_size)
        add_to_field(ship)
      end
    end
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

  def touch_another_ship?(ship)
    (-1).upto(1) do |dx|
      (-1).upto(1) do |dy|
        ship.coordinates.each do |ship_coord|
          x = ship_coord.x + dx - 1
          y = ship_coord.y + dy - 1
          return true if anybody_here?(x, y)
        end
      end
    end
    false
  end

  def out_of_field?(ship)
    ship.coordinates.last.x > 10 || ship.coordinates.last.y > 10
  end

  def anybody_here?(x, y)
    if (0..9).include?(x) && (0..9).include?(y)
      return true if @field[x][y]
    end
  end


end
