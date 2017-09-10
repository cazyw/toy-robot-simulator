require "./lib/toy_robot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    def setup
        @t = ToyRobot.new
    end

    def test_ToyRobot_setup
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]], @t.table)
        assert_equal(true, @t.is_a?(ToyRobot))
        assert_equal([-1, -1], @t.pos)
        assert_equal("directionless", @t.face)
        assert_equal(false, @t.robot_placed)
    end

    def test_input_place_valid
        result = @t.get_command("PLACE 0,0,NORTH")
        assert_equal(true, result.is_a?(ToyRobot))
        assert_equal([0, 0], result.pos)
        assert_equal("NORTH", result.face) 
        assert_equal(true, result.robot_placed) 
        
        result = @t.get_command("PLACE 2, 1, SOUTH")
        assert_equal(true, result.is_a?(ToyRobot))
        assert_equal([2, 1], result.pos)
        assert_equal("SOUTH", result.face) 
        assert_equal(true, result.robot_placed) 

        result = @t.get_command("place 3, 2, east")
        assert_equal(true, result.is_a?(ToyRobot))
        assert_equal([3, 2], result.pos)
        assert_equal("EAST", result.face) 
        assert_equal(true, result.robot_placed) 

        # place twice
        result = @t.get_command("PLACE 3,2,WEST")
        result = result.get_command("PLACE 2,0,NORTH")
        assert_equal(true, result.is_a?(ToyRobot))
        assert_equal([2, 0], result.pos)
        assert_equal("NORTH", result.face)  
    end

    def test_input_place_invalid_commands
        result = @t.get_command("PLACE 0,0,UP")
        assert_equal("invalid command", result[1]) 
              
        result = @t.get_command("PLACE 0,,EAST")
        assert_equal("invalid command", result[1])

        result = @t.get_command("PLACE 0,5,NORTH")
        assert_equal("invalid command", result[1])  

        result = @t.get_command("PLACE 5,0,NORTH")
        assert_equal("invalid command", result[1]) 

        result = @t.get_command("PLACE -1,0,NORTH")
        assert_equal("invalid command", result[1]) 
    end
    
    def test_input_report_robot_not_set
        result = @t.get_command("REPORT")
        assert_equal([-1, -1], @t.pos)
        assert_equal("directionless", @t.face)  
        
        result = @t.get_command("MOVE")
        assert_equal([-1, -1], @t.pos)
        assert_equal("directionless", @t.face)  

        result = @t.get_command("LEFT")
        assert_equal([-1, -1], @t.pos)
        assert_equal("directionless", @t.face)  

        result = @t.get_command"(RIGHT")
        assert_equal([-1, -1], @t.pos)
        assert_equal("directionless", @t.face)  
    end


    def test_input_move_robot_valid_moves
        @t = @t.get_command("PLACE 3,2,NORTH")
        @t = @t.get_command("MOVE")
        @t = @t.get_command("MOVE")
        result = @t.get_command("REPORT")
        assert_equal([3, 4], @t.pos)
        assert_equal("NORTH", @t.face)  
    end

    def test_input_move_robot_invalid_moves_ignored
        @t = @t.get_command("PLACE 3,2,NORTH")
        @t = @t.get_command("MOVE")
        @t = @t.get_command("MOVE")
        @t = @t.get_command("MOVE")
        result = @t.get_command("REPORT")
        assert_equal([3, 4], @t.pos)
        assert_equal("NORTH", @t.face)       

        @t = @t.get_command("PLACE 4,2,EAST")
        @t = @t.get_command("MOVE")
        result = @t.get_command("REPORT")
        assert_equal([4, 2], @t.pos)
        assert_equal("EAST", @t.face)        
    end

    def test_input_turn_robot_left
        @t = @t.get_command("PLACE 4,2,EAST")
        @t = @t.get_command("LEFT")
        assert_equal("NORTH", @t.face)    
        assert_equal([4, 2], @t.pos) 

        @t = @t.get_command("LEFT")
        @t = @t.get_command("LEFT")
        assert_equal("SOUTH", @t.face)
        assert_equal([4, 2], @t.pos)  

        @t = @t.get_command("LEFT")
        assert_equal("EAST", @t.face)  
        assert_equal([4, 2], @t.pos)          
    end

    def test_input_turn_robot_right
        @t = @t.get_command("PLACE 3,1,NORTH")
        @t = @t.get_command("RIGHT")
        assert_equal("EAST", @t.face)    
        assert_equal([3, 1], @t.pos)  

        @t = @t.get_command("RIGHT")
        @t = @t.get_command("RIGHT")
        assert_equal("WEST", @t.face)
        assert_equal([3, 1], @t.pos)  

        @t = @t.get_command("RIGHT")
        assert_equal("NORTH", @t.face)  
        assert_equal([3, 1], @t.pos)          
    end

    def test_file_input_results
        File.open("./tests/robot_commands_1.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                @t = @t.get_command(x.chomp)
            end
        end
        assert_equal([0, 1], @t.pos)
        assert_equal("NORTH", @t.face)

        @t = ToyRobot.new
        File.open("./tests/robot_commands_2.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                @t = @t.get_command(x.chomp)
            end
        end
        assert_equal([0, 0], @t.pos)
        assert_equal("WEST", @t.face)

        @t = ToyRobot.new
        File.open("./tests/robot_commands_3.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                @t = @t.get_command(x.chomp)
            end
        end
        assert_equal([3, 3], @t.pos)
        assert_equal("NORTH", @t.face)

        @t = ToyRobot.new
        File.open("./tests/robot_commands_4.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                @t = @t.get_command(x.chomp)
            end
        end
        assert_equal([3, 3], @t.pos)
        assert_equal("WEST", @t.face)
    end
end