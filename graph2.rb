
class Graph
  attr_accessor :vertices

  def initialize
    @vertices = {}
  end

  def add_neighbour name, neighbour
    v = @vertices[name]
    if v
      v << neighbour
    else
      neighbours = Array.new
      neighbours << neighbour
      @vertices[name] = neighbours
    end
  end

  def g_print
    @vertices.each {|v|
      pp v
    }
  end

  def bfs start
    visited = {}
    previous = {}

    return if @vertices.empty?
    q = Queue.new
    q << start
    #prev_vertex = nil
    while !q.empty?
      vertex = q.deq
      neighbours = @vertices[vertex]
      next if visited[vertex]
      neighbours.each { |neighbour|
        q << neighbour
        previous[neighbour] = vertex if !visited[neighbour]
      }

      # if q.length == neighbours.length
      #   prev_vertex = vertex
      # end
      visited[vertex] = true
    end
    previous
  end

end



adj_m = {
    0 => [1,3],
    1 => [0],
    2 => [3,8],
    3 => [0,2,4,5],
    4 => [3,6],
    5 => [3],
    6 => [4,7],
    7 => [6],
    8 => [2]
  }
  g = Graph.new
  adj_m.each {|k,neighbours|
      neighbours.each { |n|
        g.add_neighbour k, n
      }
  }

  g.g_print
  previous = g.bfs 0
  pp previous


adj_list= [[1,3],[0],[3,8],[0,2,4,5],[3,6],[3],[4,7],[6],[2]]
def traverse_bfs adj_list
  visited = {}
  values = []
  q = Queue.new
  q << 0
  while !q.empty?
    vertex = q.deq
    next if visited[vertex]
    adj_list[vertex].each {|n|
      q << n
    }
    values << vertex
    visited[vertex] = true
  end
  values
end

def bfs adj_list, values=[], current=0, visited={}

  values << current
  visited[current] = true
  adj_list[current].each { |neighbour|
    bfs adj_list, values, neighbour, visited if !visited[neighbour]
  }
  values
end

puts traverse_bfs adj_list
puts bfs adj_list
