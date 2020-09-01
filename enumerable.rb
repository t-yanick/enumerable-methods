# rubocop:disable Style/For

# rubocop:disable Style/RedundantSelf

# rubocop:disable Metrics/CyclomaticComplexity

# rubocop:disable Metrics/MethodLength

# rubocop:disable Metrics/PerceivedComplexity

# rubocop:disable Style/GuardClause

# rubocop:disable Style/MultipleComparison

# rubocop:disable Style/IdenticalConditionalBranches

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
        return yield(item) ? true : false

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
      false
    end

    unless block_given?
      for item in self
        return true unless item == false || item == nil
      end
      false
    end

    if parameter && parameter.class == Class
      for item in self
        return true if item.is_a?(parameter)
      end
      false
    elsif parameter && parameter.class == Regexp
      for item in self
        return true if item.match(parameter)
      end
      false
    else
      for item in self
        return true if item == parameter
      end
      false
    end
  end

  def my_none?(parameter = false)
    for item in self
      if block_given?
        return yield(item) ? true : false

      elsif !block_given? && parameter == false
        return item == false || item == nil ? false : true
      end
    end

    if parameter && parameter.class == Class
      for item in self
        return false unless item.is_a?(parameter)
      end
      true
    elsif parameter && parameter.class == Regexp
      for item in self
        return false if item.match(parameter)
      end
      true
    elsif parameter
      for item in self
        return false if item == parameter
      end
      true
    end
  end

  def my_count(parameter = false)
    result = 0
    if block_given? && parameter == false
      for item in self
        result += 1 if yield(item) == true
      end
      result
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
      elsif my_proc && my_proc.class == Symbol
        new_arr.push item.my_proc
      elsif my_proc
        new_arr.push my_proc.call(item)
      end
    end
    new_arr
  end

  def my_inject(parameter = false)
    return unless block_given?

    arr = self.to_a
    accumulator = arr[0]
    i = 0
    if block_given?
      while i < arr.length - 1
        accumulator = yield(accumulator, arr[i + 1])
        i += 1
      end
      accumulator *= parameter if parameter && parameter.class != Symbol
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

# rubocop:enable Metrics/CyclomaticComplexity

# rubocop:enable Metrics/MethodLength

# rubocop:enable Metrics/PerceivedComplexity

# rubocop:enable Style/GuardClause

# rubocop:enable Style/MultipleComparison

# rubocop:enable Style/IdenticalConditionalBranches