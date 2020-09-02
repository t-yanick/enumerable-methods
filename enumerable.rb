# rubocop : disable Metrics/ModuleLength

# rubocop : disable Metrics/PerceivedComplexity

# rubocop : disable Metrics/CyclomaticComplexity

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i])
      i += 1
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    arr = to_a
    i = 0
    while i < arr.length
      yield(arr[i], i)
      i += 1
    end
    self
  end

  def my_select
    new_arr = []
    return to_enum(:my_select) unless block_given?

    my_each do |element|
      result = yield(element)
      new_arr.push(element) if result
    end
    new_arr
  end

  def my_all?(parameter = false)
    my_each do |item|
      if block_given?
        return false unless yield(item)

      elsif !block_given? && parameter == false
        return false unless item

      elsif parameter && parameter.class == Class
        return false unless item.is_a?(parameter)

      elsif parameter && parameter.class == Regexp
        return false unless item.match(parameter)

      elsif parameter
        return false unless item == parameter
      end
    end
    true
  end

  def my_any?(parameter = false)
    my_each do |item|
      if block_given? && parameter == false
        return true if yield(item)

      elsif !block_given? && parameter == false
        return true if item

      elsif parameter && parameter.class == Class
        return true if item.is_a?(parameter)

      elsif parameter && parameter.class == Regexp
        return true if item.match(parameter)

      elsif parameter
        return true if item == parameter
      end
    end
    false
  end

  def my_none?(parameter = false)
    my_each do |item|
      if block_given? && parameter == false
        return false if yield(item)

      elsif !block_given? && parameter == false
        return false if item

      elsif parameter && parameter.class == Class
        return false if item.is_a?(parameter)

      elsif parameter && parameter.class == Regexp
        return false if item.match(parameter)

      elsif parameter
        return false if item == parameter
      end
    end
    true
  end

  def my_count(parameter = false)
    result = 0
    arr = to_a

    my_each do |item|
      if !block_given? && parameter
        result += 1 if item == parameter

      elsif block_given? && parameter == false
        result += 1 if yield(item) == true

      end
    end
    return arr.size if !block_given? && parameter == false
    
    result
  end

  def my_map(my_proc = false)
    new_arr = []
    return to_enum(:my_map) unless block_given?

    my_each do |item|
      if block_given? && my_proc == false
        new_arr.push yield(item)
      elsif block_given? && my_proc.class == Proc
        new_arr.push my_proc.call(item)
      elsif my_proc && my_proc.class == Symbol
        new_arr.push item.my_proc
      elsif my_proc
        new_arr.push my_proc.call(item)
      end
    end
    new_arr
  end

  def my_inject(arg_one = false, arg_two = false)
    return if !block_given? && arg_one && arg_one.class != Symbol && arg_two == false

    raise LocalJumpError if !block_given? && arg_one == false

    arr = to_a
    accumulator = arr[0]
    i = 0

    while i < arr.length - 1
      if block_given? && arg_one == false && arg_two == false
        accumulator = yield(accumulator, arr[i + 1])

      elsif !block_given? && arg_one.class == Symbol
        accumulator = accumulator.send(arg_one, arr[i + 1])

      elsif !block_given? && arg_one && arg_two.class == Symbol
        accumulator = accumulator.send(arg_two, arr[i + 1])
      end
      i += 1
    end
    accumulator *= arg_one if arg_one && arg_two == false && arg_one.class != Symbol
    accumulator = accumulator.send(arg_two, arg_one) if arg_one && arg_two.class == Symbol
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject do |a, b|
    a * b
  end
end

# rubocop : enable Metrics/ModuleLength

# rubocop : enable Metrics/PerceivedComplexity

# rubocop : enable Metrics/CyclomaticComplexity

puts "---------------------------------------------TESTING DEFAULT METHODS--------------------------------------------------------------------"

#my_each

numbers = [2,4,7,9,1]

numbers.each {|number| puts number}

#my_each_with_index

fruits = ["apple", "banana", "strawberry", "pineapple"]

p (fruits.each_with_index { |fruit, index| puts fruit if index.even? })

p ((0..5).each_with_index { |el, i| puts el, i })

puts [8,8].each_with_index {|x, i| puts "#{x}, #{i}"}

#my_select

numbers = [2,4,7,9,1]

p (numbers.select {|number| number != 4})

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

p (friends.select { |friend| friend != "Brian" })

#my_all

numbers = [3, 15, 9, -72, 33]

numbers2 = [1, 2i, 3.14]

booleans = [true, true, true]

puts numbers.all? {|number| number < 34}

puts numbers.all?

puts [1, false].all?

puts numbers.all?(Integer)

puts numbers2.all?(Integer)

puts numbers2.all?(Numeric)

puts %w[ant tee cat].all?(/t/)

puts %w[an tee cat].all?(/t/)

puts %w[t a t].all?("t")

#my_any

numbers = [3, 15, 9, -72, 33]

numbers2 = [1, 2i, 3.14]

booleans = [nil, nil, false]

puts numbers.any? {|number| number > 34}

puts booleans.any?

puts [false, false].any?

puts numbers.any?(Integer){|number| number > 34}

puts numbers2.any?(Numeric)

puts [1, 2].any?(String)

