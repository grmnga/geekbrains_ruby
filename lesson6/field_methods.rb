# методы для поля морского боя
module FieldMethods
  attr_reader :field

  def print_field
    print_letters
    i = 1
    field.each do |line|
      print format('%2i', i)
      print_line(line)
      i += 1
    end
  end

  private

  def print_letters
    print ' '
    Game.letters.each { |i| print format('%3s', i) }
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
    when 1
      print ' X '
    when 0
      print ' + '
    else
      print ' O '
    end
  end

  def add_to_field(ship)
    ship.coordinates.each do |coord|
      @field[coord.x - 1][coord.y - 1] = ship
    end
  end
end
