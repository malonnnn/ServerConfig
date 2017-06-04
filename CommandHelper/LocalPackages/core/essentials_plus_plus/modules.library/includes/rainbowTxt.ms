# Takes a string of text and returns it with random color codes to be used with colorize()
proc(_rainbowText, @textToColorize, 

    @tempText = string(@textToColorize);
    @tempTextSize = length(@tempText);
    
    @rainbowText = ''; # Placeholder for finalized string
    
    for (@i = 0, @i < @tempTextSize, @i++) {
    
        @rainbowText = @rainbowText.'&'.rand(1, 9).@tempText[@i]; # Build the rainbow string
    
    }
    
    @rainbowText = @rainbowText.'&r'; # Add the reset tag at the end

    return(@rainbowText); # Pass back the finished product
    
)