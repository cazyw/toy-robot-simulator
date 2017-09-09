require "./toyRobot.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    # test the table is set up 5 x 5
    def test_table_setup
        t = Table.new
        t == [["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]]
    end
end