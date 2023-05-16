class TreeNode
    attr_accessor :val, :left, :right
    def initialize(val = 0, left = nil, right = nil)
        @val = val
        @left = left
        @right = right
    end
end

def max_depth root, depth=0
  return depth if root.nil?
  # depth += 1
  # left_depth = max_depth(root.left, depth)
  # right_depth = max_depth(root.right, depth)
  return [1+max_depth(root.left, depth), 1+ max_depth(root.right, depth)].max
end

root = TreeNode.new 1, nil, nil
left = TreeNode.new 2, nil, nil
right = TreeNode.new 3, nil, nil
root.left = left
root.right = right

left2 = TreeNode.new 4, nil, nil
right2 = TreeNode.new 5, nil, nil
left3= TreeNode.new 6, nil, nil
right3 = TreeNode.new 7, nil, nil
left4 = TreeNode.new 8, nil, nil
right4 = TreeNode.new 9, nil, nil
left5 = TreeNode.new 10, nil, nil
right5 = TreeNode.new 11, nil, nil
left6 = TreeNode.new 12, nil, nil
right6 = TreeNode.new 13, nil, nil

right.left = left2
right.right = right2

right2.right = right3
right3.right = right4
right4.right = right5
right5.right = right6

puts max_depth root

def level_order root
  return [] if root.nil?
  q = Queue.new
  list = []
  q << root

  queue_length = 1
  processed_from_queue = 0

  level_arr = []
  while !q.empty?
    el = q.deq
    level_arr << el.val
    processed_from_queue += 1
    if el.left
      q << el.left
    end
    if el.right
      q << el.right
    end
    if processed_from_queue == queue_length
      processed_from_queue = 0
      queue_length = q.length
      list << level_arr
      level_arr = []
    end
  end
  list
end

#using BFS
def right_side_view(root)
   return [] if root.nil?
  list = []
   q = Queue.new
   q << root
   level_count = 0
   queue_length = 1
   while !q.empty?
    current = q.deq
    level_count += 1
    q << current.left if current.left
    q << current.right if current.right
    if level_count == queue_length
      queue_length = q.length
      level_count = 0
      list << current.val
    end
   end
   list
end



def right_side_view_dfs(root, list=[])
  return nil if root.nil?
  list << root.val if list.empty?

  right_side_view_dfs root.right, list
  right_side_view_dfs root.left, list

  #puts "#{node_right} #{node_left}"
  if !root.right.nil?
    list << root.right.val
  elsif !root.left.nil?
    list << root.left.val
  end
  list
end

def preorder_traversal(root, list=[], level=0)
  return nil if root.nil?
  list << root.val if list.length <= level
  preorder_traversal(root.right, list, level+1)
  preorder_traversal(root.left, list, level+1)
  list
end

def inorder_traversal(root, list=[])
  return nil if root.nil?
  inorder_traversal(root.right, list)
  list << root.val
  inorder_traversal(root.left, list)
  list
end

def postorder_traversal(root, list=[])
  return nil if root.nil?
  postorder_traversal(root.right, list)
  postorder_traversal(root.left, list)
  list << root.val
  list
end

#https://leetcode.com/problems/count-complete-tree-nodes/
def count_nodes root
  return 0 if root.nil?
    #first count levels
  height = get_height root
  return 1 if height == 0
  upper_count = 2**height - 1
  left, right = 0, upper_count
  while left < right
    idx = ((left+right)/2.0).ceil
    if node_exists(idx, height, root)
      left = idx
    else
      right = idx-1
    end
  end
  return upper_count + left + 1
end

def get_height root
  height = 0
  while root.left
    height += 1
    root = root.left
  end
  height
end

def node_exists idx, height, node
  left,right,count = 0, (2**height)-1, 0
  while count < height
    middle = ((left+right)/2.0).ceil
    if idx >= middle
      node = node.right
      left = middle
    else
      node = node.left
      right = middle-1
    end
    count += 1
  end
  return node != nil
end

def is_valid_bst root
  arr = []
  is_valid_bst_rec root, arr
  #return false if !is_valid
  (0...arr.length-1).each {|i|
    return false if arr[i] >= arr[i+1]
  }
  return true
end

def is_valid_bst_rec root, arr
  return true if root.nil?
  left = is_valid_bst_rec root.left, arr
  arr << root.val
  right = is_valid_bst_rec root.right, arr
end

def is_valid_bst2 root
  return dfs root, -Float::INFINITY, Float::INFINITY
end

def dfs root, min, max
  #going left, so min is as is, max is updated
  return false if root.val <= min || root.val >= max
  if (root.left)
    left = dfs(root.left, min, root.val)
    return false if !left
  end
  if root.right
    right = dfs(root.right, root.val, max)
    return false if !right
  end
  return true
end

def create_tree arr
  root = TreeNode.new arr[0]
  side = ["left","right"]
  q = Queue.new
  q << root
  i = 1
  while !q.empty?
    el = q.deq
    side.each {|s|
      current_node = TreeNode.new arr[i]
      if arr[i]
        el.left = current_node if s == "left" && !el.left
        el.right = current_node if s == "right" && !el.right
      end
      i += 1
      q.enq current_node if current_node
      return root if i >= arr.length
    }
  end
  root
end

def print_tree root
  return if root.nil?
  current = root
  puts "val #{current.val}"
  print_tree current.left
  print_tree current.right
end


root = create_tree [3,9,20,nil,nil,15,7]
print_tree root
puts "level_order: #{level_order root}"

root = create_tree [1,2,3,nil,5,nil,4]
root3 = create_tree [1,2,3,4,5,nil, 6, 9,7, nil, nil, nil,nil, 8]
#         1
#     2       3
#   4   5    -   6
# 9  7 - -     -   8

puts "right_side_view: #{right_side_view root}"
puts "right_side_view: #{right_side_view root3}"

puts "preorder_traversal: #{preorder_traversal root3}"
puts "inorder_traversal dfs: #{inorder_traversal root3}"
puts "postorder_traversal dfs: #{postorder_traversal root3}"

root4 = create_tree [1,2,3,4,5,6,7,8,9,10,11,nil,nil,nil,nil]
puts count_nodes root4

root5 = create_tree [2,1,3]
puts "#{is_valid_bst root5} is_valid_bst"
puts "#{is_valid_bst2 root5} is_valid_bst2"

root6 = create_tree [5,1,4,nil,nil,3,6]
puts "#{is_valid_bst root6} is_valid_bst"
puts "#{is_valid_bst2 root5} is_valid_bst2"

root7 = create_tree [5,4,6,nil,nil,3,7]
puts "#{is_valid_bst root7} is_valid_bst"
puts "#{is_valid_bst2 root5} is_valid_bst2"
