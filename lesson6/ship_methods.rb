module ShipMethods
  private

  def create_ship(size)
    loop do
      ship = Ship.new(size)
      fill_ship_coords(ship)
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
end
