require_relative 'gameboard.rb'
require_relative 'colorcode.rb'
require_relative 'hint.rb'
require_relative 'computer.rb'

class Mastermind
	attr_accessor :gameboard, :win, :turns, :color_spectrum, :player_mode, :computer

    def initialize 
        @gameboard = GameBoard.new()
        @win = false
        @turns = 1
        @color_spectrum = ["red", "blue", "green", "yellow", "magenta", "white", "cyan"]
        @player_mode = true
        @computer = Computer.new()
    end

    def play
        instructions
        prompt_switch_mode
        set_solution if @player_mode == false
        start
    end

    def instructions
        puts "  __  __            _                     _           _ 
 |  \\/  | __ _  ___| |_  ___  _ _  _ __  (_) _ _   __| |
 | |\\/| |/ _` |(_-<|  _|/ -_)| '_|| '  \\ | || ' \\ / _` |
 |_|  |_|\\__,_|/__/ \\__|\\___||_|  |_|_|_||_||_||_|\\__,_|"
 puts "_________________________________________________________\n\n"
 puts "Guess the code to win!"
 puts "The computer will select a code of four different colors in a specific order"
 puts "You will have 12 guesses"
 @gameboard.display
 puts "_________________________________________________________\n\n"
 puts "The left side is where your guesses will go"
 puts "The right side is where The computers guesses will go"
 puts "Green is the color of the correct guess"
 puts "Red is the color of the incorrect guess"
 puts "/nGood Luck"
 puts "_________________________________________________________\n\n"
    end


    def prompt_switch_mode
        puts "Do you want to play Or do you want the computer to play"
        print "Say \"computer\" or \"me\".\n> "
        puts "You're choices are : red, green, blue, yellow, magenta, cyan and white/n>"
        solutions = get_player_guess
        @gameboard.solution = ColorCode.new(solution[0], solution[1], solution[2], solution[3])
    end

    def start 
        make_guesses 
        turns > 12 ? lose : win
    end

    def make_guesses
        while @win == false && @turns < 13
            prompt_guess
            guess == @player_mode ? get_player_guess : get_computer_guess
            add_guess(guess)
            @win = true if gameboard.guesses[12 - @turns].colors == gameboard.solution.colors
            @turns += 1 if @win == false
        end
    end

    def prompt_guess
        puts @player_mode ? "What is your ##{turns} guess" : "/nComputer, What is your ##{turns} guess"
        puts "Type Four colors seperated by spaces"
        print "You're choices are : red, green, blue, yellow, magenta, cyan and white/n>"
    end


    def get_player_guess
        1. times do 
            guess = gets.chomp.downcase.split(" ")

            if guess.length != 4
                print "\nYou entered the wrong amount of colors! Try again:\n> "
                redo 
            end

            if !color_spectrum.spectrum(guesses[0]) || !color_spectrum.spectrum(guesses[1]) || !color_spectrum.spectrum(guesses[2]) || !color_spectrum.spectrum(guesses[3])
                print "\nYou can only enter the colors specified! Try again:\n> "
                redo
            end

            if @player_mode == false
                if guess.uniq.length !=4
                    print "\nYou must have different colors for the solution! Try again:\n> "
                    redo
                end
            end

            return guess
        end
    end

    def get_computer_guess
        @computer.guess(@gameboard.hints, @hints)
    end

    def add_guess(guess)
        gameboard.guesses[12 - @turns] = ColorCode.new(guess[0], guess[1], guess[2], guess[3])
        gameboard.refresh(12 - @turns)
    end

    def lose 
        puts @player_mode ? "You failed to crack the code." : "Now you are stuck forever in the twilight zone"
        puts "The solution was #{@gameboard.solution.colors}"
    end

    def win 
        puts @player_mode ? "You figured out the code. " : "Now Get us out of this place"
    end
end

game = Mastermind.new()
game.play
