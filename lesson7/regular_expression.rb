def task1(str)
  str =~ /\A\[2, 2\]\z/
end

def task2(str)
  str =~ /\A\[\d, \d\]\z/
end

def task3(str)
  str =~ /\A\[([1-9]|10), ([1-9]|10)\]\z/
end

def task4(str)
  str =~ /\A\[[А-К]([1-9]|10)\]\z/
end

tasks = %i(task1 task2 task3 task4)

loop do
  puts 'Выберите задание:
    1 - Проверить регулярное выражение для строки вида [2, 2]
    2 - В квадратных скобках могут стоять любые две цифры
    3 - В квадратных скобках могут стоять два числа от 1 до 10
    4 - регулярное выражение для строки вида “[Ж2]”, где буквы
        могут быть использованы из диапазона от А до К, а числа от 1 до 10.
       (!!!Работает не везде!!!)
    0 - Выход'
  choice = gets.to_i
  break if choice.zero?
  loop do
    puts 'Введите строку для проверки (0 - выход):'
    string = gets.chomp
    break if string =~ /\A0\z/
    string.encode!(Encoding::UTF_8)
    method = tasks[choice - 1]
    if send(method, string)
      p true
    else
      p false
    end
  end
end