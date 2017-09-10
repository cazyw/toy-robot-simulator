require "./toyRobot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    # test the table is set up 5 x 5
    def test_table_grid
        t = Table.new
        t.table == [["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]]
        assert_equal(true, t.is_a?(Table))
        assert_equal([-1, -1], t.pos)
        assert_equal("directionless", t.face)
        assert_equal(false, t.robot_placed)
    end

    def test_input_place_valid
        t = Table.new
        input = "PLACE 0,0,NORTH"
        result = t.get_command(input)
        assert_equal(true, result.is_a?(Table))
        assert_equal([0, 0], result.pos)
        assert_equal("NORTH", result.face) 
        assert_equal(true, result.robot_placed)      
    end

    def test_input_place_invalid_commands
        t = Table.new
        input = "PLACE 0,0,UP"
        result = t.get_command(input)
        assert_equal("invalid command", result[1])       
        result = result[0].get_command("PLACE 0,,UP")
        assert_equal("invalid command", result[1])       
    end

    def test_input_place_places_robot_3_2_west
        t = Table.new
        result = t.get_command("PLACE 3,2,WEST")
        assert_equal(true, result.is_a?(Table))
        assert_equal([3, 2], result.pos)
        assert_equal("WEST", result.face)      
    end

    def test_input_place_ignores_robot_5_0_north
        t = Table.new
        result = t.get_command("PLACE 5,0,NORTH")
        assert_equal("invalid command", result[1])           
    end
    
    def test_input_report_robot_not_set
        t = Table.new
        result = t.get_command("REPORT")
        assert_equal("Output: -1,-1,directionless", result)         
    end

    def test_input_report_robot_set_to_3_3
        t = Table.new
        t = t.get_command("PLACE 3,2,NORTH")
        t = t.get_command("PLACE 3,3,SOUTH")
        result = t.get_command("REPORT")
        assert_equal("Output: 3,3,SOUTH", result)        
    end

    def test_input_move_robot_valid_moves
        t = Table.new
        t = t.get_command("PLACE 3,2,NORTH")
        t = t.get_command("MOVE")
        t = t.get_command("MOVE")
        result = t.get_command("REPORT")
        assert_equal("Output: 3,4,NORTH", result)        
    end

    def test_input_move_robot_invalid_moves_ignored
        t = Table.new
        t = t.get_command("PLACE 3,2,NORTH")
        t = t.get_command("MOVE")
        t = t.get_command("MOVE")
        t = t.get_command("MOVE")
        result = t.get_command("REPORT")
        assert_equal("Output: 3,4,NORTH", result)        

        t = Table.new
        t = t.get_command("PLACE 4,2,EAST")
        t = t.get_command("MOVE")
        result = t.get_command("REPORT")
        assert_equal("Output: 4,2,EAST", result)        
    end

    def test_input_turn_robot_left
        t = Table.new
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
        t = Table.new
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
end