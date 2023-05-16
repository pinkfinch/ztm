def maximum_sized_container arr
    return 0 if arr == nil || arr.length < 2
    max_area = 0
    arr.each_with_index {|el, i|
        for j in (i+1...arr.length)
            area = [el, arr[j]].min * (j-i)
            max_area = area if area > max_area
        end
    }
    max_area
end

def maximum_sized_container2 heights
    max_area = 0
    start,end_p = 0, heights.length-1
    while start<=end_p
        area = (end_p - start) * [heights[start], heights[end_p]].min
        max_area = [area, max_area].max
        if  heights[start] < heights[end_p]
            start += 1
        else
            end_p -= 1
        end
    end
    max_area
end

# matrix = [[0,1,2],[3,4,5],[6,7,8],[9,10,11]]
# puts matrix[1][2]

puts maximum_sized_container2([7,1,2,3,9])
