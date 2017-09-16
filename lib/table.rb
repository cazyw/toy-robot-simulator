# Table class for the Toy RObot Simulator

class Table
    attr_accessor :table

    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
    end

    def pieceRemoved (pos)
        @table[(pos[1]-4).abs][pos[0]] = "x"
        @table
    end

    def pieceAdded (pos)
        @table[(pos[1]-4).abs][pos[0]] = "O"
        @table
    end
    
    def printTable
        puts @table.map { |x| x.join(" ") }
        @table
    end
end