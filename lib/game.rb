require 'table'
require 'robot'

class Game

    attr_accessor :table, :robot
    def initialize
        @table = Table.new
        @robot = Robot.new
    end

end