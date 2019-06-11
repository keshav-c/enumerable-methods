module Enumerable

    def my_each
        for idx in (0...self.size)
            yield(self[idx])
        end
    end

    def my_each_with_index
        for idx in (0...self.size)
            yield(self[idx], idx)
        end
    end

end

ar = ["hello", 42, :sym, true]

# my_each test
ar.my_each {|item| puts "#{item}"}

# my_each_with_index test
ar.my_each_with_index {|item, i| puts "#{item} #{i}"}