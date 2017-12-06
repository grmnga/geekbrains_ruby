module FieldMethods
  def print_field
    print_letters
    i = 1
    field.each do |line|
      print format("%2i", i)
      print_line(line)
      i += 1
    end
  end

  private

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

  def add_to_field(ship)
    ship.coordinates.each do |coord|
      @field[coord.x - 1][coord.y - 1] = 0
    end
  end

  def field
    @field
  end
end