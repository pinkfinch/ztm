def traverse_dfs matrix
  seen =  Array.new(matrix.length) {Array.new(matrix[0].length).fill(false)}

  values = []
  dfs2 matrix, 0, 0, seen, values

  return values
end

def dfs matrix, i, j, seen, values

  length = matrix.length
  width = matrix[0].length
  return if i < 0 || j < 0 || i >= length || j >=width || seen[i][j]
  values << matrix[i][j]
  seen[i][j] = true

  #up
  if i-1 >= 0 && !seen[i-1][j]
    dfs matrix, i-1, j, seen, values
  elsif j+1 < width && !seen[i][j+1]
    dfs matrix, i, j+1, seen, values
  elsif i+1 < length && !seen[i+1][j]
    dfs matrix, i+1,j,seen, values
  elsif j-1 >= 0 && !seen[i][j-1]
    dfs matrix, i, j-1, seen, values
  else
    return
  end
end



def dfs2 matrix, i, j, seen, values
  length = matrix.length
  width = matrix[0].length
  directions = [[-1,0],[0,1],[1,0],[0,-1]]
  return if i < 0 || j < 0 || i >= length || j >=width || seen[i][j] || values.length == length*width
  values << matrix[i][j]
  seen[i][j] = true

  for k in (0...directions.length)
    current_dir = directions[k]
    dfs2 matrix, i+current_dir[0], j+current_dir[1], seen, values
  end
end

def bfs matrix
  length = matrix.length
  width = matrix[0].length
  q = Queue.new
  directions = [[-1,0], [0,1],[1,0],[0,-1]]
  values = []
  seen = Array.new(length) {Array.new(width).fill(false)}

  q << [0,0]
  while !q.empty?
    current_pos = q.deq
    i = current_pos[0]
    j = current_pos[1]
    next if i < 0 || i >= length || j < 0 || j >= width || seen[i][j]
    values << matrix[i][j]
    seen[i][j] = true
    for k in (0...directions.length)
      current_dir = directions[k]
      q << [i+ current_dir[0], j + current_dir[1]]
    end
  end
 return values
end

#https://leetcode.com/problems/number-of-islands/
#bfs
def num_islands(grid)
    return 0 if grid.nil? || grid.length == 0 || grid[0].length == 0
    #seen = Array.new(grid.length) {Array.new(grid[0].length).fill(false)}
    directions = [[-1,0], [0,1], [1,0],[0,-1]]
    que = Queue.new
    num_islands = 0

  for i in (0...grid.length)
    for j in (0...grid[0].length)
      next if grid[i][j].to_i == 0
      que << [i,j]
      num_islands += 1
      while (!que.empty?)
          el = que.pop
          row,col = el[0], el[1]

          next if row < 0 || row >= grid.length || col < 0 || col >= grid[0].length || grid[row][col].to_i == 0

          grid[row][col] = 0
          for k in (0...directions.length)
              current_dir = directions[k]
              que << [ row + current_dir[0], col + current_dir[1]]
          end
      end
      #puts "Seen: #{seen}"
    end
  end
  num_islands
end

def num_islands_dfs(grid)
  return 0 if grid.nil? || grid.length == 0 || grid[0].length == 0
  num_islands = 0
  for i in (0...grid.length)
    for j in (0...grid[0].length)
      next if grid[i][j] == "0"
      num_islands = islands_dfs grid, i, j, num_islands
    end
  end
  num_islands
end

def islands_dfs matrix, i, j, num_islands
  directions = [[-1,0], [0,1], [1,0],[0,-1]]
  return if i < 0 || j < 0 || i >= matrix.length || j >= matrix[0].length || matrix[i][j] == "0"
  matrix[i][j] = "0"
  num_islands += 1
  for k in (0...directions.length)
    current_dir = directions[k]
    islands_dfs matrix, i+current_dir[0], j+current_dir[1], num_islands
  end
  num_islands
end

#https://leetcode.com/problems/rotting-oranges/
def oranges_rotting(grid)
  directions = [[-1,0],[0,1],[1,0],[0,-1]]
  return 0 if grid.nil? || grid.length == 0 || grid[0].length == 0
  q = Queue.new
  good_oranges = 0
  for i in (0...grid.length)
    for j in (0...grid[0].length)
      good_oranges += 1 if grid[i][j] == 1
      q << [i,j] if grid[i][j] == 2
    end
  end
  # return 0 if good_oranges == 0
  # return -1 if q.empty?
  minutes =0
  current_q_len = q.length
  while !q.empty?
    if current_q_len == 0
      current_q_len = q.length
      minutes += 1
    end
    current_orange = q.deq
    current_q_len -= 1
    row,col = current_orange[0], current_orange[1]
    for k in (0...directions.length)
      current_dir = directions[k]
      c_row,c_col = row+current_dir[0], col+current_dir[1]

      next if c_row < 0 || c_col < 0 || c_row >= grid.length || c_col >= grid[0].length
      if grid[c_row][c_col] == 1
        q << [c_row,c_col]
        good_oranges -= 1
        grid[c_row][c_col] = 2
      end
    end
  end
  puts "#{good_oranges} #{minutes}"
  good_oranges > 0? -1 : minutes
