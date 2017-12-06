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

  def make_shot(x, y)
    if Shot.shots_coords.any? { |coord| coord == Coord.new(x, y) }
      puts 'Такой выстрел уже был!'
      return
    else
      shot = Shot.new(Coord.new(x, y))
      if field[x][y] && field[x][y] != 1
        ship = field[x][y]
        shot.hit = true
        ship.damaged_decks += 1
        field[x][y] = 1
        ship_state(ship)
        return
      end
      puts 'Мимо!'
    end
  end

  def ship_state(ship)
    if ship.killed?
      ship.total_ships_down
      puts 'Убит!'
    else
      puts 'Попадание!'
    end
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
