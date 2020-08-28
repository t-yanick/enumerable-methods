# rubocop:disable Style/For

# rubocop:disable Style/RedundantSelf

module Enumerable
  def my_each
    for i in self
      yield(i) if block_given?
    end
  end

  def my_each_with_index
    count = self.length - 1
    for num in self
      index = self.find_index(num)
      yield(num, index)
      break if count <= 0

      count -= 1
    end
  end

  def my_select
    new_arr = []
    self.my_each do |element|
      result = yield(element)
      new_arr.push(element) if result == true
    end
    new_arr
  end

  def my_all?
    for item in self
      return false unless yield(item)
    end
    true
  end

  def my_any?
    for item in self
      return true if yield(item)
    end
    false
  end

  def my_none?
    for item in self
      return false if yield(item)
    end
    true
  end

  def my_count
    new_arr = []
    for item in self
      if block_given?
        if yield(item) == true
          new_arr.push(item)
          result = new_arr.length
        else
          result = 0
        end
      else
        result = self.length
      end
    end
    result
  end

  def my_map(my_proc = false)
    new_arr = []
    for item in self
      if block_given?
        new_arr.push yield(item)
      elsif my_proc
        new_arr.push my_proc.call(item)
      end
    end
    new_arr
  end

  def my_inject
    i = 0
    accumulator = self[0]
    while i < self.length - 1
      accumulator = yield(accumulator, self[i + 1])
      i += 1
    end
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject do |a, b|
    a * b
  end
end

# rubocop:enable Style/For

# rubocop:enable Style/RedundantSelf
