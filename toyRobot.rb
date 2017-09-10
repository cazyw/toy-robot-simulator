# Toy Robot Simulator

class Table
    attr_reader :table, :pos, :face
    # Setup the table
    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
        @pos = [-1,-1]
        @face = "directionless"
        puts "Initialise table"
        printTable
    end

    def place_robot(col, row, f)
        # to account for starting in bottom left corner
        modrow = (row-4).abs
        @table[modrow][col] = "O"
        @pos = [col, row]
        @face = f.downcase
        printTable
    end

    def printTable
        puts @table.map { |x| x.join(" ") }
        puts "position: #{@pos} facing #{@face}"
    end

end

# t = Table.new

def get_command(command)
    case command
        when /^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i 
            match = command.match(/^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i)
            col, row, face = match.captures
            t = Table.new
            t.place_robot(col.to_i, row.to_i, face)
            puts "ok"
            return t
        else
            puts "invalid command"
            return "invalid command"
    end 
end

def play_game
    print "> "
    input = gets.chomp
    while (input != "report")
        get_command(input)
        print "> "
        input = gets.chomp
    end
end

# play_game
