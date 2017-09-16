# Robot class for the Toy Robot Simulator
# Manipulates the robot

class Robot
    attr_accessor :robot_pos, :robot_dir

    def initialize
        @robot_pos = [-1,-1]
        @robot_dir = ""
    end

end