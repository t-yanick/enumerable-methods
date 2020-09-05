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

      elsif parameter == false
        return false unless item

      elsif parameter.class == Class
        return false unless item.is_a?(parameter)

      elsif parameter.class == Regexp
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

      elsif parameter == false
        return false if item

      elsif parameter.class == Class
        return false if item.is_a?(parameter)

      elsif parameter.class == Regexp
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

      elsif block_given? && arg_one && arg_two == false
        accumulator = yield(accumulator, arr[i + 1])

      elsif !block_given? && arg_one.class == Symbol
        accumulator = accumulator.send(arg_one, arr[i + 1])

      elsif !block_given? && arg_one && arg_two.class == Symbol
        accumulator = accumulator.send(arg_two, arr[i + 1])
      end
      i += 1
    end
    accumulator = yield(accumulator, arg_one) if arg_one && arg_two == false
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
