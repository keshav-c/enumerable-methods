# frozen_string_literal: true

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
