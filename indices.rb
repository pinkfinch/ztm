def indices arr, target
    return nil if arr.nil? || arr.length < 2
    diff = Hash.new
    for i in (0...arr.length)
        if diff[arr[i]] != nil
            return [i, diff[arr[i]]]
        end
        diff[target-arr[i]] = i

    end

    # for i in (0...arr.length)
    #     if diff[arr[i]] != nil
    #         return [i, diff[arr[i]]]
    #     end
    # end
    return nil
end

def two_sum(nums, target)
    dict = {}
    nums.each_with_index do |n, i|
      if dict[target - n]
        return dict[target - n], i
      end
      dict[n] = i
    end
  end

puts indices([2,4,1,9,7], 5)

puts indices([2,4,1,9,7, 10, 11, 12, 13], 24)

