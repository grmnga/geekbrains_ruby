# Класс кораблика
class Ship
  MAX_SHIPS_NUMBER = 10
  ONE_DECK_NUMBER = 4
  TWO_DECK_NUMBER = 3
  THREE_DECK_NUMBER = 2
  FOUR_DECK_NUMBER = 1
  MIN_DECKS = 1
  MAX_DECKS = 4
  @@total_ships = 0
  @@ships = {}
  @@ship_list = []

  attr_accessor :damaged_decks
  attr_reader :size, :coordinates

  def ships
    @@ships
  end

  def initialize(decks)
    self.size = decks
    self.damaged_decks = 0
    @coordinates = []
  end

  def add_to_ship_list
    total_ships_up
    add_ships(size)
    ship_list_push(self)
  end

  def ship_list_push(val)
    @@ship_list.push(val)
  end

  def add_coord(new_value)
    @coordinates.push(new_value)
  end

  def print_coords
    coordinates.each { |item| print "(#{item.x}, #{item.y})" }
    puts
  end

  class << self
    def how_many(decks)
      [ONE_DECK_NUMBER, TWO_DECK_NUMBER, THREE_DECK_NUMBER, FOUR_DECK_NUMBER][decks - 1]
    end

    def how_many_now(ship_object)
      puts "Количество корабликов с #{ship_object.size} палубами - #{@@ships[ship_object.size]}"
    end

    def ship_list
      @@ship_list
    end

    def info
      puts "Всего корабликов (@@total_ships) = #{@@total_ships}"
      puts "Хэш корабликов (@@ships): #{@@ships}"
      puts
    end
  end

  private

  def size=(size)
    raise 'Неверное количество палуб' unless (1..4).cover?(size)
    @size = size
  end

  def total_ships_up
    @@total_ships += 1
    if @@total_ships > MAX_SHIPS_NUMBER
      raise 'Количество корабликов превышает максимально допустимое!'
    end
  end

  def add_ships(decks)
    if ships.key?(decks)
      @@ships[decks] += 1
      if @@ships[decks] > Ship.how_many(decks)
        raise "Превышено количество корабликов с количеством палуб #{decks}"
      end
    else
      @@ships[decks] = 1
    end
  end
end
