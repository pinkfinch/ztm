#https://leetcode.com/problems/knight-probability-in-chessboard/


# reccurence relation:
# Directions = [
#   [-2, -1],
#   [-2, 1],
#   [-1, 2],
#   [1, 2],
#   [2, 1],
#   [2, -1],
#   [1, -2],
#   [-1, -2]
# ];

# 0 <= r < N, 0 <= c < N, k === 0
# probability(r, c, k) = 1

# 0 <= r < N, 0 <= c < N, k > 1
# probability(r, c, k) = Σ(x, y)∈Directions probability(r + x, c + y, k - 1) / 8

# r < 0 || r > N, c < 0 || c > N
# probability(r, c, k) = 0


def knight_probability n, k, r, c, dp_prob=nil
  directions = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  return 0 if r < 0 || c < 0 || r >= n || c >= n
  return 1 if k == 0
  if !dp_prob
    dp_prob = Array.new(k+1){Array.new(n){Array.new(n)}}
  end
  res = 0
  directions.each do |dir|
    row = r + dir[0]
    col = c + dir[1]
    if row >= 0 && col >= 0 && row < n && col < n && dp_prob[k-1][row][col]
        prob = dp_prob[k-1][row][col]
    else
        prob = knight_probability n, k - 1, row,col, dp_prob
        if row >= 0 && col >= 0 && row < n && col < n
            dp_prob[k-1][row][col] = prob
        end
    end
    res +=  prob/8.0
    #puts "#{res} #{prob}"
  end
  return res
end

def knight_probability2 n,k,r,c
  directions = [[2,1],[2,-1],[-2,1],[-2,-1],[1,2],[1,-2],[-1,2],[-1,-2]]
  dp_prev = Array.new(n){Array.new(n).fill(0)}
  dp_prev[r][c] = 1
  dp_current = nil
  (1..k).each do |l|
    dp_prev = dp_current if dp_current
    dp_current =  Array.new(n){Array.new(n).fill(0)}
    (0...n).each { |row|
      (0...n).each {|col|
        directions.each {|dir|
          c_r = row + dir[0]
          c_c = col + dir[1]
          if c_r >= 0 && c_r < n && c_c >= 0 && c_c < n
            dp_current[row][col] = dp_current[row][col] + dp_prev[c_r][c_c]/8.0
          end
        }
      }
    }
  end

  res = 0
  (0...n).each {|i|
    (0...n).each {|j|
      res += dp_current[i][j];
    }
  }
  res
end


#n = 3, k = 2, row = 0, column = 0
puts knight_probability 3, 2, 0, 0  #0.0625
puts knight_probability 3, 3, 0, 0   #0.01562
puts knight_probability 3, 2, 1, 1   #0.0
puts knight_probability 6, 2,2,2  #0.53125

puts knight_probability2 3, 2, 0, 0  #0.0625
puts knight_probability2 3, 3, 0, 0   #0.01562
puts knight_probability2 3, 2, 1, 1   #0.0
puts knight_probability2 6, 2,2,2  #0.53125
