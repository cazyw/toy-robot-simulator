# Toy Robot Simulator

class Table
    attr_reader :table, :pos, :face, :robot_placed

    # Setup the table
    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
        @pos = [-1,-1]
        @face = "directionless"
        @robot_placed = false
        puts "Initialise table"
        printTable
    end

    def place_robot(col, row, face)

        # there's already a game underway
        if @robot_placed
            @table[(@pos[1]-4).abs][@pos[0]] = "x"
        end

        # to account for starting in bottom left corner
        modrow = (row-4).abs
        @table[modrow][col] = "O"
        @pos = [col, row]
        @face = face
        @robot_placed = true
        printTable  
        return self
    end

    def move
        # check if robot placed yet
        if !(@robot_placed)
            return self
        end

        # values to change the robot on the board (visual representation)
        direction = {
            "NORTH" => [-1, 0], 
            "SOUTH" => [1, 0],
            "EAST" => [0, 1],
            "WEST" => [0, -1]
        }
        moveY = direction[@face][0]
        moveX = direction[@face][1]
        curX = @pos[0]
        curY = @pos[1]
   
        # check if move takes it out of bounds
        if (curX + moveX > 4 || curY - moveY > 4 ||
            curX + moveX < 0 || curY - moveY < 0)
            puts "out of bounds"
        else
            @table[(curY-4).abs][curX] = "x"
            @pos[1] -= moveY
            @pos[0] += moveX
            @table[(@pos[1]-4).abs][@pos[0]] = "O"
            puts "valid move"
        end
        printTable
        return self
    end

    def turn(direction)
        
        # check if robot placed yet
        if !(@robot_placed)
            return self
        end

        nav = ["NORTH", "EAST", "SOUTH", "WEST"]
        case direction
            when "left"
                val = nav.index(@face) - 1
                # to wrap the direction
                if val === -1
                    val = 3
                end
                @face = nav[val]
            else
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
            when "LEFT"
                turn("left")
                return self
            when "REPORT"
                printTable
            else
                puts "invalid command"
                return [self, "invalid command"]
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

# play_game
