require_relative 'table'
require_relative 'robot'
require_relative 'setting'

# Game class for the Toy Robot Simulator
# Plays the game

class Game
    include Setting
    attr_accessor :table, :robot
    
    def initialize
        @table = Table.new(TABLE_SIZE + 1) # table starts from 0
        @robot = Robot.new
    end
    
    def position_robot(col, row, direction)
        if @robot.robot_active?
            @table.piece_removed(@robot.robot[:position])
        end
        @table.piece_added([col, row])
        @robot.set_robot_position(col, row)
        @robot.set_robot_direction(direction)
        return self
    end
    
    def turn_robot(turn)
        if @robot.robot_active?
            direction_index = ORIENTATION.index(@robot.robot[:direction])
            case turn
                when "LEFT"
                    direction_index === 0 ? direction_index = TABLE_SIZE - 1 : direction_index -= 1
                when "RIGHT"
                    direction_index === TABLE_SIZE - 1 ? direction_index = 0 : direction_index += 1
            end
            @robot.set_robot_direction(ORIENTATION[direction_index])
        else
            puts ERROR_MSG[:robot_inactive]
        end
        return self
    end
    
    def move_robot
        if @robot.robot_active?
            moveY = DIRECTION[@robot.robot[:direction]][0]
            moveX = DIRECTION[@robot.robot[:direction]][1]
            curX = @robot.robot[:position][0]
            curY = @robot.robot[:position][1]
    
            # check if the move takes it out of bounds
            if (curX + moveX > TABLE_SIZE || curY - moveY > TABLE_SIZE ||
                curX + moveX < 0 || curY - moveY < 0)
                puts ERROR_MSG[:off_table]
            else
                position_robot(curX + moveX, curY - moveY, @robot.robot[:direction])
            end
        else
            puts ERROR_MSG[:robot_inactive]
        end
        return self
    end

    def show_table
        @table.print_table
        return self
    end

    def show_robot
        @robot.print_robot
        return self
    end

    def commands(command)
        command = command.upcase
        placing = command.match(/^PLACE *([0-#{TABLE_SIZE}]), *([0-#{TABLE_SIZE}]), *(NORTH|SOUTH|EAST|WEST)$/i)
        unless (placing === nil)
            col, row, direction = placing.captures
            command = "PLACED"
        end
        case command
            when "PLACED" 
                position_robot(col.to_i, row.to_i, direction)
            when "MOVE"
                move_robot      
            when "LEFT"
                turn_robot("LEFT")
            when "RIGHT"
                turn_robot("RIGHT")
            when "REPORT"
                show_robot
                show_table
                
            else
                puts ERROR_MSG[:invalid_command]
        end 
        return self
    end
end
