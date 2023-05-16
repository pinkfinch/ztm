def trap_rainwater elevations

    maxL, maxR = 0,0
    total = 0

    elevations.each_with_index {|el, i|
        maxL = elevations[0, i].max
        maxR = elevations[i, elevations.length-1].max
        current_water = [maxL,maxR].min - el
        total += current_water if current_water > 0
    }
    total
end

# def trap_rainwater2 elevations
#     maxL, maxR = 0,0
#     pl, pr = 0, elevations.length-1
#     total_water = 0

#     while (pl < pr)
#         if elevations[pl] < elevations[pr]
#             if elevations[pl] < maxL && pl > 0
#                 current_water = maxL - elevations[pl]
#                 total_water += current_water
#             else
#                 pl += 1
#                 maxL = elevations[pl]
#             end
#         else
#             if elevations[pr] < maxR && pr < elevations.length - 1
#                 current_water = maxR - elevations[pr]
#                 total_water += current_water
#             else
#                 pr -= 1
#                 maxR = elevations[pr]
#             end
#         end
#     end

# end

def trap_rainwater2 elevations
    max_left, max_right = 0,0
    total = 0
    j = elevations.length-1
    i = 0
    while (i < elevations.length && j >= 0 && i <= j)
        puts "#{i} #{j} #{max_left} #{max_right} #{total}"
        #find which side is smaller
        if max_left <= max_right
            if elevations[i] <= max_left
                total += (max_left - elevations[i])
            else
                max_left = elevations[i]
            end
            i += 1
        else
            if elevations[j] <= max_right
                total += (max_right - elevations[j])
            else
                max_right = elevations[j]
            end
            j -= 1
        end

    end
    total
end

puts trap_rainwater2 [0,1,0,2,1,0,3,1,0,1,2]

puts trap_rainwater2 [4,2,0,3,2,5]
