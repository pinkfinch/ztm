class TreeNode
    attr_accessor :value, :left, :right

    def initialize val, left = nil, right = nil
        @value = val
        @left = left
        @right = right
    end

    def is_leaf
        return true if @left.nil? && @right.nil?
        false
    end

end

class BinarySearchTree

    def initialize val
        @root = TreeNode.new(val)
    end

    def insert val
        current = @root
        prev = nil
        while current != nil
            prev = current
            if current.value > val 
                current = current.left 
            elsif current.value < val
                current = current.right
            end
        end
        if prev.value < val
            prev.right = TreeNode.new(val)
        else
            prev.left = TreeNode.new(val)
        end
    end

    def delete val
        current = @root
        parent = current
        left_child = false
        #find node
        while current 
            break if current.value == val 
            if current.value < val && current.right 
                parent = current
                current = current.right
            elsif current.value > val && current.left
                parent = current
                current = current.left 
                left_child = true
            else
                return nil
            end 
        end
        
        puts "Current node in delete: #{current.value}"
        if current.is_leaf && parent.left.value == current.value
            parent.left = nil
        elsif current.is_leaf && parent.right.value == current.value
            parent.right = nil
        elsif current.left.nil?          
            assign_child parent, current.right
        elsif current.right.nil? 
            assign_child parent, current.left
        else 
            sucessor = successor(current.right)
            assign_child parent, successor
            assign_child successor, current.left
        end
    end

    def assign_child(parent, node)
        if parent.value > node.value
            parent.left = node
        else 
            parent.right = node
        end
    end

    def successor node
        current = node
        # loop down to find the leftmost leaf
        while current.left 
            current = current.left
        end
        current
    end

    def pre_order_search(node = @root)
        return if node == nil
        puts node.value
        pre_order_search(node.left)
        pre_order_search(node.right)
    end

    def in_order_search(node = @root) 
        return if node == nil
        in_order_search (node.left)
        puts node.value
        in_order_search(node.right)
    end

    def post_order_search(node = @root)
        return if node == nil
        post_order_search(node.left)
        post_order_search(node.right)
        puts node.value
    end

    def breadth_first_search(node = @root, list = [])
        que = Queue.new
        que << node
        while !que.empty?
            current = que.pop
            list << current.value
            if current.left 
                que << current.left
            end
            if current.right
                que << current.right
            end
        end
        return list
    end
end

bst = BinarySearchTree.new(10)
bst.insert(11)
bst.insert(9)
bst.insert(5)
bst.insert(29)
bst.insert(7)
bst.insert(22)
bst.insert(18)
bst.insert(21)
bst.insert(40)
bst.insert(6)




# Demonstrating Different Kinds of Traversals
puts "In-Order Traversal:"
bst.in_order_search
puts "Pre-Order Traversal:"
bst.pre_order_search
puts "Post-Order Traversal:"
bst.post_order_search
puts "After delete"
bst.delete(18)
bst.in_order_search

puts "BST "
puts bst.breadth_first_search
# //If you know a solution is not far from the root of the tree:
# breadth first search
# # //If the tree is very deep and solutions are rare: 
# breadth first search (DFS will take long)
# BFS might have memory concerns
# # //If the tree is very wide:
# DFS (BFS - needs too much memory since it keeps track of nodes in current level)

# # //If solutions are frequent but located deep in the tree:
# depth first (find answer quixker)

# # //Determining whether a path exists between two nodes:
# DFS 

# # //Finding the shortest path:
# breadth first