# what happens when two #s appear beside?
# Remove two chars before
# What happens to # when there is nothing before it?
# delete nothing
# Two empty strings are considered equal
# Case sensitivity matters

def str_cmp s1, s2
  s1 = s1.split("")
  s2 = s2.split("")
  s1_arr = get_arr s1
  s2_arr = get_arr s2
  #puts "#{s1_arr} #{s2_arr}"
  return s1_arr.eql? s2_arr
end

def get_arr str
  str_arr = []
  str.each {|char|
    char == '#' ? str_arr.pop : str_arr.push(char)
  }
  return str_arr
end

def str_cmp2(s1, s2)
  p1 = s1.length - 1
  p2 = s2.length - 1
  while(p1 >= 0 || p2 >= 0)
    if(s1[p1] == "#" || s2[p2] == "#")
      if(s1[p1] == "#")
        backCount = 2
          while(backCount > 0)
            p1 -= 1
            backCount -= 1
            if(s1[p1] == "#")
                backCount += 2
            end
          end
      end

      if(s2[p2] == "#")
        backCount = 2
        while(backCount > 0)
          p2 -= 1
          backCount -= 1
          if(s2[p2] == "#")
              backCount += 2
          end
        end
      end
    else
      if(s1[p1] != s2[p2])
        return false
      else
        p1 -= 1
        p2 -= 1
      end
    end
  end
  true
end


def str_length s
  length = -1
  (0...s.length).each {|i|
    if s[i] == '#'
      length -= 1 if length >= 0
    else
      length += 1
      s[length]=s[i]
    end
  }
  length
end

puts str_cmp2 "ab#z", "az#z" #true
puts str_cmp2 "abc#d", "acc#c" #false
puts str_cmp2 "x#y#z#", "a#" #true
puts str_cmp2 "a###b", "b" #true
puts str_cmp2 "Ab#z", "ab#z" #false

def backspace_compare(s, t)
  l_s = string_inline_creator(s)
  l_t = string_inline_creator(t)
  return false if l_s != l_t
  return true if -1 == l_s
  s[0..l_s] == t[0..l_t]
end

def string_inline_creator(s)
  w = -1
  (0...s.size).each do |r|
      read = s[r]
      if "#" == read
          w -= 1 if w >= 0
      else
          w += 1
          s[w] = read
      end
  end
  w
end

#given a string, find longest substring without repeating characters
#is the substring contiguous - yes
#subsequence - can be non contiguous

# longest substring without repeating characters
# test cases
# "aabbccdd" - repeating
# "abcbca" two substrings, same length
# "ccccccc"
# "abcdefgh"

def length_of_longest_substring s
  start_idx = 0
  str_hash = Hash.new
  max_length = 0
  s = s.split ""
  s.each_with_index {|ch, idx|
    if str_hash.has_key? ch
      if str_hash[ch] < start_idx
        str_hash[ch] = idx
        next
      end
      # puts "start of loop: #{ch}"
      max_length = [(idx - start_idx), max_length].max
      start_idx = str_hash[ch]+1
      # puts "#{start_idx} #{idx} #{ch} #{max_length}"
      # puts "#{str_hash}"
    end
    str_hash[ch] = idx
  }
  max_length = [s.length-start_idx, max_length].max

  puts "Max length of: #{s} is #{max_length}"
  max_length
end


def length_of_longest_substring2 s
  return s.length if s.length <= 1
  longest = 0

  for i in (0...s.length)
    seen_chars = {}
    current_len = 0
    for j in (i...s.length)
      if(!seen_chars[s[j]])
        current_len += 1
        seen_chars[s[j]] = true
        longest = [longest, current_len].max
      else
        break
      end
    end
  end
  puts "Max length of: #{s} is #{longest}"
  longest
end


length_of_longest_substring "aabbccdd"
length_of_longest_substring "abcbcad"
length_of_longest_substring "ccccccc"
length_of_longest_substring "abcdefgh"
length_of_longest_substring "abcabcbb"
length_of_longest_substring "pwwkew"


length_of_longest_substring2 "aabbccdd"
length_of_longest_substring2 "abcbcad"
length_of_longest_substring2 "ccccccc"
length_of_longest_substring2 "abcdefgh"
length_of_longest_substring2 "abcabcbb"
length_of_longest_substring2 "pwwkew"
