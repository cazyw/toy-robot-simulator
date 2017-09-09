# Toy Robot Simulator

class Table
    # Setup the table
    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
        puts @table.map { |x| x.join(" ") }
    end

end

t = Table.new
