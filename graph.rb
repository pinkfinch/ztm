require "set"

class Node
    attr_accessor :name, :adjacents

    def initialize name, adjacents=nil
        @name = name
        if adjacents
            @adjacents = Set.new(adjacents)
        else
            @adjacents = Set.new()
        end
    end
    def has_adjacents?
        return false if @adjacents.nil? || @adjacents.empty?
        return true
    end
end


class Graph

    def initialize list
        @list = list
    end
    def add_edge node1, node2
        node1.adjacents << node2
        node2.adjacents << node1
    end

    def print
        @list.each { |node|
            puts "Node #{node.name} with adjacents #{node.adjacents.map{|el| el.name}}}"
        }
    end
end

class BreadthFirstSearch
    def initialize graph
        @graph = graph
        #@visited = []
    end

    def bfs source_node, dest_node
        que = Queue.new
        visited = []
        came_from = {source_node => nil}
        current = nil
        que << source_node

        while !que.empty?
            current = que.pop
            if visited.index(current)
                next
            end
            puts "current: #{current.name}"
            visited << current
            current.adjacents.each { |node|
                came_from[node] = current if !came_from.key?(node)
                que << node
            }
        end
        puts "visited: #{visited.map{|e| e.name}}"
        return nil if !visited.index(dest_node)
        return reconstruct_path dest_node, came_from

    end

    def reconstruct_path(tail, came_from)
        path = []
        while !tail.nil?
          path << tail
          tail = came_from[tail]
        end
        path.reverse
    end

end


n1 = Node.new ("0")
n2 = Node.new ("1")
n3 = Node.new ("2")
n4 = Node.new ("3")
n5 = Node.new ("4")
n6 = Node.new ("5")
n7 = Node.new ("6")
n8 = Node.new ("7")


graph = Graph.new([n1,n2,n3,n4,n5,n6,n7,n8])

graph.add_edge(n1, n2)
graph.add_edge(n1, n3)
graph.add_edge(n2, n3)
graph.add_edge(n3, n4)
graph.add_edge(n2, n4)
graph.add_edge(n4, n5)
graph.add_edge(n3, n6)
graph.add_edge(n7, n8)
graph.print
bfs = BreadthFirstSearch.new graph
path = bfs.bfs(n1, n6)

for i in path
    puts i.name
end
