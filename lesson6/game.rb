require_relative 'ships'
require_relative 'shots'
require_relative 'field'

# Здесь создаются кораблики и совершаются выстрелы
class Game
  MAX_X = 10
  MAX_Y = 10

  attr_reader :player_field, :player_ships, :player_shots,
              :ai_field,     :ai_ships,     :ai_shots

  def initialize
    create_player_content
    create_ai_content
  end

  def start
    loop do
      show_info
      player_make_shot
      break if ai_ships.total_ships.zero?
      ai_make_shot
      break if player_ships.total_ships.zero?
    end
    show_info
    game_over
  end

  def game_over
    if ai_ships.total_ships.zero?
      puts 'Вы выиграли!'
    else
      puts 'Вы проиграли!'
    end
  end

  def print_fields
    puts "\t\t\tВаше поле\t\t\t\t\t\tПоле компьютера"
    player_field.print_letters
    print "\t\t"
    ai_field.print_letters
    puts
    10.times do |i|
      print format('%2i', i + 1)
      player_field.print_line(player_field.field[i])
      print "\t"
      print format('%2i', i + 1)
      ai_field.print_line(ai_field.field[i], true)
      puts
    end
  end

  def show_info
    print_fields
    puts 'У врага осталось:'
    ai_ships.info
    puts 'У вас осталось:'
    player_ships.info
  end

  private

  attr_writer :player_field, :player_ships, :player_shots,
              :ai_field,     :ai_ships,     :ai_shots

  def create_player_content
    self.player_field = Field.new(MAX_X, MAX_Y)
    self.player_ships = Ships.new
    fill_the_field(player_field, player_ships)
    self.player_shots = Shots.new
  end

  def create_ai_content
    self.ai_field = Field.new(MAX_X, MAX_Y)
    self.ai_ships = Ships.new
    fill_the_field(ai_field, ai_ships)
    self.ai_shots = Shots.new
  end

  def fill_the_field(field, ships)
    4.downto(1) do |ship_size|
      ship_number = Ships.how_many(ship_size)
      ship_number.times do
        loop do
          ship = Ship.new(ship_size)
          next if field.out_of_field?(ship) || field.touch_another_ship?(ship)
          ships.add_ship(ship)
          field.add_ship(ship)
          break
        end
      end
    end
  end

  def player_make_shot
    x, y = get_coords
    hit = player_hit?(x, y)
    return if ai_ships.total_ships.zero?
    if hit
      show_info
      player_make_shot
    end
  end

  def player_hit?(x, y)
    if ai_field.cell_contains_ship?(x, y)
      ship = ai_field.field[x][y]
      shoot_him(x, y, ai_field, player_shots)
      hit_result(ai_ships, ship, ai_field)
      return true
    else
      mishit(x, y, ai_field, player_shots)
      puts 'Мимо!'
      return
    end
  end

  def hit_result(ships, ship, field)
    if ships.ship_state(ship, field)
      puts 'Убит!'
    else
      puts 'Попадание!'
    end
  end

  def ai_make_shot
    x, y = get_random_coords
    puts "Ход компьютера: #{Field.letters[y]}#{x + 1}"
    hit = ai_hit?(x, y)
    return if player_ships.total_ships.zero?
    ai_make_shot if hit
  end

  def ai_hit?(x, y)
    if player_field.cell_contains_ship?(x, y)
      ship = player_field.field[x][y]
      shoot_him(x, y, player_field, ai_shots)
      player_ships.ship_state(ship, player_field)
      return true
    else
      mishit(x, y, player_field, ai_shots)
      return
    end
  end

  def get_random_coords
    loop do
      x = rand(10)
      y = rand(10)
      return [x, y] unless ai_shots.coords_include?(x, y)
    end
  end

  def get_coords
    loop do
      puts 'Введите координаты для выстрела (A1..J10)'
      target = gets.chomp
      x, y = check_coords(target)
      return [x, y] if x & y
    end
  end

  def check_coords(string)
    y = get_y(string)
    x = get_x(string)
    if x && y
      return [x, y] unless player_shots.coords_include?(x, y)
      puts 'Такой выстрел уже был!'
    else
      puts 'Неправильное значение!'
    end
  end

  def get_y(string)
    Field.letters.find_index(string[0].upcase) unless string.empty?
  end

  def get_x(string)
    string[1, 2].to_i - 1 if (1..10).include?(string[1, 2].to_i)
  end

  def shoot_him(x, y, field, shots)
    ship = field.field[x][y]
    ship.damaged_decks += 1
    shot = shots.add_shot(x, y)
    shot.hit = true
    field.field[x][y] = 1
  end

  def mishit(x, y, field, shots)
    shots.add_shot(x, y)
    field.field[x][y] = 0
  end
end
