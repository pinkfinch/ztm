require_relative 'error'
class Monarchy

  def initialize monarch_name
    @king = Person.new(monarch_name)
    @persons = {}
    @persons[monarch_name] = @king

  end

  def birth child, parent
    current_parent = @persons[parent]
    raise InvalidParentError.new("No royal with that name.") if !current_parent
    new_child = Person.new(child)
    current_parent.children.push new_child
    @persons[child] = new_child
  end

  def death name
    current_person = @persons[name]
    raise NoSuchRoyalError.new("No royal with that name.") if !current_person
    current_person.is_alive = false
  end

  def get_order_of_succession succession=nil, start=@king
    succession = [] if succession == nil
    succession << start if start.is_alive
    if start.children
      start.children.each { |child|
        get_order_of_succession succession, child
      }
    end
    succession
  end

  # private
  # def find_in_hierarchy person, start
  #   return start if person == start.name
  #   current = start
  #   if !current.children.empty?
  #     current.children.each {|child|
  #       resp = find_in_hierarchy person, child
  #       return resp if resp
  #     }
  #   end
  # end

  # def find_parent person, start=@king
  #   current = start
  #   prev = nil
  #   current.children.each {|child|
  #     return prev if current == person
  #     prev = current
  #     find_parent person, child
  #   }
  #   return nil
  # end
end

class Person
  attr_accessor :name, :children, :is_alive

  def initialize name
    @name = name
    @children = []
    @is_alive = true
  end

  def pprint
    puts "start: #{@name}"
    pp children
  end
end

m = Monarchy.new("Charles")

m.birth "William", "Charles"
m.birth "Harry", "Charles"
m.birth "Perry", "Charles"
m.birth "Charlotte", "William"
m.birth "Andrea", "Harry"
m.birth "Whilte", "William"
m.birth "Farah", "Charlotte"
puts m.get_order_of_succession
