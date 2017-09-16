require_relative 'table'
require_relative 'robot'

class Game

    attr_accessor :table, :robot
    T_SIZE = 5;
    @@direction = {
        "NORTH" => [-1, 0], 
        "SOUTH" => [1, 0],
        "EAST" => [0, 1],
        "WEST" => [0, -1]
    }

    def initialize
        @table = Table.new(5)
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
    
    def direction_robot(direction)
        @robot.set_robot_direction(direction)
        return self
    end

    def turn_robot(direction)
    end
end

g = Game.new
g.position_robot(0,0)
g.direction_robot("NORTH")
g.table.print_table
puts g.robot.print_robot
g.position_robot(2, 3)
g.direction_robot("SOUTH")
g.table.print_table
puts g.robot.print_robot