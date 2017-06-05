# --------------------------------------------------------------------------
# Take a string and randomly add color codes to each letter that can be used
# with a colorize() function
# --------------------------------------------------------------------------

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