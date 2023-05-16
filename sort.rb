
def bubble_sort a

  for i in (0...a.length-1)
    length = a.length - i - 1
    for j in (0...length)
      if a[j] > a[j+1]
        tmp = a[j]
        a[j] = a[j+1]
        a[j+1] = tmp
      end
    end
  end
  puts "bubble sort #{a}"
end

bubble_sort [45,3, 29, 221, 12, 9, 33, 22, 1, 455, 322, 2]

def selection_sort a
  for j in (0...a.length)
    min = j
    for i in (j+1...a.length)
      if a[i] < a[min]
        min = i
      end
    end

    tmp = a[min]
    a[min] = a[j]
    a[j] = tmp
  end
  puts "Selection sort #{a}"
end

selection_sort [45,3, 29, 221, 12, 9, 33, 22, 1, 455, 322, 2]

def insertion_sort array

  for i in 1...(array.length)  # Step 1
    j = i # Step 2
    while j > 0 # Step 3
        if array[j-1] > array[j] # Step 4
            temp = array[j]
            array[j] = array[j-1]
            array[j-1] = temp
        else
            break
        end
        j = j - 1 # Step 5
    end
  end
  puts "insertion sort #{array}"
  array
end
insertion_sort [45,3, 29, 221, 12, 9, 33, 22, 1, 455, 322, 2]

def merge_sort a
  return a if a.length == 1
  middle = (a.length - 1)/2

  left = merge_sort(a[0..middle])
  right = merge_sort(a[middle+1..a.length-1])


  a = merge(left, right)
  #puts "merge_sort #{a}"
  return a
end

def merge (left, right)
  a = []
  i,j = 0,0
  while (i < left.length && j < right.length)
    if left[i] <= right[j]
      a << left[i]
      i += 1
    else
      a << right[j]
      j += 1
    end
  end
  if i < left.length
    for k in (i...left.length)
      a << left[k]
    end
  end

  if j < right.length
    for k in (j...right.length)
      a<< right[k]
    end
  end
  a
end

puts "merge sort: #{merge_sort [45,3, 29, 221, 12, 9, 33, 22, 1, 455, 322, 2]}"

def quick_sort a, from=0, to=nil
  return a if a.length == 1
  to = a.length-1 if to == nil
  return a if from >= to  #base case
  pivot = from
  for i in (pivot+1..to)
    if (a[i] < a[pivot])
      tmp = a[i]
      a[i] = a[pivot+1]
      a[pivot+1] = a[pivot]
      a[pivot] = tmp
      pivot += 1
    end
  end
  quick_sort(a,from,pivot-1 )
  quick_sort(a, pivot+1, to)
  return a
end


puts "quick sort: #{quick_sort [45,3, 29, 221, 12, 9, 33, 22, 1, 455, 322, 2]}"
