module Setting

    T_SIZE = 4; # assuming start from 0
    DIRECTION = { "NORTH" => [-1, 0], "SOUTH" => [1, 0], "EAST" => [0, 1], "WEST" => [0, -1] }
    NAV = ["NORTH", "EAST", "SOUTH", "WEST"]

    ERROR_MSG = {
        off_table: "Move ignored as the robot will fall off the table",
        invalid_command: "Invalid command. Valid commands are: PLACE <0-#{T_SIZE}>, <0-#{T_SIZE}>, <NORTH|SOUTH|EAST|WEST> | MOVE | LEFT | RIGHT | REPORT"
    }

end