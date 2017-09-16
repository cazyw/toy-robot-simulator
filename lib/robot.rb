# Robot class for the Toy Robot Simulator
# Monitors the robot
require_relative 'setting'

class Robot
    include Setting
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
        self.robot_active? ? (puts "Output: #{@robot[:pos]} facing #{@robot[:dir]}") : (puts ERROR_MSG[:robot_inactive])
        return self
    end

end
