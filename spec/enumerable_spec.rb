require './enumerable'

describe Enumerable do
    before {
        @ar = ['hello', 42, 'an array', :sym, true, :sym2, 3.14]
        @ar2 = [1, 2, 3, 4, 5]
        @hsh = { 'first' => 45, '2nd' => true, third: 'a string' }
        @nil_array = Array.new(5, nil)
    }

    context "#my_each" do
        it "returns a comma separated list of elements in array" do
            res = ""
            @ar2.my_each { |i| res += i.to_s + ", "}
            res = res[0...-2]
            expect(res).to eql "1, 2, 3, 4, 5"
        end
    end

    context "#my_each_with_index" do
        it "returns a ',' separated, ':' indexed list of elements in array" do
            res = ""
            @ar2.my_each_with_index { |v, i| res += "#{i}: #{v}" + ", "}
            res = res[0...-2]
            expect(res).to eql "0: 1, 1: 2, 2: 3, 3: 4, 4: 5"
        end
    end

    context "#my_select" do
        it "returns only Numeric type data from list" do
            expect(@ar.my_select { |i| i.is_a? Numeric}).to eql [42, 3.14]
        end
        it "returns only Symbol type data from list" do
            expect(@ar.my_select { |i| i.is_a? Symbol}).to eql [:sym, :sym2]
        end
    end

    context "#my_all?" do
        it "correctly checks that all items in array are not Strings" do
            expect(@ar.my_all? { |i| i.is_a? String}).not_to eql true
        end
        it "correctly checks that all items in array are Integers" do
            expect(@ar2.my_all? { |i| i.is_a? Integer}).to eql true
        end
        it "correctly checks that all elements in Array are truthy" do
            expect(@ar2.my_all?).to eql true
        end
        it "doesn't return true when some elements in Array are not truthy" do
            ar2 = @ar2 + [nil]
            expect(ar2.my_all?).not_to eql true
        end
    end

    context "#my_any?" do
        it "returns true when any elements are Symbols" do
            expect(@ar.my_any? { |i| i.is_a? Symbol }).to eql true
        end
        it "returns false when asked in any elements are themselves arrays" do
            expect(@ar.my_any? { |i| i.is_a? Array }).not_to eql true 
        end
        it "returns false when asked if any elements in nil array are truthy" do
            expect(@nil_array.my_any?).not_to eql true
        end
        it "returns true when any one of the elements is truthy" do
            new_nil_array = @nil_array + [42]
            expect(new_nil_array.my_any?).to eql true
        end
    end

    context "#my_none?" do
        it "returns false when asked to confirm if none in array are Strings" do
            expect(@ar.my_none? { |i| i.is_a? String} ).not_to eql true
        end
        it "returns true when asked if none in Integer array are Strings" do
            expect(@ar2.my_none? { |i| i.is_a? String} ).to eql true
        end
        it "returns true when asked if none in nil array are truthy" do
            expect(@nil_array.my_none?).to eql true
        end
        it "returns false when one element in nil array is truthy" do
            new_nil_array = @nil_array + [42]
            expect(new_nil_array.my_none?).not_to eql true
        end
    end

    context "#my_count?" do
        it "returns the number of string elements in the array" do
            expect(@ar.my_count { |i| i.is_a? String }).to eql 2
        end
        it "returns the number of integer elements in the array" do
            expect(@ar.my_count { |i| i.is_a? Integer }).to eql 1
        end
        it "returns the size of the array when given no block and no data" do
            expect(@ar.my_count).to eql 7
        end
        it "returns the number of 42s in the array" do
            ar = ['hello', 42, 'an array', 42, :sym, true, :sym2, 3.14, 42]
            expect(ar.my_count 42).to eql 3
        end
        it "returns the number of even numbers in the array" do
            ar = [1, 2, 4, 2]
            expect(ar.my_count { |x| x%2 == 0 }).to eql 3
        end
    end

    context "#my_map" do
        it "returns an array with square of original elements" do
            expect(@ar2.my_map { |i| i**2 }).to eql [1, 4, 9, 16, 25]
        end
        it "accepts a proc to return cubes of the original elements" do
            cube = Proc.new { |i| i**3 }
            expect(@ar2.my_map(&cube)).to eql [1, 8, 27, 64, 125]
        end
    end

    context "#my_inject" do
        it "computes the product of all elements in the array" do
            expect(@ar2.my_inject { |prod, i| prod * i }).to eql 120
        end
        it "computes the sum of all elements with the given base number" do
            expect(@ar2.my_inject(20) { |sum, i| sum + i }).to eql 35
        end
    end
end
