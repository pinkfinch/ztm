
#given array [50, 40, 35, 25,24,33,30]
#with indices[0,  1,  2,  3,  4, 5, 6]
#formula for parent:  floor((idx-1)/2 )
#formula for left: (idx*2) + 1
#formula for right:(idx*2) + 2

class PriorityQueue

  def initialize arr
    @array = arr
  end

  def size
    return @array.length
  end

  def empty
    return @array.empty?
  end

  def push el
    @array << el
    idx = @array.length-1
    parent = get_parent idx
    while idx > 0 || parent != nil &&  el > @array[parent]
      swap idx, parent
      idx = parent
      parent = get_parent parent
    end
  end

  def peek
    return @array[0]
  end

  def pop
    ret_val = @array.shift
    @array[0] = @array.pop
    current = 0
    left = get_left 0
    right = get_right 0
    while(left && @array[current] < @array[left]) || (right && @array[current] < @array[right])
      if @array[current] < @array[left]
        swap current, left
        current = left
        left = get_left left
      elsif @array[current] < @array[right]
        swap current, right
        current = right
        right = get_right right
      end
    end
    return ret_val
  end

  def swap i, j
    return if(i == -1 || j == -1)
    tmp = @array[i]
    @array[i]= @array[j]
    @array[j] = tmp
  end

  def get_parent idx
    parent = ((idx-1)/2.0).floor
    return parent if parent >=0 && parent < @array.length
    return nil
  end

  def get_left idx
    child = (idx*2) + 1
    return child if child >=0 && child < @array.length
    return nil
  end

  def get_right idx
    child = (idx*2) + 2
    return child if child >=0 && child < @array.length
    return nil
  end

  def print_arr
    @array.each {|x|
      print x
      print " "
    }
  end
end

pq = PriorityQueue.new [50, 40, 35, 25,24,33,30]
puts "length : #{pq.size}"
pq.push 75
puts "push to queue 75 : #{pq.size}"
pq.print_arr
puts "pop: #{pq.pop}"
pq.print_arr
