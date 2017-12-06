require_relative 'coord'
require_relative 'ship'
require_relative 'shot'
require_relative 'field_methods'
require_relative 'ship_methods'

# Здесь создаются кораблики и совершаются выстрелы
class Game
  include FieldMethods
  include ShipMethods

  def initialize
    @field = Array.new(10) { Array.new(10) }
    @@letters = ('A'..'J').to_a
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
    if shots_coords_include?(x, y)
      puts 'Такой выстрел уже был!'
      return
    end
    if cell_contains_ship?(x, y)
      shoot_him(x, y)
      return
    end
    mishit(x, y)
  end

  def self.letters
    @@letters
  end

  private

  def mishit(x, y)
    Shot.new(Coord.new(x, y))
    field[x][y] = 0
    puts 'Мимо!'
  end

  def shoot_him(x, y)
    ship = field[x][y]
    ship.damaged_decks += 1
    shot = Shot.new(Coord.new(x, y))
    shot.hit = true
    field[x][y] = 1
    ship.ship_state
  end

  def shots_coords_include?(x, y)
    Shot.shots_coords.any? { |coord| coord == Coord.new(x, y) }
  end

  def cell_contains_ship?(x, y)
    field[x][y] && field[x][y] != 1
  end

  def touch_another_ship?(ship)
    -1.upto(1) do |dx|
      -1.upto(1) do |dy|
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
