require_relative 'coord'

# Класс всех корабликов одного игрока
class Ship
  attr_accessor :damaged_decks
  attr_reader :size, :coordinates

  def initialize(decks)
    @coordinates = []
    self.size = decks
    self.damaged_decks = 0
    fill_ship_coords
  end

  def print_coords
    coordinates.each { |item| print "(#{item.x}, #{item.y})" }
    puts
  end

  def killed?
    size == damaged_decks
  end

  def mark(field)
    -1.upto(1) do |dx|
      -1.upto(1) do |dy|
        coordinates.each do |ship_coord|
          x = ship_coord.x + dx - 1
          y = ship_coord.y + dy - 1
          if (0..9).include?(x) && (0..9).include?(y)
            field.field[x][y] = 0 if field.field[x][y] != 1
          end
        end
      end
    end
  end

  def fill_ship_coords
    i = 0
    x, y = get_rand_xy
    # false - кораблик будет расположен вдоль оси X
    # true - кораблик будет расположен вдоль оси Y
    direction = [true, false].sample(1)[0]
    loop do
      add_coord(create_coord(x, y, direction, i))
      break if i == size - 1
      i += 1
    end
  end

  private

  def size=(size)
    raise 'Неверное количество палуб' unless (1..4).cover?(size)
    @size = size
  end

  def add_coord(new_value)
    @coordinates.push(new_value)
  end

  def create_coord(x, y, direction, i)
    x += i * (direction ? 0 : 1)
    y += i * (direction ? 1 : 0)
    Coord.new(x, y)
  end

  def get_rand_xy
    [rand(10) + 1, rand(10) + 1]
  end
end
