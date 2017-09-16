require "./lib/robot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    def setup
        # @t = ToyRobot.new
        @r = Robot.new
    end

    def test_table_setup
        assert_equal(true, @r.is_a?(Robot))
        assert_equal([-1, -1], @r.robot_pos)
        assert_equal("", @r.robot_dir)
    end



end