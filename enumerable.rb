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

    unless block_given? && parameter
      my_each do |item|
        result += 1 if item == parameter
      end
      result
    end

    if block_given? && parameter == false
      my_each do |item|
        result += 1 if yield(item) == true
      end
      result
    elsif !block_given? && parameter == false
      arr.size
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
    accumulator = arr[0]
    i = 0

    while i < arr.length - 1
      if block_given? && arg_1 == false && arg_2 == false
        accumulator = yield(accumulator, arr[i + 1])

      elsif !block_given? && arg_1.class == Symbol
        accumulator = accumulator.send(arg_1, arr[i + 1])

      elsif !block_given? && arg_1 && arg_2.class == Symbol
        accumulator = accumulator.send(arg_2, arr[i + 1])
      end
      i += 1
    end
    accumulator *= arg_1 if arg_1 && arg_2 == false && arg_1.class != Symbol
    accumulator = accumulator.send(arg_2, arg_1) if arg_1 && arg_2.class == Symbol
    accumulator
  end
end

def multiply_els(arr)
  arr.my_inject do |a, b|
    a * b
  end
end
