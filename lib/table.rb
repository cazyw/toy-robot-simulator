# Table class for the Toy Robot Simulator
# Manipulates the table

class Table
    attr_accessor :table

    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
    end

    def piece_removed (pos)
        @table[(pos[1]-4).abs][pos[0]] = "x"
        @table
    end

    def piece_added (pos)
        @table[(pos[1]-4).abs][pos[0]] = "O"
        @table
    end
    
    def print_table
        puts @table.map { |x| x.join(" ") }
        @table
    end
end