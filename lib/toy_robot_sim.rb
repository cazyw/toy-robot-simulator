require_relative 'game'

def play_game

    t = Game.new
    
    puts "Toy Robot Simulator"
    puts "=" * 10
    print "Choose 'file' or 'stdin': "
    choice = gets.chomp.downcase

    # check valid choice
    while !(choice =~ /^(file|stdin)$/)
        print "Choose 'file' or 'stdin': "
        choice = gets.chomp.downcase
    end

    case choice
        # input from the command line
        when "stdin"
            print "> "
            input = gets.chomp.upcase
            while (!(input == "REPORT" && t.robot_placed))
                t.get_command(input)
                print "> "
                input = gets.chomp.upcase
            end
            t.game_status
    
        # input from a file
        when "file"
            print "Enter a file > "
            file = gets.chomp
            while (!File.exists?(file))
                print "File doesn't exist. Enter a file > "
                file = gets.chomp
            end

            File.open(file) do |f|
                commands = f.readlines
                commands.each do |x|
                    next if x.chomp == ""
                    t.get_command(x.chomp)
                end
            end
    end
end

# execute the file only if run directly from terminal
# prevents the game from automatically running when using test file
if __FILE__ == $0
    play_game
end
