class Group
  attr_reader :students
  include Enumerable

  def initialize
    @students = {}
    names = %w(Ivanov Petrov Sidorov Alekseeva Kazancev
              Antropov Anisimova Kuznecov Solov'ev Koshkina)
    names.each { |name| @students[name] = rand(10) }
  end

  def print_students
    @students.each { |i, key| puts "#{i} : #{key}"}
  end

  def each
    @students.each { |student| yield student }
  end
end

group = Group.new
group.print_students
puts 'Найти первого в списке посещающих кружок программирования школьника, чья фамилия
начинается на “А”.'
p group.find { |name, i| name.start_with?('A') }
puts 'Найти всех школьников, чья фамилия начинается на “А”'
p group.find_all { |name, i| name.start_with?('A') }
puts 'Найти самого преуспевающего школьника из кружка при помощи метода max.'
p group.max_by { |name, i| i }