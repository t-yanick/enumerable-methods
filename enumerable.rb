module Enumerable
    def my_each
        for i in self
            yield(i)
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
end

# numbers = [2,4,7,9,1]
# result = numbers.my_each {|number| puts number}

# numbers = [2,4,7,9,1]
# result = numbers.my_each_with_index {|number, i| puts "number is #{number} and index is #{i}"}



