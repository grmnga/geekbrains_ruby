require_relative 'coord'
require_relative 'ship'
require_relative 'shot'

# Здесь создаются кораблики
class Game

  def initialize
    @field = Array.new(10){Array.new(10)}
    @letters = ('А'..'К').to_a
    @letters.delete_at(9)
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

  def field
    @field
  end

  def print_field
    print_letters
    i = 1
    field.each do |line|
      print format("%2i", i)
      print_line(line)
      i += 1
    end
  end

  def print_letters
    print ' '
    @letters.each { |i| print format("%3s", i)}
    puts
  end

  def print_line(line)
    line.each do |cell|
      print_symbol(cell)
    end
    puts
  end

  def print_symbol(c)
    case c
      when nil
        print ' . '
      when 0
        print ' O '
      when 1
        print ' X '
      else
        raise ' o_____O ?'
    end
  end

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

  private

  def create_ship(size)
    loop do
      ship = Ship.new(size)
      fill_ship_coords(ship)
      p touch_another_ship?(ship)
      next if out_of_field?(ship) || touch_another_ship?(ship)
      ship.add_to_ship_list
      return ship
    end
  end

  def fill_ship_coords(ship)
    i = 0
    x, y = get_rand_xy
    # false - кораблик будет расположен вдоль оси X
    # true - кораблик будет расположен вдоль оси Y
    direction = [true, false].sample(1)[0]
    loop do
      ship.add_coord(create_coord(x, y, direction, i))
      break if i == ship.size - 1
      i += 1
    end
  end

  def get_rand_xy
    [rand(10) + 1, rand(10) + 1]
  end

  def create_coord(x, y, direction, i)
    x += i * (direction ? 0 : 1)
    y += i * (direction ? 1 : 0)
    coord = Coord.new(x, y)
  end

  def out_of_field?(ship)
    ship.coordinates.last.x > 10 || ship.coordinates.last.y > 10
  end

  def add_to_field(ship)
    ship.coordinates.each do |coord|
      @field[coord.x - 1][coord.y - 1] = 0
    end
  end

  def anybody_here?(x, y)
    if (0..9).include?(x) && (0..9).include?(y)
      return true if @field[x][y]
    end
  end
end
