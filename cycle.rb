require 'set'
class Node
  attr_accessor :val, :next
  def initialize val, next_val
      @val = val
      @next = next_val
  end
end

def find_cycle root
  return nil if root.nil?
  seen = Set.new
  current = root

  while(!seen.include? current)
    return nil if current.next.nil?  #no loops, just ended
    seen << current
    current = current.next
  end
  current
end

def find_tortoise_hare_cycle root
  return nil if root.nil?
  tortoise = root
  hare = root

  while tortoise && hare
    tortoise = tortoise.next
    if (hare.next)
      hare = hare.next.next
    else
      return nil
    end
    break if tortoise == hare
  end
  return nil if tortoise.nil? || hare.nil?
  p1 = root
  p2 = tortoise

  while (p1 != p2)
    p1 = p1.next
    p2 = p2.next
  end
  p1
end

n8 = Node.new(8, nil)
n7 = Node.new(7, n8)
n6 = Node.new(6, n7)
n5 = Node.new(5, n6)
n4 = Node.new(4, n5)
n3 = Node.new(3, n4)
n2 = Node.new(2, n3)
n1 = Node.new(1, n2)
n0 = Node.new(0, n1)
n8.next = n3


node = find_cycle n0
puts "#{node.val}"
node2 = find_tortoise_hare_cycle n0
puts "#{node2.val}"
