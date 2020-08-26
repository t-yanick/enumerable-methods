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

    def my_select
        newArr = []
        self.my_each do |element|
            result = yield(element)
            if result == true
                newArr.push(element)
            end
        end
        newArr
    end
end

# numbers = [2,4,7,9,1]
# result = numbers.my_each {|number| puts number}

# numbers = [2,4,7,9,1]
# result = numbers.my_each_with_index {|number, i| puts "number is #{number} and index is #{i}"}

# numbers = [2,4,7,9,1]
# p (numbers.my_select {|number| number != 4})

# friends = ['Sharon', 'Leo', 'Leila', 'Brian', 'Arun']
# p (friends.my_select { |friend| friend != "Brian" })



