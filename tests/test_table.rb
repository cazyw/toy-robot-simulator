require "./lib/table.rb"
require "test/unit"

class TestRobot < Test::Unit::TestCase

    def setup
        # @t = ToyRobot.new
        @t = Table.new
    end

    def test_table_setup
        assert_equal(true, @t.is_a?(Table))
        assert_equal([["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]], @t.table)
    end

    def test_table_add_piece
        table = [["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["O", "x", "x", "x", "x"]]
        @t.pieceAdded([0, 0])
        assert_equal(table, @t.printTable)
    end

    def test_table_remove_piece
        table = [["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "O", "x"], ["x", "x", "x", "x", "x"], ["x", "x", "x", "x", "x"]]
        @t.pieceAdded([0, 0])
        @t.pieceRemoved([0, 0])
        @t.pieceAdded([3, 2])

        assert_equal(table, @t.printTable)
    end

end