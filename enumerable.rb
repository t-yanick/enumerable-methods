module Enumerable
    def my_each
        for i in self
            yield(i)
        end
    end
end

numbers = [2,4,7,9,1]
result = numbers.my_each {|number| puts number}

