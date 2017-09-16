require "./lib/robot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    def setup
        # @t = ToyRobot.new
        @r = Robot.new
    end

    def test_robot_setup
        assert_equal(true, @r.is_a?(Robot))
        assert_equal([-1, -1], @r.robot[:pos])
        assert_equal("", @r.robot[:dir])
    end

    def test_robot_active
        assert_equal(false, @r.robot_active?)
        assert_equal("robot is inactive", @r.print_robot)
    end


end