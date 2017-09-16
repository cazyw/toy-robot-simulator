require "./lib/robot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    def setup
        @r = Robot.new
    end

    def test_robot_setup
        assert_equal(true, @r.is_a?(Robot))
        assert_equal([-1, -1], @r.robot[:pos])
        assert_equal("", @r.robot[:dir])
    end

    def test_robot_inactive_on_setup
        assert_equal(false, @r.robot_active?)
        assert_equal([-1, -1], @r.robot[:pos])
        assert_equal("", @r.robot[:dir])
    end

    def test_robot_active_on_placed
        @r.set_robot_position(0, 0)
        @r.set_robot_direction("NORTH")
        assert_equal(true, @r.robot_active?)
        assert_equal([0, 0], @r.robot[:pos])
        assert_equal("NORTH", @r.robot[:dir])
        @r.set_robot_position(3, 2)
        @r.set_robot_direction("WEST")
        assert_equal(true, @r.robot_active?)
        assert_equal([3, 2], @r.robot[:pos])
        assert_equal("WEST", @r.robot[:dir])
    end
end