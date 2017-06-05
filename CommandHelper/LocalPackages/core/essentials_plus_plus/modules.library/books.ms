# --------------------------------------------------------------------------
# Functions to /copybook, /sendbook, /signbook
# --------------------------------------------------------------------------

register_command(copybook, 

    array(   

        description: 'Creates a duplicate copy of the book held in the players hand',        

        usage: '/copybook',
        
        permission: 'essentials.copybook',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) > 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /copybook [number of copies]');
                die(); # No need to go further					
            
            }

            @numberOfCopies = 1; # Assume we are making 1 copy
            
            try {
            
                @numberOfCopies = integer(@args[0]); # Grab the requested number of copies
                
                if (@numberOfCopies > 64) {
                
                    msg(''.color(RED).'Number of Copies Must be Between 1-64');
                    die(); # Done
                
                }				
                
            } catch (CastException @ErrorInfo) {
            
                msg(''.color(RED).'Improper Usage! Number of Copies must be a Number between 1-64');
                die(); # Done
            
            } catch (IndexOverflowException @ErrorInfo) {
            
                @numberOfCopies = 1; # Player didnt specify how many copies, Create 1			
            
            }

            @playerThatRanCmd = player(); # Create a player object
            
            @allowedBooks = array(340, 386, 387, 403); # Id's of each type of book allowed
            @slotHighlighted = pheld_slot(@playerThatRanCmd)
            @itemInHand = pinv(@playerThatRanCmd, @slotHighlighted)[type]; # Grab the ID of the item in the players hand
            
            if(array_contains(@allowedBooks, @itemInHand)){
            
                @itemMeta =  get_itemmeta(@slotHighlighted); # Grab the meta data
                pgive_item(@playerThatRanCmd, @itemInHand, @numberOfCopies, @itemMeta); # Create the copies and give it to the player
                die(); # All done				
            
            } else {
            
                msg('The Item you are Holding must be a Book'); # Scold the player for wasting time
                die(); # Finished
            
            }			

        }
    )
)

register_command(sendbook, 

    array(
    
        description: 'Send a book to another Player',
        
        usage: '/sendbook <player>',
        
        permission: 'essentials.sendbook',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /sendbook <player>');
                die(); # No need to go further					
            
            }

            @playerThatRanCmd = player(); # Create a player object
            @playerToSendTo = @args[0]; # Recipient
            
            @allowedBooks = array(340, 386, 387, 403); # Id's of each type of book allowed
            @slotHighlighted = pheld_slot(@playerThatRanCmd)
            @itemInHand = pinv(@playerThatRanCmd, @slotHighlighted)[type]; # Grab the ID of the item in the players hand
            
            if(array_contains(@allowedBooks, @itemInHand)){
            
                @itemMeta =  get_itemmeta(@slotHighlighted); # Grab the meta data
				tmsg(@playerThatRanCmd, 'You have sent '.@playerToSendTo.' a copy of the book you are holding')
                pgive_item(@playerToSendTo, @itemInHand, 1, @itemMeta); # Create the copy and give it to the player
				tmsg(@playerToSendTo, 'You have been given a book from '.@playerThatRanCmd)
                
                die(); # All done				
            
            } else {
            
                msg('The Item you are Holding must be a Book'); # Scold the player for wasting time
                die(); # Finished
            
            }            
        
        }
    )
)

register_command(signbook, 

    array(   

        description: 'Re-signs a written book',        

        usage: '/signbook <signature>',
        
        permission: 'essentials.signbook',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {	
            
        
            if (array_size(@args) < 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /signbook <signature>');
                die(); # No need to go further					
            
            }
            
            @signature = ''; # Store the signature
            
            foreach(@lineOfText in @args){
            
                @signature = @signature.' '.@lineOfText; # Build the signature
            
            }
            
            @signature = trim(@signature); # Get rid of whitespace			

            @playerThatRanCmd = player(); # Create a player object
            
            @slotHighlighted = pheld_slot(@playerThatRanCmd)
            @itemInHand = pinv(@playerThatRanCmd, @slotHighlighted)[type]; # Grab the ID of the item in the players hand
            
            if(@itemInHand == 387){
            
                @itemMeta =  get_itemmeta(@slotHighlighted); # Grab the meta data
                @itemMeta[author] = @signature; # Sign the book with the new signature
                pgive_item(@playerThatRanCmd, 387, 1, @itemMeta); # Create new copy with new signature and give it to the player
                die(); # All done				
            
            } else {
            
                msg('You must be holding a signed written book'); # Scold the player for wasting time
                die(); # Finished
            
            }			

        }
    )
)