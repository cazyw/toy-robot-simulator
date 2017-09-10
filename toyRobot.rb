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

        # there's already a game underway
        if (@pos[0] >= 0)
            @table[(@pos[1]-4).abs][@pos[0]] = "x"
        end

        # to account for starting in bottom left corner
        modrow = (row-4).abs
        @table[modrow][col] = "O"
        @pos = [col, row]
        @face = f
        printTable  
        return self
    end

    def move
        # if negative, robot has not been placed
        if (@pos[0] < 0)
            return self
        end

        # values to change the robot on the board
        direction = {
            "NORTH" => [-1, 0], 
            "SOUTH" => [1, 0],
            "EAST" => [0, 1],
            "WEST" => [0, -1]
        }
        moveBy = direction[@face]
        
        # check if move takes it out of bounds
        if (@pos[0] + moveBy[1] > 4 || @pos[1] - moveBy[0] > 4 ||
            @pos[0] + moveBy[1] < 0 || @pos[1] - moveBy[0] < 0)
            puts "out of bounds"
        else
            @table[(@pos[1]-4).abs][@pos[0]] = "x"
            @pos[1] -= moveBy[0]
            @pos[0] += moveBy[1]
            @table[(@pos[1]-4).abs][@pos[0]] = "O"
            puts "valid move"
        end
        printTable
        return self
    end

    def printTable
        puts @table.map { |x| x.join(" ") }
        puts "position: #{@pos} facing #{@face}"
        return "position: #{@pos} facing #{@face}"
    end

    def get_command(command)
        command.upcase!
        case command
            when /^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i 
                match = command.match(/^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i)
                col, row, face = match.captures
                place_robot(col.to_i, row.to_i, face)
                puts "ok"
                return self
            when "MOVE"
                move
                return self
            when "REPORT"
                printTable
            else
                puts "invalid command"
                return "invalid command"
        end 
    end

end


# Main function that runs the game and gets user input
# Valid inputs will be
# PLACE x,y,direction
# MOVE
# LEFT
# RIGHT
# REPORT

def play_game
    t = Table.new
    print "> "
    input = gets.chomp
    while (input != "report")
        t.get_command(input)
        print "> "
        input = gets.chomp
    end
    t.printTable
    
end

play_game
