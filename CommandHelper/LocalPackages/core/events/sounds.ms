proc (_playChatSound, @sound, @player,

    play_named_sound(ploc(), array('sound': @sound, 'volume': 10000), @player)

)

bind('player_chat', null, null, @e,

    @playerTalking = player(@e[player]); # Store the person chatting

    if(!has_permission(@playerTalking,"sank.sounds")){	
        die(); # No permission		
    }
    
    @msg = @e[message]; # Store the chat msg
    @soundToPlay = ''; # Store the sound name to play
    
    @allPlayersToPlaySoundTo = array(); # Create an empty array of players to play the sounds to
    
    foreach(@player in all_players()){
    
        if(import(@player.'chatsounds') != 'off' ){
        
            array_push(@allPlayersToPlaySoundTo, @player); # Add player to list of players to play sound to
        
        }
    
    }
    
    if(@msg == "haha" || @msg == "ha ha"){	
        @soundToPlay = 'xyz.haha';		
        
    } else if(@msg == "woohoo"){
        
        if(rand(1, 3) == 1){		
            @soundToPlay = 'xyz.woohoo';
            
        } else {		
            @soundToPlay = 'xyz.woohoo2';
            
        }
        
    } else if(@msg == "crap"){
        
        @snd = rand(1,4)
        
        if(@snd == 1){		
            @soundToPlay = 'xyz.awwcrap';
            
        } else if(@snd == 2){		
            @soundToPlay = 'xyz.awwcrap2';
            
        } else {		
            @soundToPlay = 'xyz.awwman';
            
        }
        
    } else if(@msg == "doh" || @msg == "oops") {
        
        @snd = rand(1,9)        
        
        if(@snd == 1){
            @soundToPlay = 'xyz.doh';
            
        }else if(@snd == 2){
            @soundToPlay = 'xyz.doh2';
            
        }else if(@snd == 3){
            @soundToPlay = 'xyz.doh3';
            
        }else if(@snd == 4){
            @soundToPlay = 'xyz.doh4';
            
        }else if(@snd == 5){
            @soundToPlay = 'xyz.doh5';
            
        }else if(@snd == 6){
            @soundToPlay = 'xyz.doh7';
            
        }else if(@snd == 7){
            @soundToPlay = 'xyz.dohoo';
            
        }else{
            @soundToPlay = 'xyz.dohnuts';
            
        }
    
    }else if(@msg == "ouch" || @msg == "ow"){   
        @soundToPlay = 'xyz.ow';   
        
    }else if(@msg == "we're doomed" || @msg == "were doomed"){       
        @soundToPlay = 'xyz.doomed';
        
    }else if(@msg == "brb"){       
        @soundToPlay = 'xyz.beback'; 
        
    }else if(@msg == "bye"){      
        @soundToPlay = 'xyz.bye_love';
        
    }else if(@msg == "come again"){        
        @soundToPlay = 'xyz.comeagain';
        
    }else if(@msg == "force"){        
        @soundToPlay = 'xyz.force';        
 
    }else if(@msg == "goodbye"){       
        @soundToPlay = 'xyz.goodbye';
        
    }else if(@msg == "gtg"){        
        @soundToPlay = 'xyz.gtg';
        
    }else if(@msg == "hi" || @msg == "hello" || @msg == "wb" || @msg == 'hey'){
        
        @rand = rand(1,4)
        
        if(@rand == 1){
            @soundToPlay = 'xyz.hi';
            
        }else if(@rand == 2){
            @soundToPlay = 'xyz.hibabe';
            
        }else{
            @soundToPlay = 'xyz.himan';
        }			
    }
    
    if (@soundToPlay != ''){
        
        foreach(@player in @allPlayersToPlaySoundTo){
            
            _playChatSound(@soundToPlay, @player); # Play the sound to the player
            
        }
    }
)
/*
    }else if(@msg == "bud"){
            @snd = rand(1,4)
            if(@snd == 1){
                @soundToPlay = 'xyz.bud';
            }else if(@snd == 2){
                @soundToPlay = 'xyz.weis';
            }else{
                @soundToPlay = 'xyz.er';
            }    
    }else if(@msg == "run mr. taliban" || @msg == "osama bin laden" || @msg == "airforce is coming"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.taliban';
        }
    }else if(@msg == "aol"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.aol';
        }
    }else if(@msg == "schoki"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.schoki';
        }
    }else if(@msg == "all your base"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.allyourbase';
        }
    
    }else if(@msg == "beer"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.beer';
        }    
    }else if(@msg == "idiot"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.idiotsong';
        }
    }else if(@msg == "piss on your grave"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.pissgrv';
        }
    }else if(@msg == "stayin alive"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.stayinalive';
        }
    }else if(@msg == "yo momma so fat"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.stuckair';
        }
    }else if(@msg == "the one"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.theone';
        }
    }else if(@msg == "ymca"){
        @players = all_players()
        foreach(@player in @players){
            @soundToPlay = 'xyz.ymca';
        }
*/