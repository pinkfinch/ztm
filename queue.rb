# lookup
# enqueue
# dequeue
# peek

#tickets/restaurants

class MyQueue


    def initialize
        @s1 = []
        @s2 = []
    end


=begin
    :type x: Integer
    :rtype: Void
=end
    def push(x)
        @s1 << x
    end


=begin
    :rtype: Integer
=end
    def pop
      return nil if @s1.empty? && @s2.empty?
      if @s2.empty?
        current = @s1.pop
        while current
          @s2.push current
          current = @s1.pop
        end
      end
      return @s2.pop
    end


=begin
    :rtype: Integer
=end
    def peek()
      return nil if @s1.empty? && @s2.empty?
      if @s2.empty?
        current = @s1.pop
        #prev = current
        while current
          @s2.push current
          current = @s1.pop
        end
      end
      current = @s2.pop
      @s2.push(current)
      return current
    end


=begin
    :rtype: Boolean
=end
    def empty()
      return @s1.empty? && @s2.empty?
    end

    def print
      @s1.each {|x|
        puts x
      }
      @s2.each {|x|
        puts x
      }
    end

end

q = MyQueue.new
q.push 1
q.push 2
q.push 3
q.print
puts q.peek
puts q.pop
puts q.empty
q.print

