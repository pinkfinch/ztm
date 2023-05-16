def transpose matrix
  new_length = matrix[0].length
  new_arr = Array.new(new_length) {Array.new(matrix.length)}
  for i in (0...new_length)
    for j in (0...matrix.length)
      new_arr[i][j] = matrix[j][i]
    end
  end
  #new_arr = matrix.map {|i,j|  j,i }
  new_arr
end

puts "#{transpose [[1,2,3],[4,5,6],[7,8,9]]}"

def set_zeroes matrix
  col_q = Queue.new
  for i in (0...matrix.length)
    temp = -1
    for j in (0...matrix[0].length)
      if matrix[i][j] == 0
        temp = i
        col_q << j
      end
    end
    matrix[temp].each_with_index {|j,k| matrix[temp][k] = 0 } if temp != -1
  end
  while !col_q.empty?
    col = col_q.deq
    for i in (0...matrix.length)
      matrix[i][col] = 0
    end
  end
  matrix
end

def set_zeroes2 matrix
  # col_q = Queue.new
  first_row, first_col = false
  for i in (0...matrix.length)
    for j in (0...matrix[0].length)
      if matrix[i][j] == 0
        first_row = true if i == 0
        first_col = true if j == 0
        matrix[i][0] = 0
        matrix[0][j] = 0
      end
    end
  end
  for i in (1...matrix.length)
    for j in (1...matrix[0].length)
      matrix[i][j] = 0 if matrix[i][0] == 0 || matrix[0][j] == 0
    end
  end

  for i in (0...matrix.length)
    for j in (0...matrix[0].length)
      matrix[i][0] = 0 if first_col
      matrix[0][j] = 0 if first_row
    end
  end

  matrix
end


def search_matrix(matrix, target)
  return false if matrix.nil? || matrix.length == 0
  start, ending = 0, (matrix.length * matrix[0].length)-1
  while (start <= ending)
    mid = (start+ending)/2
    start_row = mid/matrix[0].length
    start_col = mid % matrix[0].length
    return true if matrix[start_row][start_col] == target
    if matrix[start_row][start_col] < target
      start = mid+1
    else
      ending = mid-1
    end
  end
  false
end



puts "set zeros #{set_zeroes2 [[0,1,2,0],[3,4,5,2],[1,3,1,5]]}"
 #Output: [[0,0,0,0],[0,4,5,0],[0,3,1,0]]

puts "set zeros #{set_zeroes2 [[1,1,1],[1,0,1],[1,1,1]]}"

puts "set zeros #{set_zeroes2 [[1,0,3]]}"
puts "search matrix #{search_matrix [[1,3,5,7],[10,11,16,20],[23,30,34,60]], 3}"
puts "search matrix #{search_matrix [[1,3,5,7],[10,11,16,20],[23,30,34,60]], 13}"

puts "search matrix #{search_matrix [[1],[3]], 3}"
