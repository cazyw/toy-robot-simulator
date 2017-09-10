# Toy Robot Simulator
# the function play_game runs the game.
# The game ends when REPORT is entered

class ToyRobot
    attr_reader :table, :pos, :face, :robot_placed

    # Setup the table and robot
    def initialize
        @table = Array.new(5) { Array.new(5, "x") }
        @pos = [-1,-1]
        @face = "directionless"
        @robot_placed = false
    end

    def place_robot(col, row, direction)

        # there's already a game underway re-mark the square with 'x'
        if @robot_placed
            @table[(@pos[1]-4).abs][@pos[0]] = "x"
        end

        # the starting position is (0,0) in the south west corner
        # to account for starting in bottom left corner
        modrow = (row-4).abs

        @table[modrow][col] = "O"
        @pos = [col, row]
        @face = direction
        @robot_placed = true
        return self
    end

    def move
        # check if robot placed yet
        if !(@robot_placed)
            return self
        end

        # values to change the robot position on the board (visual representation)
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
   
        # check if the move takes it out of bounds
        if (curX + moveX > 4 || curY - moveY > 4 ||
            curX + moveX < 0 || curY - moveY < 0)
            puts "Move ignored as the robot will move off the table"
        else
            @table[(curY-4).abs][curX] = "x"
            @pos[1] -= moveY
            @pos[0] += moveX
            @table[(@pos[1]-4).abs][@pos[0]] = "O"
        end
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
            when "right"
                val = nav.index(@face) + 1
                # to wrap the direction
                if val === 4
                    val = 0
                end
                @face = nav[val]
            else
        end
        return self
    end

    def game_status
        puts @table.map { |x| x.join(" ") }
        puts "Output: (#{@pos[0]},#{@pos[1]}) facing #{@face}"
        @robot_placed ? "Output: (#{@pos[0]},#{@pos[1]}) facing #{@face}" : "Robot has not been placed yet"
    end

    def get_command(command)
        command = command.upcase
        case command
            when /^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i 
                match = command.match(/^PLACE *([0-4]), *([0-4]), *(NORTH|SOUTH|EAST|WEST)$/i)
                col, row, face = match.captures
                place_robot(col.to_i, row.to_i, face)
            when "MOVE"
                move      
            when "LEFT"
                turn("left")
            when "RIGHT"
                turn("right")
            when "REPORT"
                game_status
            else
                puts "#{command} is an invalid command. Try again."
                return [self, "invalid command"]
        end 
        return self
    end

end


# Main function that runs the game and either
# gets input from the command line or
# gets input from a file

# Valid inputs will be
# PLACE x,y,direction
# MOVE
# LEFT
# RIGHT
# REPORT

def play_game
    
    t = ToyRobot.new
    puts "Toy Robot Simulator"
    puts "=" * 10
    print "Choose 'file' or 'stdin': "
    choice = gets.chomp.downcase

    # check valid choice
    while !(choice =~ /^(file|stdin)$/)
        print "Choose 'file' or 'stdin': "
        choice = gets.chomp.downcase
    end

    case choice
        # input from the command line
        when "stdin"
            print "> "
            input = gets.chomp.upcase
            while (!(input == "REPORT" && t.robot_placed))
                t.get_command(input)
                print "> "
                input = gets.chomp.upcase
            end
            t.game_status
    
        # input from a file
        when "file"
            print "Enter a file > "
            file = gets.chomp
            while (!File.exists?(file))
                print "File doesn't exist. Enter a file > "
                file = gets.chomp
            end

            File.open(file) do |f|
                commands = f.readlines
                commands.each do |x|
                    next if x.chomp == ""
                    t.get_command(x.chomp)
                end
            end
    end
end

# execute the file only if run directly from terminal
# prevents the game from automatically running when using test file
if __FILE__ == $0
    play_game
end
