require_relative 'fifolike'

class Fifo
  include FifoLike
end

test = Fifo.new

10.times { |i| test.add_to_fifo(i) }
p test.fifo

5.times do |i|
  p test.take_from_fifo(i)
  p test.fifo
end
