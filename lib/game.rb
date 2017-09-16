require_relative 'table'
require_relative 'robot'

class Game

    attr_accessor :table, :robot
    T_SIZE = 5;
    def initialize
        @table = Table.new(5)
        @robot = Robot.new
    end



    def place_robot(row, col, direction)
        # check if the robot has already been placed 
        if @robot.robot_active?
            puts "Already placed"
            @table.piece_removed(@robot.robot[:pos])
        end

        # the starting position is (0,0) in the south west corner
        # mod needed to account for starting in bottom left corner
        # modrow = (row-4).abs

        @table.piece_added([row, col])
        @robot.set_robot_position(row, col)
        @robot.set_robot_direction(direction)
        return self
    end
end

g = Game.new
g.place_robot(0,0,"NORTH")
g.table.print_table
puts g.robot.print_robot
g.place_robot(2, 3,"EAST")
g.table.print_table
puts g.robot.print_robot