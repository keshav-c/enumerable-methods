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

    def my_all?
        self.my_each {|item| return false unless yield(item)}
        true
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
# puts ar.my_select {|item| item.is_a? Numeric}.join(", ")
# puts ar.my_select {|item| item.is_a? Symbol}.join(", ")


# my_all? test
# ------------------
puts ar.my_all? {|item| item.is_a? String}
ar2 = [1, 2, 3, 4, 5]
puts ar2.my_all? {|item| item.is_a? Integer}
