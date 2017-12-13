require_relative 'ship'

class Ships
  MAX_SHIPS_NUMBER = 10
  ONE_DECK_NUMBER = 4
  TWO_DECK_NUMBER = 3
  THREE_DECK_NUMBER = 2
  FOUR_DECK_NUMBER = 1
  MIN_DECKS = 1
  MAX_DECKS = 4

  attr_reader :total_ships, :ships, :ship_list

  def initialize
    @total_ships = 0
    @ships = {}
    @ship_list = []
  end

  def add_ship(ship)
    total_ships_up
    add_to_ships(ship.size)
    add_to_ship_list(ship)
  end

  def info
    puts "Всего корабликов = #{total_ships}"
    puts ships
    puts
  end

  def self.how_many(decks)
    [ONE_DECK_NUMBER, TWO_DECK_NUMBER, THREE_DECK_NUMBER, FOUR_DECK_NUMBER][decks - 1]
  end

  def ship_state(ship, field)
    if ship.killed?
      total_ships_down
      @ships[ship.size] -= 1
      ship.mark(field)
      return true
    end
    false
  end

  private

  def total_ships_up
    @total_ships += 1
    if total_ships > MAX_SHIPS_NUMBER
      raise 'Количество корабликов превышает максимально допустимое!'
    end
  end

  def total_ships_down
    @total_ships -= 1
    if total_ships < 0
      raise 'Количество корабликов меньше минимально допустимого!'
    end
  end

  def add_to_ship_list(val)
    @ship_list.push(val)
  end

  def add_to_ships(decks)
    if ships.key?(decks)
      @ships[decks] += 1
      if ships[decks] > Ships.how_many(decks)
        raise "Превышено количество корабликов с количеством палуб #{decks}"
      end
    else
      @ships[decks] = 1
    end
  end
end
