# rubocop:disable Style/For

# rubocop:disable Style/RedundantSelf

# rubocop:disable Metrics/CyclomaticComplexity

# rubocop:disable Metrics/MethodLength

# rubocop:disable Metrics/PerceivedComplexity

# rubocop:disable Style/GuardClause

# rubocop:disable Style/MultipleComparison

# rubocop:disable Style/IdenticalConditionalBranches

# rubocop:disable Style/NilComparison

# rubocop:disable Metrics/ModuleLength

module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in self
      yield(i)
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?
    
    arr = self.to_a
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

    self.my_each do |element|
      result = yield(element)
      new_arr.push(element) if result
    end
    new_arr
  end

  def my_all?(parameter = false)
    if block_given?
      for item in self
        return false unless yield(item)
      end
      return true
    end

    if !block_given? && parameter == false
      for item in self
        return false if item == false || item == nil
      end
      return true
    end

    if parameter && parameter.class == Class
      for item in self
        return false unless item.is_a?(parameter)
      end
      true
    elsif parameter && parameter.class == Regexp
      for item in self
        return false unless item.match(parameter)
      end
      true
    else
      for item in self
        return false unless item == parameter
      end
      true
    end
  end

  def my_any?(parameter = false)
    if block_given?
      for item in self
        return true if yield(item)
      end
      return false
    end

    if !block_given? && parameter == false
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
    if block_given? && parameter == false
      for item in self
        return true unless yield(item)
      end
      return false
    end
    
    if !block_given? && parameter == false
      for item in self
        return false unless item == false || item == nil
      end
      return true
    end

    if parameter && parameter.class == Class
      for item in self
        return false if item.is_a?(parameter)
      end
      return true
    elsif parameter && parameter.class == Regexp
      for item in self
        return false if item.match(parameter)
      end
      return true
    elsif parameter
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
        result += 1 if yield(item) == true
      end
      return result
    elsif !block_given? && parameter == false
      return self.length
    end

    if parameter
      for item in self
        result += 1 if item == parameter
      end
      return result
    end
  end

  def my_map(my_proc = false)
    new_arr = []
    return to_enum(:my_map) unless block_given?

    for item in self
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
    return new_arr
  end

  def my_inject(a = false, b = false)
    if !block_given? && a && a.class != Symbol && b == false
      return
    end

    if !block_given? && a == false
      raise LocalJumpError
    end

    arr = self.to_a

    if !block_given? && a.class == Symbol
      i = 0
      accumulator = arr[0]
      while i < arr.length - 1
        accumulator = accumulator.send(a, arr[i + 1])
        i += 1
      end
      return accumulator
    end

    if !block_given? && a && b.class == Symbol
      i = 0
      accumulator = arr[0]
      while i < arr.length - 1
        accumulator = accumulator.send(b, arr[i + 1])
        i += 1
      end
      return accumulator + a
    end

    accumulator = arr[0]
    i = 0

    if block_given?
      while i < arr.length - 1
        accumulator = yield(accumulator, arr[i + 1])
        i += 1
      end
      accumulator *= a if a && a.class != Symbol
      return accumulator
    end
  end

end

def multiply_els(arr)
  arr.my_inject do |a, b|
    a * b
  end
end

# rubocop:enable Style/For

# rubocop:enable Style/RedundantSelf

# rubocop:enable Metrics/CyclomaticComplexity

# rubocop:enable Metrics/MethodLength

# rubocop:enable Metrics/PerceivedComplexity

# rubocop:enable Style/GuardClause

# rubocop:enable Style/MultipleComparison

# rubocop:enable Style/IdenticalConditionalBranches

# rubocop:enable Style/NilComparison

# rubocop:enable Metrics/ModuleLength

# -------------------------------------------------------TEST----------------------------------------------------------------

#my_each

# numbers = [2,4,7,9,1]

# numbers.my_each {|number| puts number}

#my_each_with_index

# fruits = ["apple", "banana", "strawberry", "pineapple"]

# p (fruits.each_with_index { |fruit, index| puts fruit if index.even? })

# p ((0..5).each_with_index { |el, i| puts el, i })

# puts [8,8].my_each_with_index {|x, i| puts "#{x}, #{i}"}

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

# puts [1, false].my_all?

#puts numbers.my_all?(Integer)

#puts numbers2.my_all?(Integer)

# puts numbers2.my_all?(Numeric)

# puts %w[ant tee cat].my_all?(/t/)

# puts %w[an tee cat].my_all?(/t/)

# puts %w[t a t].my_all?("t")

#my_any

# numbers = [3, 15, 9, -72, 33]

# numbers2 = [1, 2i, 3.14]

# booleans = [nil, nil, false]

# puts numbers.my_any? {|number| number > 34}

# puts booleans.my_any?

# puts [false, false].my_any?

# puts numbers.my_any?(Integer){|number| number > 34}

# puts numbers2.my_any?(Numeric)

# puts [1, 2].my_any?(String)

# puts %w[ant bear cat].my_any?(/t/)

# puts %w[an bear ca].my_any?(/t/)

# puts %w[t t t].my_any?("t")

# puts %w[a b c].my_any?("t")

# puts ["bird", "dog"].my_any?('cat')

#my_none

# numbers = [3, 15, 9, -72, 33]

# numbers2 = [2, 2i, 3.14]

# booleans = [nil, nil, false]

# puts numbers.my_none? {|number| number > 34}

# puts booleans.my_none?

# puts [false, false].my_none?

# puts [1, 2].my_none?(String)

# puts (1..3).my_none?{|x| x > 4}

# puts numbers.my_none?(Integer)

# puts numbers2.my_none?(Numeric)

# puts %w[ant bear ca].my_none?(/t/)

# puts %w[a b c].my_none?("t")

#my_count

# numbers = [3, 15, 3, 9, 3, -72, 33, 3]

# puts numbers.my_count

# puts numbers.my_count{|number| number < -71}

# puts numbers.my_count(3)

# p (1..3).my_count{|x| x >= 2}

#my_map

# array = [3, 15, 9, -72, 33]

# my_proc = Proc.new{|i| i + 1}

# p array.my_map {|n| n % 8}

# puts array.my_map(my_proc) {|n| n % 8}

# p array.my_map {|n| n % 8}

# p array.my_map(&my_proc)

# p array.my_map(&:class)

#my_inject

array = [3, 15, 9, -72, 33]

# p (array.my_inject do |a, b|	
#     a + b	
# end)

# puts array.my_inject{}

# p (array.inject { |product, n| product * n })

# puts (5..10).my_inject{ }

# p multiply_els([2,4,5])

# longest = %w{ cat sheep bear }.my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest

# puts array.inject(:&)

# puts (5..10).my_inject

# sum = ->(x, y) { x + y }

# puts [1,2,3,4].my_inject(&sum)

# puts (5..10).my_inject(2, :+)
