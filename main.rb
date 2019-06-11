# frozen_string_literal: true

module Enumerable

  def my_each
    return nil unless block_given?
    if self.is_a? Hash
      for key in self.keys()
        yield(key, self[key])
      end
    else
      for idx in (0...self.size)
        yield(self[idx])
      end
    end
  end

  def my_each_with_index
    return nil unless block_given?
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
    self.my_each { |item| return false unless yield(item) }
    true
  end

  def my_any?
    self.my_each { |item| return true if yield(item) }
    false
  end

  def my_none?
    self.my_each { |item| return false if yield(item) }
    true
  end

  def my_count
    result = 0
    self.my_each { |item| result += 1 if yield(item) }
    result
  end

  def my_map(&proc)
    mapped = []
    self.my_each { |item| mapped.push(proc.call(item)) }
    mapped
  end

  def my_inject(init=nil)
    if init.nil?
      result, to_process = self[0], self[1..-1]
    else
      result, to_process = init, self
    end
    to_process.my_each { |item| result = yield(result, item) }
    result
  end

end

ar = ["hello", 42, "an array", :sym, true, :sym2, 3.14]
ar2 = [1, 2, 3, 4, 5]
hsh = {"first" => 45, "2nd" => true, third: "a string"}

# my_each test
# ------------------
# ar.my_each { |item| puts "A #{item}" }    # Array
# hsh.my_each { |k, v| puts "#{k} and #{v}"}    # Hash
# p hsh.my_each.nil?    # No block

# my_each_with_index test
# ------------------
ar.my_each_with_index {|item, i| puts "@#{i}: #{item}"}
p ar.my_each_with_index

# my_select test
# ------------------
# puts ar.my_select {|item| item.is_a? Numeric}.join(", ")
# puts ar.my_select {|item| item.is_a? Symbol}.join(", ")


# my_all? test
# ------------------
# all_strings = ar.my_all? {|item| item.is_a? String}
# puts "[#{ar.join(", ")}] are all strings? #{all_strings}"
# all_ints = ar2.my_all? {|item| item.is_a? Integer}
# puts "[#{ar2.join(", ")}] are all integers? #{all_ints}"

# my_any? test
# ------------------
# any_syms = ar.my_any? {|item| item.is_a? Symbol}
# puts "[#{ar.join(", ")}] has any symbols? #{any_syms}"
# any_arrays = ar.my_any? {|item| item.is_a? Array}
# puts "[#{ar.join(", ")}] has any arrays? #{any_arrays}"

# my_none? test
# ------------------
# no_strings = ar.my_none? {|item| item.is_a? String}
# puts "[#{ar.join(", ")}] has no strings? #{no_strings}"
# no_strings = ar2.my_none? {|item| item.is_a? String}
# puts "[#{ar2.join(", ")}] has no strings? #{no_strings}"

# my_count test
# ------------------
# num_str = ar.my_count {|i| i.is_a? String}
# puts "[#{ar.join(", ")}] has #{num_str} strings"
# num_int = ar.my_count {|i| i.is_a? Integer}
# puts "[#{ar.join(", ")}] has #{num_int} integers"

# my_map test
# ------------------
# puts "array: [#{ar2.join(", ")}]"

# Use Block
# ar2_squared = ar2.my_map { |i| i**2 }
# p ar2_squared


# Use proc
# cube = Proc.new { |i| i**3 }
# ar2_cubed = ar2.my_map(&cube)
# p ar2_cubed

# my_inject test
# ------------------
# def multiply_els(array)
#   array.my_inject {|prod, el| prod * el}
# end
# puts multiply_els([2,4,5])
# puts multiply_els([3,12,-2, 0])

