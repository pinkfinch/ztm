class Node
  attr_accessor :value, :next

  def initialize value, link=nil
    @value = value
    @next = link if link != nil
  end
end

class LinkedList
  attr_accessor :head

  def initialize head
    @head = head
  end

  def reverse
    return @head if @head == nil || @head.next == nil
    previous = nil
    current = @head
    while current
      second = current.next
      current.next = previous
      previous = current
      current = second
    end
    @head = previous
  end

  def reverse_part start, finish
    return @head if @head == nil || @head.next == nil

    previous = nil
    current = @head
    count = 1
    while current && count < start
      count += 1
      previous = current
      current = current.next
    end

    tail_ptr = current # to point to the remaining list when ready
    new_list = nil
    puts "#{count} #{tail_ptr.value} #{previous.value} #{current.value}"
    while count <= finish && current
      second = current.next
      current.next = new_list
      new_list = current
      current = second
      count += 1
      # puts "#{count} #{previous.value} #{current.value} #{second.value}"
      # break
    end
    previous.next = new_list
    tail_ptr.next = current
    if start == 1
      @head = new_list
    end
  end

  def reverse_part2 m, n
    start = nil
    current = @head
    position = 1
    while current && position < m
      start = current
      current = current.next
      position += 1
    end

    tail = current
    reversed_list = nil
    while position <= n && current
      second = current.next
      current.next = reversed_list
      reversed_list = current
      current = second
      position += 1
    end

    start.next = reversed_list
    tail.next = current
    @head = reversed_list if start == 1
  end

  def print
    current = @head
    while current
      puts "Node value: #{current.value}"
      current = current.next
    end
  end
end

n5 = Node.new(5, nil)
n4 = Node.new(4, n5)
n3 = Node.new(3, n4)
n2 = Node.new(2, n3)
n1 = Node.new(1, n2)
n0 = Node.new(0, n1)

ll = LinkedList.new n0
ll.print
ll.reverse
ll.print

ll.reverse_part2 2, 5
ll.print
