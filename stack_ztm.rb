
def is_valid(s)
  return true if s.nil? || s.length == 0
  stack = Array.new
  paren_hash = {"{" => "}", "(" => ")", "[" => "]"}

  s.each_char { |ch|
    if paren_hash.has_key? ch
      stack.push ch
    else
      prev = stack.pop
      return false if paren_hash[prev] != ch
    end
  }
  return false if stack.length > 0
  return true
end


def min_remove_to_make_valid(s)
  return s if s.nil? || s == ""
  stack = Array.new
  delete_els = []
  s.each_char.with_index {|ch, index|
    if ch == ')'
      if stack.length == 0
        delete_els << index
      else
        stack.pop
      end
    elsif ch == '('
      stack.push(index)
    end
  }
  while stack.length > 0
    index = stack.pop
    delete_els << index
  end

  delete_els.sort!.reverse!
  puts "#{delete_els}"
  delete_els.each {|idx|
    s.slice!(idx)
  }
  s
end



puts is_valid ""  #true
puts is_valid "{({[]})}" #true
puts is_valid "{{{{}}}"       #false
puts is_valid "{([[[[[]])}"    #false
puts is_valid "[{(})]" #false

puts min_remove_to_make_valid "lee(t(c)o)de)"
puts min_remove_to_make_valid "a)b(c)d"
puts min_remove_to_make_valid "))(())"
puts min_remove_to_make_valid "))(("
puts min_remove_to_make_valid "())()((("
puts min_remove_to_make_valid "((((babbced)"
puts min_remove_to_make_valid "((((ba))bbced)"

puts min_remove_to_make_valid2 "lee(t(c)o)de)"
puts min_remove_to_make_valid2 "a)b(c)d"

