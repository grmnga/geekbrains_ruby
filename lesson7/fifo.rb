require_relative 'fifolike'

class Fifo
  include FifoLike
end

test = Fifo.new

10.times { |i| test.add_to_fifo(i) }
p test.fifo

10.times do
  p test.take_from_fifo
  p test.fifo
end
