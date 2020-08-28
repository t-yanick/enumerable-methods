# rubocop:disable Style/For

# rubocop:disable Style/RedundantSelf

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?
    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    count = self.length - 1
    return to_enum(:my_each_with_index) unless block_given?
    for num in self
      index = self.find_index(num)
      yield(num, index)
      break if count <= 0
      count -= 1
    end
  end

  def my_select
    new_arr = []
    return to_enum(:my_select) unless block_given?
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
    return to_enum(:my_map) unless block_given?
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

# numbers = [2,4,7,9,1]
# numbers.my_each {|number| puts number}

# fruits = ["apple", "banana", "strawberry", "pineapple"]

# fruits.my_each_with_index { |fruit, index| puts fruit if index.even? }

# numbers = [2,4,7,9,1]	
# p (numbers.my_select {|number| number != 4})	

# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']	
# p (friends.my_select { |friend| friend != "Brian" })	

# numbers = [3, 15, 9, -72, 33]	
# puts numbers.my_all? {|number| number < 34}	

# numbers = [3, 15, 9, -72, 33]	
# puts numbers.my_any? {|number| number > 10}	

# numbers = [3, 15, 9, -72, 33]	
# puts numbers.my_none? {|number| number < 34}	

# numbers = [3, 15, 9, -72, 33]	
# puts numbers.my_count{|number| number > -71}	

# array = [3, 15, 9, -72, 33]	
# p array.my_map {|n| n % 8}	

# array = [3, 15, 9, -72, 33]	

# p (array.my_inject do |a, b|	
#     a + b	
# end)	

# p multiply_els([2,4,5])