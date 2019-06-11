# frozen_string_literal: true

# Extend the Enumerable module with a bunch of my_ methods
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
    if !block_given?
      self.my_each { |item| return false unless item }
      return true
    else
      self.my_each { |item| return false unless yield(item) }
      return true
    end
  end

  def my_any?
    if !block_given?
      self.my_each { |item| return true if item }
      return false
    else
      self.my_each { |item| return true if yield(item) }
      return false
    end
  end

  def my_none?
    if !block_given?
      self.my_each { |item| return false if item }
      return true
    else
      self.my_each { |item| return false if yield(item) }
      return true
    end
  end

  def my_count(el = nil)
    if !block_given?
      if el.nil?
        return self.size
      else
        result = 0
        self.my_each { |item| result += 1 if item == el }
        return result
      end
    else
      result = 0
      self.my_each { |item| result += 1 if yield(item) }
      return result
    end
  end

  def my_map(&proc)
    mapped = []
    self.my_each { |item| mapped.push(proc.call(item)) }
    mapped
  end

  def my_inject(init = nil)
    if init.nil?
      result = self[0]
      to_process = self[1..-1]
    else
      result = init
      to_process = self
    end
    to_process.my_each { |item| result = yield(result, item) }
    result
  end
end

# test data (uncomment before testing)
# ------------------
# ar = ['hello', 42, 'an array', :sym, true, :sym2, 3.14]
# ar2 = [1, 2, 3, 4, 5]
# hsh = { 'first' => 45, '2nd' => true, third: 'a string' }

# my_each test
# ------------------
# ar.my_each { |item| puts "A #{item}" }    # Array

# my_each_with_index test
# ------------------
# ar.my_each_with_index {|item, i| puts "@#{i}: #{item}"}

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
# ar.push(nil)
# puts "[#{ar.join(", ")}] are all truthy? #{ar.my_all?}"
# ar.pop
# puts "[#{ar2.join(", ")}] are all truthy? #{ar2.my_all?}"

# my_any? test
# ------------------
# any_syms = ar.my_any? {|item| item.is_a? Symbol}
# puts "[#{ar.join(", ")}] has any symbols? #{any_syms}"
# any_arrays = ar.my_any? {|item| item.is_a? Array}
# puts "[#{ar.join(", ")}] has any arrays? #{any_arrays}"
# nil_array = Array.new(5, nil)
# puts "[#{nil_array.join(", ")}] has any truthy? #{nil_array.my_any?}"
# nil_array[2] = 23
# puts "[#{nil_array.join(", ")}] has any truthy? #{nil_array.my_any?}"

# my_none? test
# ------------------
# no_strings = ar.my_none? {|item| item.is_a? String}
# puts "[#{ar.join(", ")}] has no strings? #{no_strings}"
# no_strings = ar2.my_none? {|item| item.is_a? String}
# puts "[#{ar2.join(", ")}] has no strings? #{no_strings}"
# nil_array = Array.new(5, nil)
# puts "[#{nil_array.join(", ")}] has no truthy? #{nil_array.my_none?}"
# nil_array[2] = 23
# puts "[#{nil_array.join(", ")}] has no truthy? #{nil_array.my_none?}"

# my_count test
# ------------------
# num_str = ar.my_count {|i| i.is_a? String}
# puts "[#{ar.join(", ")}] has #{num_str} strings"
# num_int = ar.my_count {|i| i.is_a? Integer}
# puts "[#{ar.join(", ")}] has #{num_int} integers"
# puts "[#{ar.join(", ")}] has #{ar.my_count} elements"
# ar = ['hello', 42, 'an array', 42, :sym, true, :sym2, 3.14, 42]
# puts "[#{ar.join(", ")}] has #{ar.my_count(42)} 42s"
ary = [1, 2, 4, 2]
p ary.my_count                  #=> 4 (the array contains 4 elements)
p ary.my_count(2)               #=> 2 (there are two elements equals to argument 2)
p ary.my_count { |x| x%2 == 0 } #=> 3 (there are 3 even numbers in the array)

# my_map test
# ------------------
# puts "array: [#{ar2.join(", ")}]"
# ar2_squared = ar2.my_map { |i| i**2 }       # Use Block
# p ar2_squared
# cube = Proc.new { |i| i**3 }        # Use proc
# ar2_cubed = ar2.my_map(&cube)
# p ar2_cubed

# my_inject test
# ------------------
# def multiply_els(array)
#   array.my_inject { |prod, el| prod * el }
# end
# puts multiply_els([2, 4, 5])
# puts multiply_els([3, 12, -2, 5])
