module FifoLike
  def fifo
    @fifo ||= []
  end
  def add_to_fifo(obj)
    fifo.push(obj)
  end
  def take_from_fifo
    fifo.shift
  end
  # def take_from_fifo(n = 1)
  #   n.times { fifo.shift }
  # end
end