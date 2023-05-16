#https://leetcode.com/problems/min-cost-climbing-stairs/

def min_cost_climbing_stairs(cost)
    length = cost.length
    cost << 0
    cost_arr = Array.new(length).fill{-1}
    return min_cost_rec cost, length, cost_arr
end

def min_cost_rec cost, i, cost_arr
  return 0 if i < 0
  return cost[i] if i == 0 || i == 1
  minimums = []
  [i-1, i-2].each {|l|
    if cost_arr[l] != -1
      minimums << cost_arr[l]
    else
      minval = min_cost_rec cost, l, cost_arr
      cost_arr[l] = minval
      minimums << minval
    end
  }
  return cost[i] + minimums.min
end

def min_cost_climbing_stairs2(cost)
  length = cost.length
  return cost[length-1] if length == 1
  cost_arr =[cost[0], cost[1]]
  (2...length).each { |i|
    cost_arr[i] = cost[i] + [cost_arr[i-1], cost_arr[i-2]].min
  }
  return [cost_arr[length-1], cost_arr[length-2]].min
end

def min_cost_climbing_stairs3(cost)
  length = cost.length
  return cost[length-1] if length == 1
  dp1, dp2 = cost[0],cost[1]
  (2...length).each { |i|
    current = cost[i] + [dp1,dp2].min
    dp1 = dp2
    dp2 = current
  }

  return [dp1, dp2].min
end

puts min_cost_climbing_stairs [10,15,20]
puts min_cost_climbing_stairs [1,100,1,1,1,100,1,1,100,1]
puts min_cost_climbing_stairs [0,0,0,1]

puts min_cost_climbing_stairs2 [10,15,20]
puts min_cost_climbing_stairs2 [1,100,1,1,1,100,1,1,100,1]
puts min_cost_climbing_stairs2 [0,0,0,1]

puts min_cost_climbing_stairs2 [10,15,20]
puts min_cost_climbing_stairs3 [1,100,1,1,1,100,1,1,100,1]
puts min_cost_climbing_stairs2 [0,0,0,1]
