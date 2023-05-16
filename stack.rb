
# pop
# push
# peek 
# lookup

class MethodOrder
      
    def initialize
        @methods = []
    end

    def pop
        @methods.pop
    end

    def push data
        @methods.push(data)
    end

    def peek
        @methods[@methods.length-1]
    end

    def lookup item
        index = @methods.rindex(item) 
        return @methods.length - index if index != nil
        nil
    end

    def print
        @methods.each { |x|
            puts x
        }
    end
end

m = MethodOrder.new
m.push ("21")
m.push ("29")
m.push ("23")
m.push ("56")
m.push ("788")
m.push ("2")

puts m.pop
m.print
puts m.peek
m.print

puts m.lookup ("56")
puts m.lookup (2)
