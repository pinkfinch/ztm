class Directory

    def initialize node
        @head = node
    end

    def add new_node      
        current = @head
        while current.next 
            return if new_node.id == current.id
            current = current.next
        end
        current.next = new_node
        new_node.prev = current
        new_node.next = nil
    end

    def print
        current = @head
        while current
            puts "id: #{current.id} data: #{current.data} "
            current = current.next
        end

    end

    # def delete node
    #     current = @head
    #     while current.next
    #         if current.id == node.id
    #              = current.next
    #             @head.prev = nil
    #         end
    #     end

    # end
   
end

class Node
    attr_accessor :id, :data, :next, :prev

    def initialize id, data
        @id = id
        @data = data
        @next = nil
        @prev = nil
    end
end

n = Node.new(6, 2222)
d = Directory.new(n)
d.add(Node.new(1, 123))
d.add(Node.new(2, 124))
d.add(Node.new(3, 125))
d.add(Node.new(4, 126))
d.add(Node.new(5, 127))
d.print