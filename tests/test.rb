require "./toyRobot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    # test the table is set up 5 x 5
    def test_table_grid
        t = Table.new
        t == [["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]]
        assert_equal(true, t.is_a?(Table))
    end

    def test_input_place_valid
        # t = Table.new
        input = "PLACE 0,0,NORTH"
        result = get_command(input)
        assert_equal("ok", result)       
    end
    def test_input_place_invalid_direction
        # t = Table.new
        input = "PLACE 0,0,UP"
        result = get_command(input)
        assert_equal("invalid command", result)       
    end
    def test_input_place_invalid_arguments
        # t = Table.new
        input = "PLACE 0,,UP"
        result = get_command(input)
        assert_equal("invalid command", result)       
    end
end