puts %w[ant bear cat].any?(/t/)

puts %w[an bear ca].any?(/t/)

puts %w[t t t].any?("t")

puts %w[a b c].any?("t")

puts ["bird", "dog"].any?('cat')

#my_none

numbers = [3, 15, 9, -72, 33]

numbers2 = [2, 2i, 3.14]

booleans = [nil, nil, false]

puts numbers.none? {|number| number > 34}

puts booleans.none?

puts [false, false].none?

puts [1, 2].none?(String)

puts (1..3).none?{|x| x > 4}

puts numbers.none?(Integer)

puts numbers2.none?(Numeric)

puts %w[ant bear ca].none?(/t/)

puts %w[a b c].none?("t")

#my_count

numbers = [3, 15, 3, 9, 3, -72, 33, 3]

puts numbers.count

puts numbers.count{|number| number < -71}

puts numbers.count(3)

p (1..3).count{|x| x >= 2}

#my_map

array = [3, 15, 9, -72, 33]

my_proc = Proc.new{|i| i + 1}

p array.map {|n| n % 8}

puts array.map(my_proc) {|n| n % 8}

p array.map {|n| n % 8}

p array.map(&my_proc)

p array.map(&:class)

#my_inject

array = [3, 15, 9, -72, 33]

p (array.inject do |a, b|	
    a + b	
end)

puts array.inject{}

p (array.inject { |product, n| product * n })

puts (5..10).inject{ }

p multiply_els([2,4,5])

longest = %w{ cat sheep bear }.inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest

puts array.inject(:&)

sum = ->(x, y) { x + y }

puts [1,2,3,4].inject(&sum)

puts (5..10).inject(2, :+)

puts (5..10).inject


#--------------------------------------------------TEST----------------------------------------------------------------------------------------

puts "---------------------------------------------TESTING MY_ METHODS-------------------------------------------------------------------------"

#my_each

numbers = [2,4,7,9,1]

numbers.my_each {|number| puts number}

#my_each_with_index

fruits = ["apple", "banana", "strawberry", "pineapple"]

p (fruits.my_each_with_index { |fruit, index| puts fruit if index.even? })

p ((0..5).my_each_with_index { |el, i| puts el, i })

puts [8,8].my_each_with_index {|x, i| puts "#{x}, #{i}"}

#my_select

numbers = [2,4,7,9,1]

p (numbers.my_select {|number| number != 4})

friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']

p (friends.my_select { |friend| friend != "Brian" })

#my_all

numbers = [3, 15, 9, -72, 33]

numbers2 = [1, 2i, 3.14]

booleans = [true, true, true]

puts numbers.my_all? {|number| number < 34}

puts numbers.my_all?

puts [1, false].my_all?

puts numbers.my_all?(Integer)

puts numbers2.my_all?(Integer)

puts numbers2.my_all?(Numeric)

puts %w[ant tee cat].my_all?(/t/)

puts %w[an tee cat].my_all?(/t/)

puts %w[t a t].my_all?("t")

#my_any

numbers = [3, 15, 9, -72, 33]

numbers2 = [1, 2i, 3.14]

booleans = [nil, nil, false]

puts numbers.my_any? {|number| number > 34}

puts booleans.my_any?

puts [false, false].my_any?

puts numbers.my_any?(Integer){|number| number > 34}

puts numbers2.my_any?(Numeric)

puts [1, 2].my_any?(String)

puts %w[ant bear cat].my_any?(/t/)

puts %w[an bear ca].my_any?(/t/)

puts %w[t t t].my_any?("t")

puts %w[a b c].my_any?("t")

puts ["bird", "dog"].my_any?('cat')

#my_none

numbers = [3, 15, 9, -72, 33]

numbers2 = [2, 2i, 3.14]

booleans = [nil, nil, false]

puts numbers.my_none? {|number| number > 34}

puts booleans.my_none?

puts [false, false].my_none?

puts [1, 2].my_none?(String)

puts (1..3).my_none?{|x| x > 4}

puts numbers.my_none?(Integer)

puts numbers2.my_none?(Numeric)

puts %w[ant bear ca].my_none?(/t/)

puts %w[a b c].my_none?("t")

#my_count

numbers = [3, 15, 3, 9, 3, -72, 33, 3]

puts numbers.my_count

puts numbers.my_count{|number| number < -71}

puts numbers.my_count(3)

p (1..3).my_count{|x| x >= 2}

#my_map

array = [3, 15, 9, -72, 33]

my_proc = Proc.new{|i| i + 1}

p array.my_map {|n| n % 8}

puts array.my_map(my_proc) {|n| n % 8}

p array.my_map {|n| n % 8}

p array.my_map(&my_proc)

p array.my_map(&:class)

#my_inject

array = [3, 15, 9, -72, 33]

p (array.my_inject do |a, b|	
    a + b	
end)

puts array.my_inject{}

p (array.my_inject { |product, n| product * n })

puts (5..10).my_inject{ }

p multiply_els([2,4,5])

longest = %w{ cat sheep bear }.my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest

puts array.my_inject(:&)

sum = ->(x, y) { x + y }

puts [1,2,3,4].my_inject(&sum)

puts (5..10).my_inject(2, :+)

puts (5..10).my_inject
