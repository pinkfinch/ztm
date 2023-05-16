
require 'set'


  class Trie
    def initialize
      @root = Node.new
    end

    def insert word
      return if !word || word.length == 0
      s = word.split("")
      prev = @root
      s.each {|ch|
        node = Node.new
        if !prev.children.has_key? ch
          prev.children[ch] = node
        else
          node = prev.children[ch]
        end
        prev = node
      }
      prev.is_end = true
    end

    def search word
      return true if !word || word.length == 0
      current = find_word word
      return false if !current
      return true if current.is_end
      false
    end

    def starts_with prefix
      return true  if !prefix || prefix.length == 0
      return false if !find_word prefix
      true
    end

    def find_word word

      s = word.split("")
      current = @root
      s.each {|ch|
        if current.children.has_key? ch
          current = current.children[ch]
        else
          return nil
        end
      }
      return current
    end

    def print_s
      # @map.each {|key, value|
      #   puts key
      #   pp value
     # }
    end
  end

  class Node
    attr_accessor  :is_end, :children

    def initialize
      @is_end = false
      @children = {}
    end
  end


# t = Trie.new
# t.insert "Hello"
# t.insert "Well"
# t.insert "Hola"
# t.insert "There"
# t.insert "Boo"
# t.insert "Peculiar"
# t.print_s
# puts t.search "Hello"
# puts t.starts_with "Hel"

obj = Trie.new()
obj.insert("word")
param_2 = obj.search("word")
param_3 = obj.starts_with("prefix")
