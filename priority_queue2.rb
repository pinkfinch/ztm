#given array [50, 40, 35, 25,24,33,30]
#with indices[0,  1,  2,  3,  4, 5, 6]
#formula for parent:  floor((idx-1)/2 )
#formula for left: (idx*2) + 1
#formula for right:(idx*2) + 2
class PriorityQueue

  def initialize(array=[], &block) # :yields: a, b
    @array = array
    @cmp = block || lambda{ |a,b| a <=> b }
  end

  def << el
    @array << el
    bubble_up @array.length-1
  end

  def pop
    exchange @array.length-1, 0
    max = @array.pop
    bubble_down(0)
    max
  end

  def bubble_up index
    parent = ((index-1)/2).floor
    return if index <= 0 || @array[parent][1] < @array[index][1]
    exchange index, parent
    bubble_up parent
  end

  def bubble_down index
    left_index = index*2+1
    return if left_index > @array.length-1
    right_index = index*2+2
    child_index = left_index
    child_index = right_index if right_index <= @array.length-1 && @array[right_index][1] < @array[left_index][1]
    return if @array[index][1] < @array[child_index][1]
    exchange child_index, index
    bubble_down child_index
  end

  def exchange source, target
    @array[source], @array[target] = @array[target], @array[source]
  end

  def length
    @array.length
  end

  def empty?
    @array.empty?
  end
end

