# Toy Robot Simulator

class Table
    attr_reader :table, :pos, :face
    # Setup the table
    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
        @pos = [-1,-1]
        @face = "directionless"
        printTable
    end

    def printTable
        puts @table.map { |x| x.join(" ") }
        puts "position: #{@pos} facing #{@face}"
    end

end

# t = Table.new

def get_command(input)
    case input
        when /^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i 
            puts "ok"
            return "ok"
        else
            puts "invalid command"
            return "invalid command"
    end 
end

# t = Table.new
print "> "
get_command(gets.chomp)

