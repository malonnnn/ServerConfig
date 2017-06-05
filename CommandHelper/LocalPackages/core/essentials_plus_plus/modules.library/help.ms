# --------------------------------------------------------------------------
# Replaces the /help menu supplied by the essentials plugin with a customized
# more pleasing menu
# --------------------------------------------------------------------------

proc(_help, @playerThatRanCmd, @command,		

    @args = parse_args(@command); # Parse the arguements
    
    if (array_size(@args) > 2) {
        
        msg(''.color(RED).color(BOLD).'Improper Usage!');
        msg(''.color(RED).'Usage: /help <page number>');
        die(); # No need to go further					
        
    }
        
    @playerThatRanCmd = player();
        
    @internalCommands = get_commands()
    @commands = array();
    
    foreach (@command in @internalCommands) {		
        
        @commandString = '&b/'.@command[name].' &f- &f&o'.@command[description];
        array_push(@commands, @commandString);							
    
    }	
    
    if( @commands == null ) {
    
        @commands = array();
        
    }

    array_sort(@commands, 'STRING_IC');

    @perpage = 20;
    @page = 1;
    
    if (array_size(@args) == 2) {
    
        if (is_integral(@args[1])){
        
                @page = @args[1];
                
        } else {
        
            msg('Page Number must be a valid Number. Page set to: Pg #1');
            @page = 1;				
        
        }
        
    }			
    
    @maxpage = ceil(array_size(@commands) / @perpage);
    
    if(!is_integral(@page) || @maxpage == 0) {
    
        @maxpage = 1;
        
    }

    ### If the page number is less than 1, or higher than the maximum page ###
    if(@page > @maxpage) {
    
        @page = @maxpage; # The idiot has entered a page that doesn't exist, so just give them the last page.
        
    } else if (@page < 1) {
    
        @page = 1; # Page cant be less than 1 so set it to the first page
    
    }

    @finalList = array();

    for(@i = (@page - 1) * @perpage, @i < (@page * @perpage), @i++) {
    
        if(array_size(@commands) > @i) {
        
            array_push(@finalList, @commands[@i]);
            
        }
        
    }
    
    msg(colorize("&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l="));
    msg(colorize("&4&l&k!&c&l&k!&4&l&k! &e&lDC&r &7- &4&lMarvel &7- &6&lAnime &7- &b&lV.Games &7- &d&lMore &4&l&k!&c&l&k!&4&l&k!"));
    msg(colorize("&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l=&b&l=&3&l="));
    msg(colorize("&3&oAvailable Commands: (". array_size(@commands). ") &7&o(Page: @{page}/@{maxpage})"));
    msg(''); # Insert Blank Line
    
    foreach (@command in @finalList){
    
        msg(colorize(@command));
        
    }
    
    if (@page != @maxpage){
    
        msg(''); # Insert Blank Line
        msg(colorize("&3&oType: &f&o/help ".(@page + 1)." &3&oto Goto the Next Page"));
    
    }		
)

bind(player_command, null, array(prefix: '/help'), @Event, 
    
    _help(@Event[player], @Event[command]); # Puff puff pass
    cancel();
    
)