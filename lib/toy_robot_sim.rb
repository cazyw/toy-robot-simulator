require_relative 'game'
require_relative 'setting'

def play_game
    include Setting
    t = Game.new
    
    print_intro
    choice = gets.chomp.downcase

    # check valid choice
    while !(choice =~ /^(file|stdin)$/)
        print "Choose 'file' or 'stdin': "
        choice = gets.chomp.downcase
    end

    case choice
        # input from the command line
        when "stdin"
            print_instructions
            input = gets.chomp.upcase
            while !(input === "EXIT")
                t.commands(input)
                print "> "
                input = gets.chomp.upcase
            end
    
        # input from a file
        when "file"
            print "Enter a file: "
            file = gets.chomp
            while !File.exists?(file)
                print ERROR_MSG[:invalid_file]
                file = gets.chomp
            end

            File.open(file) do |f|
                instructions = f.readlines
                instructions.each do |x|
                    next if x.chomp == ""
                    t.commands(x.chomp)
                end
            end
    end
    print_exit
end

# execute the file only if run directly from terminal
# prevents the game from automatically running when using test file
if __FILE__ == $0
    play_game
end
