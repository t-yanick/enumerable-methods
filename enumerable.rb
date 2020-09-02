# rubocop:disable Metrics/CyclomaticComplexity
# rubocop:disable Metrics/MethodLength
# rubocop:disable Metrics/PerceivedComplexity
# rubocop:disable Metrics/ModuleLength

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
    if block_given?
      my_each do |item|
        return false unless yield(item)
      end
      return true
    end

    if !block_given? && parameter == false
      my_each do |item|
        return false unless item
      end
      return true
    end

    if parameter && parameter.class == Class
        my_each do |item|
        return false unless item.is_a?(parameter)
        end
      return true
    end

    if parameter && parameter.class == Regexp
      my_each do |item|
        return false unless item.match(parameter)
      end
      return true
    end

    if parameter
      my_each do |item|
        return false unless item == parameter
      end
      return true
    end
  end

  def my_any?(parameter = false)
    if block_given?
      my_each do |item|
        return true if yield(item)
      end
      return false
    end

    if !block_given? && parameter == false
      my_each do |item|
        return true unless !item
      end
      return false
    end

    if parameter && parameter.class == Class
      my_each do |item|
        return true if item.is_a?(parameter)
      end
      return false
    end

    if parameter && parameter.class == Regexp
      my_each do |item|
        return true if item.match(parameter)
      end
      return false
    end

    if parameter
      my_each do |item|
        return true if item == parameter
      end
      return false
    end
  end

  def my_none?(parameter = false)
    if block_given? && parameter == false
      my_each do |item|
        return false if yield(item)
      end
      return true
    end

    if !block_given? && parameter == false
      my_each do |item|
        return false if item
      end
      return true
    end

    if parameter && parameter.class == Class
      my_each do |item|
        return false if item.is_a?(parameter)
      end
      return true
    end

    if parameter && parameter.class == Regexp
      my_each do |item|
        return false if item.match(parameter)
      end
      return true
    end

    if parameter
      my_each do |item|
        return false if item == parameter
      end
      return true
    end
  end

  def my_count(parameter = false)
    result = 0
    arr = to_a

    if block_given? && parameter == false
      my_each do |item|
        result += 1 if yield(item) == true
      end
      return result
    elsif !block_given? && parameter == false
      return arr.size
    end

    if !block_given? && parameter
      my_each do |item|
        result += 1 if item == parameter
      end
      result
    end
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

  def my_inject(arg_1 = false, arg_2 = false)
    return if !block_given? && arg_1 && arg_1.class != Symbol && arg_2 == false

    raise LocalJumpError if !block_given? && arg_1 == false

    arr = to_a

    if !block_given? && arg_1.class == Symbol
      i = 0
      accumulator = arr[0]
      while i < arr.length - 1
        accumulator = accumulator.send(arg_1, arr[i + 1])
        i += 1
      end
      return accumulator
    end

    if !block_given? && arg_1 && arg_2.class == Symbol
      i = 0
      accumulator = arr[0]
      while i < arr.length - 1
        accumulator = accumulator.send(arg_2, arr[i + 1])
        i += 1
      end
      accumulator = accumulator.send(arg_2, arg_1)
      return accumulator
    end

    accumulator = arr[0]
    i = 0

    if block_given? && arg_1 == false && arg_2 == false
      while i < arr.length - 1
        accumulator = yield(accumulator, arr[i + 1])
        i += 1
      end
      accumulator *= arg_1 if arg_1 && arg_1.class != Symbol
      accumulator
    end
  end
end

def multiply_els(arr)
  arr.my_inject do |a, b|
    a * b
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/MethodLength
# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/ModuleLength
