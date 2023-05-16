def check_palindrome s
  #s = s.gsub(/\W/, '')
  s = s.gsub(/[^0-9a-zA-Z]/, '').downcase
  #puts s
  (0...s.length).each { |left|
    right = s.length - left - 1
    break if (left >= right)
    return false if s[left] != s[right]
  }
  true
end

def check_palindrome2 s
  #s = s.gsub(/\W/, '')

  s = s.gsub(/[^0-9a-zA-Z]/, '').downcase
  return true if s.length <= 1
  puts s
  middle = s.length/2
  left = middle-1
  right = s.length.odd? ? middle+1 : middle
  puts "#{s.length} #{left} #{right}"
  while left >= 0 && right <= s.length
    return false if s[left] != s[right]
    left -= 1
    right += 1
  end
  true
end


def check_palindrome3 s
  #s = s.gsub(/\W/, '')
  return true if s.length <= 1
  s = s.gsub(/[^0-9a-zA-Z]/, '').downcase
  #puts s
  s == s.reverse
end


puts check_palindrome3 "Borrow or rob?"
puts check_palindrome3 "a"
puts check_palindrome3 "Never odd or even."
puts check_palindrome3 "UFO tofu"
puts check_palindrome3 "Was it a car or a cat I saw? "
puts check_palindrome3 "Red roses run no risk, sir, on Nurse’s order. "
puts check_palindrome3 "Never odd or even.boo"
puts check_palindrome3 "blub"
puts check_palindrome3 ",; W;:GlG:;l ;,"

puts "Valid palindrome test cases"

def valid_palindrome s
  s = s.gsub(/\W/, "").downcase
  left, right = 0, s.length-1
  while (left < right)
    if s[left] == s[right]
      left += 1
      right -= 1
    else
      s1 = s[0,left] + s[left+1, s.length]
      s2 = s[0,right] + s[right+1, s.length]
      puts "#{s} #{s1} #{s2}"
      if check_palindrome3(s1) || check_palindrome3(s2)
        return true
      else
        return false
      end
    end
  end
  true
end

def valid_palindrome2(s,left=0,right=s.length-1,called=0)
  s = s.gsub(/\W/, "").downcase
  return true if s.length <= 1
  return false if(called) > 1
  while (left < right)
    if s[left] == s[right]
      left += 1
      right -= 1
    else
      s1 = s[left+1, right]
      s2 = s[left, right-1]
      puts "#{s1} #{s2}"
      called += 1
      if valid_palindrome2(s,left+1,right,called) || valid_palindrome2(s,left, right-1,called)
        return true
      else
        return false
      end
    end
  end
  true
end

puts valid_palindrome2 "aba"
puts valid_palindrome2 "abca"
puts valid_palindrome2 "acxcybycxcxa"
puts valid_palindrome2 "bababb"
puts valid_palindrome2 "eeccccbccceea"
puts valid_palindrome2 "dcuppucud"
puts valid_palindrome2 "abcdefg"


