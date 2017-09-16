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


    def position_robot(row, col)
        # check if the robot has already been placed 
        if @robot.robot_active?
            puts "Already placed"
            @table.piece_removed(@robot.robot[:pos])
        end
        @table.piece_added([row, col])
        @robot.set_robot_position(row, col)
        return self
    end

    def turn_robot(turn)
        if @robot.robot_active?
            new_d_index = @@nav.index(@robot.robot[:dir])
            case turn
                when "LEFT"
                    new_d_index === 0 ? new_d_index = T_SIZE - 1 : new_d_index -= 1
                when "RIGHT"
                    new_d_index === T_SIZE ? new_d_index = 0 : new_d_index += 1
            end
            @robot.set_robot_direction(@@nav[new_d_index])
        end
        return self
    end
end

g = Game.new
g.position_robot(0,0)
g.robot.set_robot_direction("NORTH")
g.table.print_table
puts g.robot.print_robot
g.position_robot(2, 3)
g.robot.set_robot_direction("SOUTH")
g.table.print_table
puts g.robot.print_robot
g.turn_robot("LEFT")
puts g.robot.print_robot