# Table class for the Toy RObot Simulator

class Table
    attr_accessor :table

    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
    end

end