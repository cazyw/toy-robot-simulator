# General constants and printing methods

module Setting

    T_SIZE = 4; # 5x5 grid as tables start from zero
    
    DIRECTION = { "NORTH" => [-1, 0], "SOUTH" => [1, 0], "EAST" => [0, 1], "WEST" => [0, -1] }
    NAV = ["NORTH", "EAST", "SOUTH", "WEST"]

    ERROR_MSG = {
        robot_inactive: "robot hasn't been placed",
        off_table: "Move ignored as the robot will fall off the table",
        invalid_command: "Invalid command. Valid commands are: PLACE <0-#{T_SIZE}>, <0-#{T_SIZE}>, <NORTH|SOUTH|EAST|WEST> | MOVE | LEFT | RIGHT | REPORT",
        invalid_file: "File doesn't exist. Enter a file: "
    }

    def print_intro
        puts "\n" + "=" * 20
        puts "Toy Robot Simulator\n"
        puts "=" * 20
        print "Choose 'file' or 'stdin': "
    end

    def print_instructions
        puts "Enter a command. Valid commands are:"
        puts "\tPLACE <0-#{T_SIZE}>, <0-#{T_SIZE}>, <NORTH|SOUTH|EAST|WEST>"
        puts "\tMOVE"
        puts "\tLEFT"
        puts "\tRIGHT"
        puts "\tREPORT"
        puts "\tEXIT (which will also end the simulator)"
        print "> "
    end

    def print_exit
        puts "=" * 20
        puts "Thanks for playing the Toy Robot Simulator"
        puts "=" * 20

    end

end