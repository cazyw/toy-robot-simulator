require "./lib/toy_robot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    def test_ToyRobot_grid
        t = ToyRobot.new
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]], t.table)
        assert_equal(true, t.is_a?(ToyRobot))
        assert_equal([-1, -1], t.pos)
        assert_equal("directionless", t.face)
        assert_equal(false, t.robot_placed)
    end

    def test_input_place_valid
        t = ToyRobot.new
        input = "PLACE 0,0,NORTH"
        result = t.get_command(input)
        assert_equal(true, result.is_a?(ToyRobot))
        assert_equal([0, 0], result.pos)
        assert_equal("NORTH", result.face) 
        assert_equal(true, result.robot_placed)      
    end

    def test_input_place_invalid_commands
        t = ToyRobot.new
        input = "PLACE 0,0,UP"
        result = t.get_command(input)
        assert_equal("invalid command", result[1])       
        result = result[0].get_command("PLACE 0,,UP")
        assert_equal("invalid command", result[1])       
    end

    def test_input_place_places_robot_3_2_west
        t = ToyRobot.new
        result = t.get_command("PLACE 3,2,WEST")
        assert_equal(true, result.is_a?(ToyRobot))
        assert_equal([3, 2], result.pos)
        assert_equal("WEST", result.face)      
    end

    def test_input_place_ignores_robot_5_0_north
        t = ToyRobot.new
        result = t.get_command("PLACE 5,0,NORTH")
        assert_equal("invalid command", result[1])           
    end
    
    def test_input_report_robot_not_set
        t = ToyRobot.new
        result = t.get_command("REPORT")
        assert_equal([-1, -1], t.pos)
        assert_equal("directionless", t.face)        
    end

    def test_input_report_robot_set_to_3_3
        t = ToyRobot.new
        t = t.get_command("PLACE 3,2,NORTH")
        t = t.get_command("PLACE 3,3,SOUTH")
        result = t.get_command("REPORT")
        assert_equal([3, 3], t.pos)
        assert_equal("SOUTH", t.face)       
    end

    def test_input_move_robot_valid_moves
        t = ToyRobot.new
        t = t.get_command("PLACE 3,2,NORTH")
        t = t.get_command("MOVE")
        t = t.get_command("MOVE")
        result = t.get_command("REPORT")
        assert_equal([3, 4], t.pos)
        assert_equal("NORTH", t.face)  
    end

    def test_input_move_robot_invalid_moves_ignored
        t = ToyRobot.new
        t = t.get_command("PLACE 3,2,NORTH")
        t = t.get_command("MOVE")
        t = t.get_command("MOVE")
        t = t.get_command("MOVE")
        result = t.get_command("REPORT")
        assert_equal([3, 4], t.pos)
        assert_equal("NORTH", t.face)       

        t = ToyRobot.new
        t = t.get_command("PLACE 4,2,EAST")
        t = t.get_command("MOVE")
        result = t.get_command("REPORT")
        assert_equal([4, 2], t.pos)
        assert_equal("EAST", t.face)        
    end

    def test_input_turn_robot_left
        t = ToyRobot.new
        t = t.get_command("PLACE 4,2,EAST")
        t = t.get_command("LEFT")
        assert_equal("NORTH", t.face)    
        assert_equal([4, 2], t.pos)     
        t = t.get_command("LEFT")
        t = t.get_command("LEFT")
        assert_equal("SOUTH", t.face)
        assert_equal([4, 2], t.pos)  
        t = t.get_command("LEFT")
        assert_equal("EAST", t.face)  
        assert_equal([4, 2], t.pos)          
    end

    def test_input_turn_robot_right
        t = ToyRobot.new
        t = t.get_command("PLACE 3,1,NORTH")
        t = t.get_command("RIGHT")
        assert_equal("EAST", t.face)    
        assert_equal([3, 1], t.pos)         
        t = t.get_command("RIGHT")
        t = t.get_command("RIGHT")
        assert_equal("WEST", t.face)
        assert_equal([3, 1], t.pos)  
        t = t.get_command("RIGHT")
        assert_equal("NORTH", t.face)  
        assert_equal([3, 1], t.pos)          
    end

    def test_file_input_results
        t = ToyRobot.new
        File.open("./tests/robot_commands_1.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                t = t.get_command(x.chomp)
            end
        end
        assert_equal([0, 1], t.pos)
        assert_equal("NORTH", t.face)

        t = ToyRobot.new
        File.open("./tests/robot_commands_2.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                t = t.get_command(x.chomp)
            end
        end
        assert_equal([0, 0], t.pos)
        assert_equal("WEST", t.face)

        t = ToyRobot.new
        File.open("./tests/robot_commands_3.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                t = t.get_command(x.chomp)
            end
        end
        assert_equal([3, 3], t.pos)
        assert_equal("NORTH", t.face)

        t = ToyRobot.new
        File.open("./tests/robot_commands_4.txt") do |f|
            commands = f.readlines
            commands.each do |x|
                next if x.chomp == ""
                t = t.get_command(x.chomp)
            end
        end
        assert_equal([3, 3], t.pos)
        assert_equal("WEST", t.face)
    end
end