class Computer 
    attr_accessor :color_spectrum, :guess_set, :correct_colors

    def initialize
        @color_spectrum = ["red", "blue", "green", "yellow", "magenta", "white", "cyan"]
        @guess_set = 0
        @correct_colors = []
    end

    def guess(hints, turns)
        computer_guess = get_guess(hints, turns)
        print "#{computer_guesses(0)}, #{computer_guesses(1)}, #{computer_guesses(2)}, #{computer_guesses(3)}/n"
        computer_guess
    end

    def get_guess(hints, turns)
        computer_guess = []
        if @correct_guess.uniq.length != 4
            case turn  
            
            when 1
                
                4.times { computer_guess << @color_spectrum[@guess_set] }

            when (2..8)

                4.times { computer_guess << @color_spectrum[@guess_set] }
                @correct_colors << @color_spectrum[@guess_set - 1] if color_is_correct(hints, turn)
                @guess_set += 1 if @guess_set < 8

            when 9 

                @correct_colors << @color_spectrum[@guess_set - 1] if color_is_correct(hints, turn)
                computer_guess = @correct_colors
                @correct_colors = @correct_colors.shuffle
            end

            else
                computer_guess = @correct_colors
                @correct_colors = @correct_colors.shuffle
            end
            computer_guess
        end

        def color_is_correct(hints, turn)
            hints[12 - turn + 1].colors[0] == "green"
        end
    end
