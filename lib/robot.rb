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
        @robot[:pos][0] != -1
    end

    def set_robot_position(row, col)
        @robot[:pos] = [row, col]
        return self
    end

    def set_robot_direction(direction)
        @robot[:dir] = direction
        return self
    end

    def print_robot
        self.robot_active? ? "Output: #{@robot[:pos]} facing #{@robot[:dir]}" : "robot is inactive"
    end

end
