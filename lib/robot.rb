# Robot class for the Toy Robot Simulator
# Manipulates the robot

class Robot
    attr_accessor :robot

    def initialize
        @robot = {
            pos: [-1, -1],
            dir: ""
        }
    end

    def robot_active?
        !!@robot[:pos][0] === -1
    end

    def move_robot

    end

    def turn_robot
    end

    def print_robot
        self.robot_active? ? "Output: #{@robot[:pos]} facing #{@robot[:dir]}" : "robot is inactive"
        # puts "Output: #{@robot[:pos]} facing #{@robot[:dir]}"
        # @robot_placed ? "Output: (#{@pos[0]},#{@pos[1]}) facing #{@face}" : "Robot has not been placed yet"
    end

end