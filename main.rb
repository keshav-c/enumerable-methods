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

    def my_select
        filtered = []
        self.my_each { |item| filtered.push(item) if yield(item) }
        filtered
    end

end

ar = ["hello", 42, "an array", :sym, true, :sym2, 3.14]

# my_each test
# ------------------
# ar.my_each {|item| puts "#{item}"}

# my_each_with_index test
# ------------------
# ar.my_each_with_index {|item, i| puts "@#{i}: #{item}"}

# my_select test
# ------------------
puts ar.my_select {|item| item.is_a? Numeric}.join(", ")
puts ar.my_select {|item| item.is_a? Symbol}.join(", ")