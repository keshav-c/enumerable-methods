module Enumerable

    def my_each
        for idx in (0...self.size)
            yield(self[idx])
        end
    end

end


# my_each test
ar = ["hello", 42, :sym, true]
ar.my_each {|item| puts item}