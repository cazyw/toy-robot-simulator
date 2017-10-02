$: << "../lib"
require "game"
require "test/unit"

class TestGame < Test::Unit::TestCase

    def setup
        @game = Game.new
    end

    def test_game_setup
        assert_equal(true, @game.is_a?(Game))
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]], @game.table.print_table)
        assert_equal([-1, -1], @game.robot.robot[:position])
        assert_equal("", @game.robot.robot[:direction])
        # assert_equal()
    end
    
    def test_robot_position_valid
        @game.position_robot(0, 0, "NORTH")
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["O", "x", "x", "x", "x"]], @game.table.print_table)
        assert_equal([0, 0], @game.robot.robot[:position])
        @game.position_robot(4, 1, "NORTH")
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "O"], ["x", "x", "x", "x", "x"]], @game.table.print_table)
        assert_equal([4, 1], @game.robot.robot[:position])
        @game.position_robot(1, 3, "NORTH")
        assert_equal([["x", "x", "x", "x", "x"], ["x", "O", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]], @game.table.print_table)
        assert_equal([1, 3], @game.robot.robot[:position])
    end

    def test_robot_turn
        @game.position_robot(3, 2, "NORTH")
        @game.turn_robot("LEFT")
        assert_equal("WEST", @game.robot.robot[:direction])
        @game.turn_robot("LEFT")
        assert_equal("SOUTH", @game.robot.robot[:direction])
        @game.turn_robot("LEFT")
        assert_equal("EAST", @game.robot.robot[:direction])
        @game.turn_robot("LEFT")
        assert_equal("NORTH", @game.robot.robot[:direction])
        @game.turn_robot("LEFT")
        assert_equal("WEST", @game.robot.robot[:direction])

        @game.turn_robot("RIGHT")
        assert_equal("NORTH", @game.robot.robot[:direction])
        @game.turn_robot("RIGHT")
        assert_equal("EAST", @game.robot.robot[:direction])
        @game.turn_robot("RIGHT")
        assert_equal("SOUTH", @game.robot.robot[:direction])
        @game.turn_robot("RIGHT")
        assert_equal("WEST", @game.robot.robot[:direction])
        @game.turn_robot("RIGHT")
        assert_equal("NORTH", @game.robot.robot[:direction])
    end

    def test_robot_move
        @game.position_robot(3, 2, "NORTH")
        @game.move_robot
        assert_equal("NORTH", @game.robot.robot[:direction])
        assert_equal([3, 3], @game.robot.robot[:position])
        @game.move_robot
        assert_equal("NORTH", @game.robot.robot[:direction])
        assert_equal([3, 4], @game.robot.robot[:position])
        @game.move_robot
        assert_equal("NORTH", @game.robot.robot[:direction])
        assert_equal([3, 4], @game.robot.robot[:position])
    end

    def test_commands_valid
        @game.commands("PLACE 0, 0, NORTH")
        assert_equal("NORTH", @game.robot.robot[:direction])
        assert_equal([0, 0], @game.robot.robot[:position])
        @game.commands("MOVE")
        assert_equal("NORTH", @game.robot.robot[:direction])
        assert_equal([0, 1], @game.robot.robot[:position])
        @game.commands("RIGHT")
        assert_equal("EAST", @game.robot.robot[:direction])
        assert_equal([0, 1], @game.robot.robot[:position])
        @game.commands("LEFT")
        assert_equal("NORTH", @game.robot.robot[:direction])
        assert_equal([0, 1], @game.robot.robot[:position])
        @game.commands("REPORT")
        assert_equal([0, 1], @game.robot.robot[:position])
        assert_equal("NORTH", @game.robot.robot[:direction])
    end

    def test_commands_invalid
        # bad commands do nothing
        @game.commands("MOVE") 
        assert_equal([-1, -1], @game.robot.robot[:position])
        assert_equal("", @game.robot.robot[:direction])
        @game.commands("LEFT") 
        assert_equal([-1, -1], @game.robot.robot[:position])
        assert_equal("", @game.robot.robot[:direction])
        @game.commands("RIGHT") 
        assert_equal([-1, -1], @game.robot.robot[:position])
        assert_equal("", @game.robot.robot[:direction])

        @game.commands("PLACE 0, 1, NORTH")
        @game.commands("PLACE 3, 2, NOWHERE")
        assert_equal([0, 1], @game.robot.robot[:position])
        assert_equal("NORTH", @game.robot.robot[:direction])
        @game.commands("PLACE 3, 5, WEST")
        assert_equal([0, 1], @game.robot.robot[:position])
        assert_equal("NORTH", @game.robot.robot[:direction])
        @game.commands("RANDOM")
        assert_equal([0, 1], @game.robot.robot[:position])
        assert_equal("NORTH", @game.robot.robot[:direction])
        @game.commands("MOVEE")
        assert_equal([0, 1], @game.robot.robot[:position])
        assert_equal("NORTH", @game.robot.robot[:direction])
    end

end