end

def walls_and_gates rooms
  return rooms if rooms.nil? || rooms.length == 0 || rooms[0].length == 0
  for row in (0...rooms.length)
    for col in (0...rooms[0].length)
      steps = 0
      if rooms[row][col] == 0
        walls_and_gates_dfs rooms, row, col, steps
      end
    end
  end
  rooms
end

def walls_and_gates_dfs rooms, row, col, steps
  directions = [[-1,0],[0,1],[1,0],[0,-1]]
  return if row < 0 || col < 0 || row >= rooms.length || col >= rooms[0].length || steps > rooms[row][col]
  for k in (0...directions.length)
    current_dir = directions[k]
    rooms[row][col] = steps
    walls_and_gates_dfs rooms, row + current_dir[0], col + current_dir[1], steps + 1
  end
end

def walls_and_gates_bfs rooms
  directions = [[-1,0],[0,1],[1,0],[0,-1]]
  return rooms if rooms.nil? || rooms.length == 0 || rooms[0].length == 0
  q = Queue.new
  for row in (0...rooms.length)
    for col in (0...rooms[0].length)
      if rooms[row][col] == 0
        q << [row,col]
      end
    end
  end

  while !q.empty?
    row,col = q.deq
    for i in (0...directions.length)
      current_dir = directions[i]
      c_row = row+current_dir[0]
      c_col = col+current_dir[1]
      #update_rooms rooms, rooms[row][col], row+current_dir[0], col+current_dir[1], q
      next if c_row < 0 || c_col < 0 || c_row >= rooms.length || c_col >= rooms[0].length ||  rooms[c_row][c_col] != 2147483647
      rooms[c_row][c_col] = rooms[row][col] + 1
      q << [c_row,c_col]
    end
  end
  rooms
end

def update_rooms rooms, steps, row, col, q
  return if row < 0 || col < 0 || row >= rooms.length || col >= rooms[0].length ||  rooms[row][col] != 2147483647
  rooms[row][col] = steps + 1
  q << [row,col]
end

puts "#{ traverse_dfs [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20]]}"
puts "#{ bfs [[1,2,3,4,5],[6,7,8,9,10],[11,12,13,14,15],[16,17,18,19,20]]}"

puts "number of islands: #{num_islands([["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
])}"

puts "number of islands: #{num_islands([["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
])}"


puts "number of islands: #{num_islands([["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","1"],
  ["0","0","0","1","1"]
])}"
#dfs

puts "number of islands: #{num_islands_dfs([["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","0"],
  ["0","0","0","0","0"]
])}"

puts "number of islands: #{num_islands_dfs([["1","1","0","0","0"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
])}"


puts "number of islands: #{num_islands_dfs([["1","1","1","1","0"],
  ["1","1","0","1","0"],
  ["1","1","0","0","1"],
  ["0","0","0","1","1"]
])}"


puts "oranges_rotting: #{oranges_rotting([[2,1,1],
                                          [1,1,0],
                                          [0,1,1]])}"
puts "oranges_rotting: #{oranges_rotting([[2,1,1],[0,1,1],[1,0,1]])}"
puts "oranges_rotting: #{oranges_rotting([[0,2]])}"

puts "walls and gates #{walls_and_gates [[2147483647, -1, 0, 2147483647],
                                         [2147483647, 2147483647, 2147483647, -1],
                                        [2147483647, -1, 2147483647, -1],
                                        [0, -1, 2147483647,2147483647]]}"
                                        ##[[3,-1,0,1],[2,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]


puts "walls and gates #{walls_and_gates [[2147483647, -1, 0, 2147483647],
                                        [-1, 2147483647, 2147483647, -1],
                                       [2147483647, -1, 2147483647, -1],
                                       [0, -1, 2147483647,2147483647]]}"
                                       ##[[2147483647,-1,0,1],[-1,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]

# puts "walls and gates_bfs #{walls_and_gates_bfs [[2147483647, -1, 0, 2147483647],
#                                        [2147483647, 2147483647, 2147483647, -1],
#                                       [2147483647, -1, 2147483647, -1],
#                                       [0, -1, 2147483647,2147483647]]}"
#                                       ##[[3,-1,0,1],[2,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]


# puts "walls and gates_bfs #{walls_and_gates_bfs [[2147483647, -1, 0, 2147483647],
#                                       [-1, 2147483647, 2147483647, -1],
#                                      [2147483647, -1, 2147483647, -1],
#                                      [0, -1, 2147483647,2147483647]]}"
                                     ##[[2147483647,-1,0,1],[-1,2,1,-1],[1,-1,2,-1],[0,-1,3,4]]


 puts "walls and gates_bfs #{walls_and_gates_bfs [[2147483647,0,2147483647,2147483647,0,2147483647,-1,2147483647]]}"
