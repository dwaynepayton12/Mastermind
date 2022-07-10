class ColorCode 
    attr_accessor :colors, :selected_color

    def initialize(color1=random, color2=random, color3=random, color4=random)
        @colors = [color1, color2, color3, color4]
    end

    def random
        color_spectrum = ["red", "blue", "green", "yellow", "magenta", "white", "cyan"]
        random = color_spectrum.sample
        @selected_colors ||= []
        until !@selected_colors.include?(random)
            random = color_spectrum.sample
        end
        @selected_colors << random
		random
    end
end
