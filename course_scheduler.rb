#https://leetcode.com/problems/time-needed-to-inform-all-employees/
def num_of_minutes(n, head_id, manager, inform_time)
    return 0 if n == 1
    time = 0
    start = head_id
    visited = []
    total_time = []
    num_of_minutes_dfs(head_id, manager, inform_time, time, visited, total_time)
    return total_time.max
end

def num_of_minutes_dfs(current, manager, inform_time, time, visited, total_time)
  return if visited[current]
  children = []
  manager.select.with_index do |x,idx|
    children << idx if x == current
  end
  visited[current] = true
  if !children || children.length == 0
      total_time << time
  end
  children.each {|child|
    num_of_minutes_dfs child, manager, inform_time, time+inform_time[current], visited, total_time
  }
end

def num_of_minutes2(n, head_id, manager, inform_time)
  adj_list = Array.new(n){Array.new}
  manager.each_with_index { |mgr, idx|
    next if mgr <= -1
    subordinate_list = adj_list[mgr]
    subordinate_list = Array.new if !subordinate_list
    subordinate_list << idx
    adj_list[mgr] = subordinate_list
  }
  #pp adj_list
  return dfs head_id, adj_list, inform_time
end

def dfs current, adj_list, inform_time
  return 0 if adj_list[current].length == 0
  max = 0
  subordinates = adj_list[current]
  subordinates.each {|subordinate|
    time = dfs subordinate, adj_list, inform_time
    max = [max, time].max
  }
  return max + inform_time[current]
end

def can_finish(num_courses, prerequisites)
  return true if num_courses <= 1 || prerequisites.length == 0
    adj_list = []
    prerequisites.each {|pre_req|
      dependent = pre_req.pop
      adj_list[dependent] = [] if !adj_list[dependent]
      adj_list[dependent] << pre_req[0]
    }
    seen = []
    current = -1
    prev = []
    while seen.length < num_courses
      (0...num_courses).each { |idx|
        if !seen[idx]
          current = idx
          prev[current] = nil
          if adj_list[current]
            dfs_courses current, prev, adj_list, seen
          end
        end
      }
    end
    #pp prev
    prev.each_with_index {|val, idx|
      start = idx
      previous = val
      while previous
        previous = prev[previous]
        return false if previous == start
      end
    }
    true
end


def dfs_courses current, prev, adj_list, seen
  seen[current] = true
  pre_req = adj_list[current]
  return if !pre_req
  pre_req.each { |course|
    prev[course] = current
    next if seen[course]
    return dfs_courses course, prev, adj_list, seen
  }
  return
end


def can_finish_bfs num_courses, prerequisites
  return true if num_courses <= 1 || prerequisites.length == 0
    adj_list = Array.new(num_courses){Array.new}
    prerequisites.each {|pre_req|
      dependent = pre_req.pop
      adj_list[dependent] << pre_req[0]
    }
    #pp adj_list

    (0...num_courses).each {|current|
      q = Queue.new
      seen = []
      next if !adj_list[current]
      adj_list[current].each { |node|
        q << node
      }
      while !q.empty?
        pre_req = q.deq
        seen[pre_req] = true
        return false if pre_req == current
        next if !adj_list[pre_req]
        adj_list[pre_req].each { |node|
          q << node if !seen[node]
        }
      end

    }
    true
end

def can_finish_top num_courses, prerequisites
  return true if num_courses <= 1 || prerequisites.length == 0
  adj_list = Array.new(num_courses){Array.new}
  in_degree = Array.new(num_courses).fill(0)
  prerequisites.each {|pre_req|
    dependent = pre_req.pop
    adj_list[dependent] << pre_req[0]
    in_degree[pre_req[0]] += 1
  }
  #pp in_degree
  stack = []
  in_degree.each_with_index {|el, idx|
    stack << idx if el == 0
  }
  #pp stack
  count = 0
  while !stack.empty?
    current = stack.pop
    count += 1
    dependencies = adj_list[current]

    dependencies.each_with_index {|dep, idx|
      in_degree[dep] -= 1
      stack << dep if in_degree[dep] == 0
    }
  end
  puts count
  return count == num_courses
end

puts num_of_minutes(6,2, [2,2,-2,2,2,2], [0,0,1,0,0,0])
puts num_of_minutes(1,0, [-1], [0])

puts num_of_minutes2(6,2, [2,2,-2,2,2,2], [0,0,1,0,0,0])
puts num_of_minutes2(1,0, [-1], [0])

puts can_finish 2, [[1,0]]
puts can_finish 7, [[0,3],[1,0],[2,1],[4,5],[6,4],[5,6]]
puts can_finish 6, [[1,0],[2,1],[2,5],[0,3],[4,3],[3,5],[4,5]]
puts can_finish_bfs 2, [[1,0]]
puts can_finish_bfs 7, [[0,3],[1,0],[2,1],[4,5],[6,4],[5,6]]
puts can_finish_bfs 6, [[1,0],[2,1],[2,5],[0,3],[4,3],[3,5],[4,5]]

puts can_finish_top 2, [[1,0]]
puts can_finish_top 7, [[0,3],[1,0],[2,1],[4,5],[6,4],[5,6]]
puts can_finish_top 6, [[1,0],[2,1],[2,5],[0,3],[4,3],[3,5],[4,5]]
puts can_finish_top 5, [[1,4],[2,4],[3,1],[3,2]]
