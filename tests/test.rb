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
    end

    def test_input_place_valid
        t = Table.new
        input = "PLACE 0,0,NORTH"
        result = t.get_command(input)
        assert_equal(true, result.is_a?(Table))
        assert_equal([0, 0], result.pos)
        assert_equal("NORTH", result.face)       
    end

    def test_input_place_invalid_direction
        t = Table.new
        input = "PLACE 0,0,UP"
        result = t.get_command(input)
        assert_equal("invalid command", result)       
    end

    def test_input_place_invalid_arguments
        t = Table.new
        input = "PLACE 0,,UP"
        result = t.get_command(input)
        assert_equal("invalid command", result)       
    end


    def test_input_place_places_robot_3_2_west
        t = Table.new
        input = "PLACE 3,2,WEST"
        result = t.get_command(input)
        assert_equal(true, result.is_a?(Table))
        assert_equal([3, 2], result.pos)
        assert_equal("WEST", result.face)      
    end

    def test_input_place_ignores_robot_5_0_north
        t = Table.new
        input = "PLACE 5,0,NORTH"
        result = t.get_command(input)
        assert_equal("invalid command", result)           
    end
    def test_input_report_robot_not_set
        t = Table.new
        input = "REPORT"
        result = t.get_command(input)
        assert_equal("position: [-1, -1] facing directionless", result)         
    end

    def test_input_report_robot_set_to_3_3
        t = Table.new
        input = "PLACE 3,2,NORTH"
        t = t.get_command(input)
        input = "PLACE 3,3,SOUTH"
        t = t.get_command(input)
        input = "REPORT"
        result = t.get_command(input)
        assert_equal("position: [3, 3] facing SOUTH", result)        
    end

    def test_input_report_robot_valid_moves
        t = Table.new
        input = "PLACE 3,2,NORTH"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "REPORT"
        result = t.get_command(input)
        assert_equal("position: [3, 4] facing NORTH", result)        
    end

    def test_input_report_robot_invalid_moves_ignored
        t = Table.new
        input = "PLACE 3,2,NORTH"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "REPORT"
        result = t.get_command(input)
        assert_equal("position: [3, 4] facing NORTH", result)        
    end
    def test_input_report_robot_invalid_moves_ignored_2
        t = Table.new
        input = "PLACE 4,2,EAST"
        t = t.get_command(input)
        input = "MOVE"
        t = t.get_command(input)
        input = "REPORT"
        result = t.get_command(input)
        assert_equal("position: [4, 2] facing EAST", result)        
    end
end