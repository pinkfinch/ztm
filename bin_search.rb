def binary_search array, b, left=0, right=nil
  right = array.length-1 if right == nil
  while left <= right
    mid = (right + left)/2
    if b == array[mid]
      return mid
    elsif b < array[mid]
      right = mid-1
    else
      left = mid+1
    end
  end
  return -1
end

def bin_search2 array, b, left=0, right=nil
  right = array.length-1 if right.nil?
  if left == right && array[left] != b
    return -1
  elsif left == right
    return left
  end
  mid = (right + left)/2
  if b == array[mid]
    return mid
  elsif b < array[mid]
    return bin_search2 array, b, left, mid-1
  else
    return bin_search2 array, b, mid+1, right
  end
end

def search_range(nums, target)
  return [-1,-1] if nums.length < 1
  index = binary_search nums, target
  puts "index for #{nums} is #{index}"
  return [-1,-1] if index == -1

  end_pos,start_pos = index,index
  while start_pos != -1
    temp1 = start_pos
    start_pos = binary_search nums, target, 0, start_pos-1
  end
  start_pos = temp1

  while end_pos != -1
    temp2 = end_pos
    end_pos = binary_search nums, target, end_pos+1, nums.length-1
  end
  end_pos = temp2
  [start_pos, end_pos]
end

puts bin_search2 [1,4,6,7,8,11,14,17,21], 17

puts  "[5,7,7,8,8,10] #{search_range [5,7,7,8,8,10], 8}"
puts "[5,7,7,8,8,10] #{search_range [5,7,7,8,8,10], 6}"
puts "[], #{search_range [], 6}"
puts "[1,2,3,4,5,6] #{search_range [1,2,3,4,5,6], 3}"
