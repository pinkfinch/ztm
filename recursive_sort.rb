
def quicksort a, from=0, to=nil
  return a if a.length == 1
  to = a.length-1 if to.nil?
  return a if from >= to
  pivot = from
  for i in (pivot+1..to)
    if a[i] < a[pivot]
      tmp = a[i]
      a[i] = a[pivot+1]
      a[pivot+1] = a[pivot]
      a[pivot] = tmp
      pivot += 1
    end
  end

  quicksort(a, from, pivot-1)
  quicksort(a, pivot+1, to)
  a
end


def quicksort2 a, start=0, to=nil
  return a if a.length == 1
  to = a.length-1 if to.nil?
  return a if start >= to
  pivot = a[to]
  partition_idx = start
  (start..to).each {|j|
    if a[j] < pivot
      swap a, partition_idx, j
      partition_idx += 1
    end
  }
  swap(a, partition_idx, to)
  quicksort2(a, start, partition_idx-1)
  quicksort2(a, partition_idx+1, to)
  a
end

def swap(a, partition_idx, j)
  tmp = a[partition_idx]
  a[partition_idx] = a[j]
  a[j] = tmp
end

puts "quick sort: #{quicksort2 [5,9,3,4,2,22]}"
puts "quick sort: #{quicksort2 [45,3, 29, 221, 12, 9, 33, 22, 1, 455, 322, 2]}"
