require_relative 'table'
require_relative 'robot'

class Game

    attr_accessor :table, :robot
    T_SIZE = 4; # assuming start from 0
    @@direction = {
        "NORTH" => [-1, 0], 
        "SOUTH" => [1, 0],
        "EAST" => [0, 1],
        "WEST" => [0, -1]
    }
    @@nav = ["NORTH", "EAST", "SOUTH", "WEST"]

    def initialize
        @table = Table.new(T_SIZE + 1) # table started from 0
        @robot = Robot.new
    end


    def position_robot(col, row)
        # check if the robot has already been placed 
        if @robot.robot_active?
            puts "Already placed"
            @table.piece_removed(@robot.robot[:pos])
        end
        @table.piece_added([col, row])
        @robot.set_robot_position(col, row)
        return self
    end

    def turn_robot(turn)
        if @robot.robot_active?
            dir_index = @@nav.index(@robot.robot[:dir])
            case turn
                when "LEFT"
                    dir_index === 0 ? dir_index = T_SIZE - 1 : dir_index -= 1
                when "RIGHT"
                    dir_index === T_SIZE ? dir_index = 0 : dir_index += 1
            end
            @robot.set_robot_direction(@@nav[dir_index])
        end
        return self
    end

    def move_robot
        moveY = @@direction[@robot.robot[:dir]][0]
        moveX = @@direction[@robot.robot[:dir]][1]
        curX = @robot.robot[:pos][0]
        curY = @robot.robot[:pos][1]
   
        # check if the move takes it out of bounds
        if (curX + moveX > T_SIZE || curY - moveY > T_SIZE ||
            curX + moveX < 0 || curY - moveY < 0)
            puts "Move ignored as the robot will fall off the table"
        else
            position_robot(curX + moveX, curY - moveY)
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
end

g = Game.new
g.position_robot(0,0)
g.robot.set_robot_direction("NORTH")
g.show_table
g.show_robot
g.position_robot(2, 3)
g.robot.set_robot_direction("SOUTH")
g.show_table
g.show_robot
g.turn_robot("LEFT")
g.show_robot
g.move_robot
g.show_table
g.show_robot
g.turn_robot("RIGHT")
g.show_robot
g.move_robot
g.show_table
g.show_robot