require_relative 'ships'

# Игровое поле
class Field
  attr_accessor :field

  def initialize(x, y)
    @field = Array.new(y) { Array.new(x) }
    @@letters = ('A'..'J').to_a
  end

  def print_field(ai = false)
    print_letters
    puts
    i = 1
    field.each do |line|
      print format('%2i', i)
      print_line(line, ai)
      puts
      i += 1
    end
  end

  def add_ship(ship)
    ship.coordinates.each do |coord|
      @field[coord.x - 1][coord.y - 1] = ship
    end
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

  def cell_contains_ship?(x, y)
    field[x][y] if field[x][y] != 0
  end

  def self.letters
    @@letters
  end

  def print_letters
    print ' '
    @@letters.each { |i| print format('%3s', i) }
  end

  def print_line(line, ai = false)
    line.each do |cell|
      ai ? print_symbol_for_ai(cell) : print_symbol(cell)
    end
  end

  def print_symbol(c)
    case c
    when nil
      print ' . '.white.on.blue
    when 1
      print ' X '.bold.red.on.blue
    when 0
      print ' + '.bold.white.on.blue
    else
      print ' O '.white.on.blue
    end
  end

  def print_symbol_for_ai(c)
    case c
    when nil
      print ' . '.white.on.blue
    when 1
      print ' X '.bold.red.on.blue
    when 0
      print ' + '.bold.white.on.blue
    else
      print ' . '.white.on.blue
    end
  end
end
