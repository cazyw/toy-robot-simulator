# Robot class for the Toy Robot Simulator
# Monitors the robot
require_relative 'setting'

class Robot
    include Setting
    attr_accessor :robot

    def initialize
        @robot = {
            position: [-1, -1],
            direction: ""
        }
    end

    def robot_active?
        @robot[:position][0] != -1
    end

    def set_robot_position(row, col)
        @robot[:position] = [row, col]
        return self
    end

    def set_robot_direction(direction)
        @robot[:direction] = direction
        return self
    end

    def print_robot
        self.robot_active? ? (puts "Output: #{@robot[:position]} facing #{@robot[:direction]}") : (puts ERROR_MSG[:robot_inactive])
        return self
    end

end
