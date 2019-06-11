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

    def my_any?
        self.my_each {|item| return true if yield(item)}
        false
    end

    def my_none?
        self.my_each {|item| return false if yield(item)}
        true
    end

end

ar = ["hello", 42, "an array", :sym, true, :sym2, 3.14]
ar2 = [1, 2, 3, 4, 5]

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
all_strings = ar.my_all? {|item| item.is_a? String}
puts "[#{ar.join(", ")}] are all strings? #{all_strings}"
all_ints = ar2.my_all? {|item| item.is_a? Integer}
puts "[#{ar2.join(", ")}] are all integers? #{all_ints}"

# my_any? test
# ------------------
any_syms = ar.my_any? {|item| item.is_a? Symbol}
puts "[#{ar.join(", ")}] has any symbols? #{any_syms}"
any_arrays = ar.my_any? {|item| item.is_a? Array}
puts "[#{ar.join(", ")}] has any arrays? #{any_arrays}"

# my_none? test
# ------------------
no_strings = ar.my_none? {|item| item.is_a? String}
puts "[#{ar.join(", ")}] has no strings? #{no_strings}"
no_strings = ar2.my_none? {|item| item.is_a? String}
puts "[#{ar2.join(", ")}] has no strings? #{no_strings}"