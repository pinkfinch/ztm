class HashTest
    attr_accessor :articles


    def initialize
        @articles = Hash.new
    end

    def add title, notes
        @articles[title] = notes
    end

    def get(title)
        @articles.key?(title) ? @articles[title] : nil
    end

    def print
        @articles.each {|k,v|
            puts "Article with title #{k} and notes #{v}"
        }
    end
end

h = HashTest.new

h.add("Test1", "This is a test")
h.add("Test2", "This is a test2")

h.add("Test3", "This is a test3")
h.add("Test4", "This is a test4")
h.add("Test5", "This is a test5")

puts h.get("Test2")
h.print
