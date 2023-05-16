#https://leetcode.com/problems/sudoku-solver/

def solve_sudoku(board)
   n = board.length
   boxes = Array.new(n)
   rows = Array.new(n)
   cols = Array.new(n)
   for i in (0...n) do
    boxes[i] = {}
    rows[i] = {}
    cols[i] = {}
   end
   for i in (0...n) do
      for j in (0...n) do
        if board[i][j] != "."
          boxId = get_box_id i, j
          val = board[i][j]
          rows[i][val] = true
          cols[j][val] = true
          boxes[boxId][val] = true
        end
      end
    end
    solve_backtrack board, boxes, rows, cols, 0,0
    pp board
end

def solve_backtrack board, boxes, rows, cols, r, c
  return true if r == board.length || c == board[0].length
  if board[r][c] == "."
    for num in (1..9) do
      num_s = num.to_s
      board[r][c] = num_s
      box_id= get_box_id r, c
      box = boxes[box_id]
      row = rows[r]
      col = cols[c]
      if is_valid box, row,col, num_s
        box[num_s] = true
        col[num_s] = true
        row[num_s] = true
        if c == board[0].length - 1
          if solve_backtrack board, boxes, rows, cols, r+1, 0
            return true
          end
        else
          if solve_backtrack board, boxes, rows, cols, r, c+1
            return true
          end
        end
        box.delete(num_s)
        row.delete(num_s)
        col.delete(num_s)
      end
      board[r][c] = "."
    end
  else
    if c == board[0].length - 1
      if solve_backtrack board, boxes, rows, cols, r+1, 0
        return true
      end
    else
      if solve_backtrack board, boxes, rows, cols, r, c+1
        return true
      end
    end
  end
  return false
end

def get_box_id row, col
  box_row = (row/3) * 3
  box_col = col/3
  return box_row + box_col
end

def is_valid(box,row,col, val)
  return false if box[val] || row[val] || col[val]
  true
end

board =
 [["5","3",".", ".","7",".", ".",".","."],
  ["6",".",".", "1","9","5", ".",".","."],
  [".","9","8", ".",".",".", ".","6","."],

  ["8",".",".", ".","6",".", ".",".","3"],
  ["4",".",".", "8",".","3", ".",".","1"],
  ["7",".",".", ".","2",".", ".",".","6"],

  [".","6",".", ".",".",".", "2","8","."],
  [".",".",".", "4","1","9", ".",".","5"],
  [".",".",".", ".","8",".", ".","7","9"]]


 solve_sudoku board

