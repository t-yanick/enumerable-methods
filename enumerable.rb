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
    return to_enum(:my_each_with_index) unless block_given?

    for num in self
      index = self.find_index(num)
      yield(num, index)
    end
    self
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

  def my_all?(parameter = false)
    for item in self
      if block_given?
        return yield(item)? true : false

      elsif !block_given? && parameter == false
        return item == false || item == nil ? false : true
      end
    end

    if parameter && parameter.class == Class
      for item in self
        return false unless item.is_a?(parameter)
      end
      return true
    elsif parameter && parameter.class == Regexp
      for item in self
        return false unless item.match(parameter)
      end
      return true
    else
      for item in self
        return false unless item == parameter
      end
      return true
    end
  end

  def my_any?(parameter = false)
    if block_given?
      for item in self
        return true if yield(item)
      end
      return false
    end

    if !block_given?
      for item in self
        return true unless item == false || item == nil
      end
      return false
    end

    if parameter && parameter.class == Class
      for item in self
        return true if item.is_a?(parameter)
      end
      return false
    elsif parameter && parameter.class == Regexp
      for item in self
        return true if item.match(parameter)
      end
      return false
    else
      for item in self
        return true if item == parameter
      end
      return false
    end
  end

  def my_none?(parameter = false)
    for item in self
      if block_given?
        return yield(item)? true : false

      elsif !block_given? && parameter == false
        return item == false || item == nil ? false : true
      end
    end

    if parameter && parameter.class == Class
      for item in self
        return false unless item.is_a?(parameter)
      end
      return true
    elsif parameter && parameter.class == Regexp
      for item in self
        return false if item.match(parameter)
      end
      return true
    else parameter
      for item in self
        return false if item == parameter
      end
      return true
    end
  end

  def my_count(parameter = false)
    result = 0
    if block_given? && parameter == false
      for item in self
        if yield(item) == true
          result += 1
        end
      end
      return result
    elsif !block_given? && parameter == false
      return self.length
    end

    if parameter
      for item in self
        if item == parameter
          result += 1
        end
      end
      return result
    end
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

#my_each

# numbers = [2,4,7,9,1]
# numbers.my_each {|number| puts number}

#my_each_with_index

# fruits = ["apple", "banana", "strawberry", "pineapple"]

# p (fruits.my_each_with_index { |fruit, index| puts fruit if index.even? })

# p ((0..5).my_each_with_index { |el, i| puts el, i })


#my_select

# numbers = [2,4,7,9,1]	
# p (numbers.my_select {|number| number != 4})	

# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']	
# p (friends.my_select { |friend| friend != "Brian" })	

#my_all

# numbers = [3, 15, 9, -72, 33]

# numbers2 = [1, 2i, 3.14]

# booleans = [true, true, true]

# puts numbers.my_all? {|number| number < 34}

# puts numbers.my_all?

# puts numbers.my_all?(Integer)

# puts numbers2.my_all?(Numeric)

# puts %w[ant tee cat].my_all?(/t/)

# puts %w[t t t].my_all?("t")


#my_any

# numbers = [3, 15, 9, -72, 33]

# numbers2 = [1, 2i, 3.14]

# booleans = [nil, nil, false]

# puts numbers.my_any? {|number| number > 34}

# puts booleans.my_any?

# puts numbers.my_any?(Integer)

# puts numbers2.my_any?(Numeric)

# puts %w[ant bear cat].my_any?(/t/)

# puts %w[t t t].my_any?("t")

#my_none

# numbers = [3, 15, 9, -72, 33]

# numbers2 = [2, 2i, 3.14]

# booleans = [nil, nil, true]

# puts numbers.my_none? {|number| number > 34}

# puts booleans.my_none?

# puts numbers.none?(Integer)

# puts numbers2.my_none?(Numeric)

# puts %w[ant bear ca].my_none?(/t/)

# puts %w[a b c].my_none?("t")

#my_count

# numbers = [3, 15, 3, 9, 3, -72, 33, 3]	

# puts numbers.my_count

# puts numbers.my_count{|number| number < -71}	

# puts numbers.my_count(3)

#my_map

array = [3, 15, 9, -72, 33]

p array.my_map {|n| n % 8}	


#my_inject

# p (array.my_inject do |a, b|	
#     a + b	
# end)	

# p multiply_els([2,4,5])