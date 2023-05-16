class Node
  attr_accessor :val, :prev, :next, :child
  def initialize(val=nil, prev=nil, next_=nil, child=nil)
      @val = val
      @prev = prev
      @next = next_
      @child = child
  end
end

def flatten root
  return root if root.nil? || root.next.nil?
  current = root
  while current
    tail = current.next
    if current.child
      child = current.child
      add_children(current,child,tail)
      #puts "Added children: #{current.val}, #{child.val}, #{tail.val}"
    end
    current = current.next
  end
  return root
end

def add_children parent, child, tail
  parent.next = child
  child.prev = parent
  parent.child = nil
  current = child
  while current
    previous = current
    if current.child
      grand_tail = current.next
      grand_child = current.child
      add_children(current, grand_child, grand_tail)
    end
    current = current.next
  end
  previous.next = tail
  tail.prev = previous
end

def print head
  current = head
  while current
    puts "Node value: #{current.val} previous: #{current.prev ? current.prev.val : "nil"}"
    # if current.child
    #   puts "Children"
    #   print current.child
    #   puts "End children"
    # end
    current = current.next
  end
end

def flatten2 root
  return root if root.nil?
  current = root

  while current
    if current.child
      child = current.child
      tail = current.next

      current.next = child
      child.prev = current
      current.child = nil
      while child.next
        child = child.next
      end
      tail.prev = child
      child.next = tail
    end
    current = current.next
  end
  return root
end

def make_list arr
  head = nil
  prev = nil
  i = 0
  while i < arr.length
    if arr[i] != nil
      node = Node.new(val=arr[i], prev=prev)
      if !prev
        head = node
        prev = node
      else
        prev.next = node
        prev = node
      end
      i += 1
    else
      node = head
      end_node = false
      puts "#{head}  #{node}"
      while arr[i].nil? && i < arr.length
        if !node.next
          end_node = true
        else
          node = node.next
        end
        i += 1
      end
      if end_node
        node.child = make_list arr[i..arr.length]
      else
        node.prev.child = make_list arr[i..arr.length]
      end
      break
    end
    #puts "#{node.val} #{node.prev} #{node.next} #{node.child}"
  end
  return head
end


# @param {Node} root
# @return {Node}
# def flattish(root)
#   return [] if root==nil
#   [root.val]+flattish(root.child)+flattish(root.next)
# end

# @param {Node} root
# @return {Node}
# def flatten(root)
#   return nil if root==nil
#   arr = flattish(root)
#   head = Node.new
#   head.val=arr[0]
#   ptr = 1
#   tail = head
#   while ptr<arr.length
#       tail.next = Node.new
#       tail.next.prev = tail
#       tail.next.val = arr[ptr]
#       ptr += 1
#       tail = tail.next
#   end
#   return head
# end
# root = flatten [1,2,3,4,5,6,nil,nil,nil,7,8,9,10,nil,nil,11,12]
# puts "#{root}"

head = make_list [1,2,3,4,5,6,nil,nil,nil,7,8,9,10,nil,nil,11,12]
print head
flatten2 head
puts "After flattening"
print head
puts "End tc1"

# head2 = make_list [1,nil,2,nil,3,nil]
# print head2
# flatten head2
# puts "After flattening"
# print head2
