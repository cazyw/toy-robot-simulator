require_relative 'table'
require_relative 'robot'
require_relative 'setting'

# Game class for the Toy Robot Simulator
# Plays the game

class Game
    include Setting
    attr_accessor :table, :robot
    

    def initialize
        @table = Table.new(T_SIZE + 1) # table starts from 0
        @robot = Robot.new
    end

    def position_robot(col, row)
        if @robot.robot_active?
            @table.piece_removed(@robot.robot[:pos])
        end
        @table.piece_added([col, row])
        @robot.set_robot_position(col, row)
        return self
    end

    def turn_robot(turn)
        if @robot.robot_active?
            dir_index = NAV.index(@robot.robot[:dir])
            case turn
                when "LEFT"
                    dir_index === 0 ? dir_index = T_SIZE - 1 : dir_index -= 1
                when "RIGHT"
                    dir_index === T_SIZE ? dir_index = 0 : dir_index += 1
            end
            @robot.set_robot_direction(NAV[dir_index])
        end
        return self
    end

    def move_robot
        if @robot.robot_active?
            moveY = DIRECTION[@robot.robot[:dir]][0]
            moveX = DIRECTION[@robot.robot[:dir]][1]
            curX = @robot.robot[:pos][0]
            curY = @robot.robot[:pos][1]
    
            # check if the move takes it out of bounds
            if (curX + moveX > T_SIZE || curY - moveY > T_SIZE ||
                curX + moveX < 0 || curY - moveY < 0)
                puts ERROR_MSG[:off_table]
            else
                position_robot(curX + moveX, curY - moveY)
            end
        end
        return self
    end

    def show_table
        @table.print_table
        return self
    end

    def show_robot
        puts @robot.print_robot
        return self
    end

    def commands(command)
        command = command.upcase
        placing = command.match(/^PLACE *([0-#{T_SIZE}]), *([0-#{T_SIZE}]), *(NORTH|SOUTH|EAST|WEST)$/i)
        unless (placing === nil)
            col, row, direction = placing.captures
            command = "PLACED"
        end
        case command
            when "PLACED" 
                position_robot(col.to_i, row.to_i)
                @robot.set_robot_direction(direction)
            when "MOVE"
                move_robot      
            when "LEFT"
                turn_robot("LEFT")
            when "RIGHT"
                turn_robot("RIGHT")
            when "REPORT"
                show_robot
            else
                puts ERROR_MSG[:invalid_command]
        end 
        return self
    end
end
