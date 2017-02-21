bind('player_chat', null, null, @e) {

    if(!has_permission(player(),"sank.sounds")){
        die()
    }
    
    assign(@msg, @e[message])
    if(@msg == "haha" || @msg == "ha ha"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.haha', 'volume': 10000), @player)
        }
    }else if(@msg == "woohoo"){
        @players = all_players()
        @snd = rand(1,3)
        foreach(@player in @players){
            if(@snd == 1){
                play_named_sound(ploc(), array('sound': 'xyz.woohoo', 'volume': 10000), @player)
            }else{
                play_named_sound(ploc(), array('sound': 'xyz.woohoo2', 'volume': 10000), @player)
            }
        }
    }else if(@msg == "crap"){
        @players = all_players()
        @snd = rand(1,4)
        foreach(@player in @players){
            if(@snd == 1){
                play_named_sound(ploc(), array('sound': 'xyz.awwcrap', 'volume': 10000), @player)
            }else if(@snd == 2){
                play_named_sound(ploc(), array('sound': 'xyz.awwcrap2', 'volume': 10000), @player)
            }else{
                play_named_sound(ploc(), array('sound': 'xyz.awwman', 'volume': 10000), @player)
            }
        }
    }else if(@msg == "doh"){
        @players = all_players()
        @snd = rand(1,9)
        foreach(@player in @players){
            if(@snd == 1){
                play_named_sound(ploc(), array('sound': 'xyz.doh', 'volume': 10000), @player)
            }else if(@snd == 2){
                play_named_sound(ploc(), array('sound': 'xyz.doh2', 'volume': 10000), @player)
            }else if(@snd == 3){
                play_named_sound(ploc(), array('sound': 'xyz.doh3', 'volume': 10000), @player)
            }else if(@snd == 4){
                play_named_sound(ploc(), array('sound': 'xyz.doh4', 'volume': 10000), @player)
            }else if(@snd == 5){
                play_named_sound(ploc(), array('sound': 'xyz.doh5', 'volume': 10000), @player)
            }else if(@snd == 6){
                play_named_sound(ploc(), array('sound': 'syz.doh7', 'volume': 10000), @player)
            }else if(@snd == 7){
                play_named_sound(ploc(), array('sound': 'xyz.dohoo', 'volume': 10000), @player)
            }else{
                play_named_sound(ploc(), array('sound': 'xyz.dohnuts', 'volume': 10000), @player)
           } 
        }
#    }else if(@msg == "bud"){
#        @players = all_players()
#        foreach(@player in @players){
#            @snd = rand(1,4)
#            if(@snd == 1){
#                play_named_sound(ploc(), array('sound': 'xyz.bud', 'volume': 10000), @player)
#            }else if(@snd == 2){
#                play_named_sound(ploc(), array('sound': 'xyz.weis', 'volume': 10000), @player)
#            }else{
#                play_named_sound(ploc(), array('sound': 'xyz.er', 'volume': 10000), @player)
#            }
#        }
    }else if(@msg == "ouch"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.ow', 'volume': 10000), @player)
        }
    }else if(@msg == "we're doomed"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.doomed', 'volume': 10000), @player)
        }
#    }else if(@msg == "run mr. taliban" || @msg == "osama bin laden" || @msg == "airforce is coming"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.taliban', 'volume': 10000), @player)
#        }
#    }else if(@msg == "aol"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.aol', 'volume': 10000), @player)
#        }
#    }else if(@msg == "schoki"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.schoki', 'volume': 10000), @player)
#        }
#    }else if(@msg == "all your base"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.allyourbase', 'volume': 10000), @player)
#        }
    }else if(@msg == "brb"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.beback', 'volume': 10000), @player)
        }
#    }else if(@msg == "beer"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.beer', 'volume': 10000), @player)
#        }
    }else if(@msg == "bye"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.bye_love', 'volume': 10000), @player)
        }
    }else if(@msg == "come again"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.comeagain', 'volume': 10000), @player)
        }
    }else if(@msg == "force"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.force', 'volume': 10000), @player)
        
    }
    }else if(@msg == "goodbye"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.goodbye', 'volume': 10000), @player)
        }
    }else if(@msg == "gtg"){
        @players = all_players()
        foreach(@player in @players){
            play_named_sound(ploc(), array('sound': 'xyz.gtg', 'volume': 10000), @player)
        }
    }else if(@msg == "hi" || @msg == "hello" || @msg == "wb"){
        @players = all_players()
        @rand = rand(1,4)
        foreach(@player in @players){
            if(@rand == 1){
                play_named_sound(ploc(), array('sound': 'xyz.hi', 'volume': 10000), @player)
            }else if(@rand == 2){
                play_named_sound(ploc(), array('sound': 'xyz.hibabe', 'volume': 10000), @player)
            }else{
                play_named_sound(ploc(), array('sound': 'xyz.himan', 'volume': 10000), @player)
            }
        }
#    }else if(@msg == "idiot"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.idiotsong', 'volume': 10000), @player)
#        }
#    }else if(@msg == "piss on your grave"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.pissgrv', 'volume': 10000), @player)
#        }
#    }else if(@msg == "stayin alive"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.stayinalive', 'volume': 10000), @player)
#        }
#    }else if(@msg == "yo momma so fat"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.stuckair', 'volume': 10000), @player)
#        }
#    }else if(@msg == "the one"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.theone', 'volume': 10000), @player)
#        }
#    }else if(@msg == "ymca"){
#        @players = all_players()
#        foreach(@player in @players){
#            play_named_sound(ploc(), array('sound': 'xyz.ymca', 'volume': 10000), @player)
#        }
    }
}
