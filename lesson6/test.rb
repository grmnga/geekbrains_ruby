arr = Array.new(10){Array.new(10)}


class Test

  @@field = Array.new(10){Array.new(10)}

  def touch_another_ship?
    (-1).upto(1) do |dx|
      (-1).upto(1) do |dy|
        arr = [1, 2, 3, 4]
        arr.each do |i|
          p @@field[i + dx - 1][i + dy - 1]
        end
      end
    end
  end
end

test = Test.new
test.touch_another_ship?
