$: << "../lib"
require "game"
require "test/unit"

class TestGame < Test::Unit::TestCase

    def setup
        # @t = ToyRobot.new
        @game = Game.new
    end

    def test_game_setup
        assert_equal(true, @game.is_a?(Game))
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]], @game.table.print_table)
    end

end