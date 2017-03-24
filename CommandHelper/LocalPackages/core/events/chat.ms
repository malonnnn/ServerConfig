bind('player_chat', null, null, @e) {
    
    @pgroup = pgroup()
    @pname = player()
    @pworld = pworld()
    @puuid = puuid()
    assign(@msg, @e[message])

    # -------------------------------
    # if message is 565, display a link to a picture of the "superhero warehouse"
    # -------------------------------
    @isMindLocked = import(@pname.'isMindLocked')
    if(@isMindLocked){
        @mindLocker = import(@pname.'mindLockedBy')
        if(@mindLocker != ''){
            tmsg(@mindLocker,color(dark_red).'['.color(red).'mindlock'.color(dark_red).'] '.color(red).@pname.color(dark_red).': '.color(gray).@msg)
            tmsg(@pname,color(dark_red).'['.color(red).'mindlock'.color(dark_red).'] '.color(red).@pname.color(dark_red).': '.color(gray).@msg)
            assign(@msg,'')
            cancel()
            return()
        }
    }

    # -------------------------------
    # if message is 565, display a link to a picture of the "superhero warehouse"
    # -------------------------------
    if(@msg == '565' && @pgroup[0] != "quarantine")
    {
        set_timeout(1000, closure(
            tmsg(@pname, color(dark_red) . color(random) . "k" . color(gray) . "Retrieving classified image for your viewing...")
            set_timeout(1000, closure(
                tmsg(@pname, color(dark_red) . color(random) . "k" . color(gold) . "http://i.imgur.com/tlypRN9.jpg")
                #tmsg(@pname, "§4§kk§6http://i.imgur.com/0od9K1R.png")
            ))
        ))
        cancel()
        broadcast(color(dark_red) . color(random) . "k" . color(gray) . @pname. color(gray) ." said the secret password for superheroes!")
    }
    
    # -------------------------------
    # If Mxypztlk speaks his own name backwards he is sent to the nether and de-powered
    # -------------------------------
    if(string_position(to_lower(@msg), 'kltpzyxm') != -1)
    {
        if(@pgroup[0] == 'mrmxyzptlk')
        {
            set_timeout(1000, closure(
                runas(~console,"/sudo ". @pname ." c:/mortal")
                sudo(/warp onslaughtmental @pname)
                set_timeout(1500, closure(
                    tmsg(@pname, 'You said your name backwards! Off to the other dimension you go!')
                ))
            ))
        }
    }
    
    # -------------------------------
    # replace all messages by black bold with "..." because he is unable to speak
    # -------------------------------
    if(@pgroup[0] == 'blackbolt')
    {
        assign(@msg,"...")
        modify_event(message, @msg)
    }
    
    # -------------------------------
    # replace all messages by time wraith with screams
    # -------------------------------
    if(@pgroup[0] == 'timewraith')
    {
        @phrase = rand(1, 8)
        
        if(@phrase == 1){
            assign(@msg,"GGRRAAA!")
        } else if(@phrase == 2){
            assign(@msg,"aaaaaAAAAAHHHhhhhh!")
        } else if(@phrase == 3){
            assign(@msg,'ooooRRRRAAAHH!')
        } else if(@phrase == 4){
            assign(@msg,"RRRRRRRAAAA!")
        } else if(@phrase == 5){
            assign(@msg,"EEEGGGRREERRAAA!")
        } else if(@phrase == 6){
            assign(@msg,"KKKKRRAAHHHHHH!")
        } else if(@phrase == 7){
            assign(@msg,"HHRRRRAAAHHH!")
        }
        
        modify_event(message, @msg)
    }
    
    # -------------------------------
    # if player is "confused", mix up their words
    # -------------------------------
    if((!is_null(get_value(@pname."isConfused"))) && (get_value(@pname."isConfused") == "true"))
    {
        @words = split(' ',@msg)
        @numWords = array_size(@words)
        if(@numWords == 1){
            cancel()
        }
        @newNumOfWords = @numWords
        @newMsg = ''
        for(@i = 0, @i < @numWords, @i++){
            @randWord = rand(0,@newNumOfWords)
            @newMsg = @words[@randWord] . " " . @newMsg
            array_remove(@words, @randWord)
            @newNumOfWords = @newNumOfWords - 1
            @numWords = @numWords - 1
        }
        modify_event(message, @newMsg)
    }
    
    # -------------------------------
    # replace all messages by pikachu with "Pika Pika Pikachu!" because he is unable to speak
    # -------------------------------
    if(@pgroup[0] == 'pikachu')
    {
        @phrase = rand(1, 8)
        
        if(@phrase == 1){
            assign(@msg,"Pika! Pika! PikAchu!")
        } else if(@phrase == 2){
            assign(@msg,"Pika Pika.")
        } else if(@phrase == 3){
            assign(@msg,"Pikachuuuuu!")
        } else if(@phrase == 4){
            assign(@msg,"PikAchu.")
        } else if(@phrase == 5){
            assign(@msg,"Pikachu!")
        } else if(@phrase == 6){
            assign(@msg,"Pika! Pika!")
        } else if(@phrase == 7){
            assign(@msg,"Pika Pi!")
        }
        
        modify_event(message, @msg)
    }
    
    # -------------------------------
    # replace all messages by Greninja with Greninja stuff
    # -------------------------------
    if(@pgroup[0] == 'victini')
    {
        @phrase = rand(1, 3)
        
        if(@phrase == 1){
            assign(@msg,"Vic, Victini!")
        } else if(@phrase == 2){
            assign(@msg,"Victini!")
        }
        
        modify_event(message, @msg)
    }

    # -------------------------------
    # replace all messages by Greninja with Greninja stuff
    # -------------------------------
    if(@pgroup[0] == 'greninja')
    {
        @phrase = rand(1, 3)
        
        if(@phrase == 1){
            assign(@msg,"Gre, Greninja!")
        } else if(@phrase == 2){
            assign(@msg,"Greninja!")
        }
        
        modify_event(message, @msg)
    }
    
    # -------------------------------
    # replace all messages by mew with "mew"
    # -------------------------------
    if(@pgroup[0] == 'mew')
    {
        @phrase = rand(1, 4)
        
        if(@phrase == 1){
            assign(@msg,"Mew.")
        } else if(@phrase == 2){
            assign(@msg,"Meew.")
        } else if(@phrase == 3){
            assign(@msg,"Meww.")
        }
        
        modify_event(message, @msg)
    }
    
    # -------------------------------
    # replace all messages by groot bold with "I am groot." because he is unable to speak
    # -------------------------------
    if(@pgroup[0] == 'groot')
    {
        @players = all_players()
        @rocketMsg = @msg
        
        @phrase = rand(1, 51)
        
        if(@phrase < 50){  
            assign(@msg,"I am Groot.")
        } else {
            assign(@msg,"We are Groot.")
        }
        modify_event(message, @msg)

        
        foreach(@player in @players){
            if(pgroup(@player)[0] == "rocketraccoon"){
                set_timeout(500,closure(
                    tmsg(@player,color(red)."Groot says: ".@rocketMsg)
                ))
            }
        }
    }
    
    # -------------------------------
    # Chat replacements for fun
    # -------------------------------
    #assign(@msg, reg_replace('(?i)(0|O)+[. ]*3+[. ,-_]*(0|O)+', '040', @msg))
    #assign(@msg, reg_replace('(?i)-+[. ,-_]*[.,]*-+', 'fart', @msg))
    #assign(@msg, reg_replace('(?i)l+[. ,-]*o+[. ,-]*l+', 'el oh el', @msg))
    #assign(@msg, reg_replace('(?i)x[. ,-]*3', 'x4', @msg))
    #assign(@msg, reg_replace('(?i)x+[. ,-]*d+', 'dick', @msg))
    #assign(@msg, reg_replace('(?i):[. ,-]*3', ':4', @msg))
    #assign(@msg, reg_replace('o+[. ,-]*m+[. ,-]*f+[. ,-]*g+', 'om fudgee', @msg))
    #assign(@msg, reg_replace('>_+>', 'looky dis way', @msg))
    #assign(@msg, reg_replace('<_+<', 'looky dat way', @msg))
    #assign(@msg, reg_replace('[o0O]+[. ,-_]*[o0O]+', 'oo', @msg))
    #assign(@msg, reg_replace('(?i)c+[. ,-]*x+', 'cctv', @msg))
    #assign(@msg, reg_replace('(?i)o+[. ,-]*m+[. ,-]*g+', 'oh em jee', @msg))
    #assign(@msg, reg_replace('(?i)ha[. ,-]*ha', 'hoy hoy hoy', @msg))
    #assign(@msg, reg_replace('(?i)w+[. ,-]*t+[. ,-]*f+', 'teh funk', @msg))
    #assign(@msg, reg_replace('(?i)l+[. ,-]*m+[. ,-]*a+[. ,-]*o+', 'le mayo', @msg))
    #assign(@msg, reg_replace('(?i)\\bwat', 'twat', @msg))
    #assign(@msg, reg_replace('(?i)[T;][. ,-]*\\-[. ,-]*[T;]', 'sadface', @msg))
    #assign(@msg, reg_replace('(?i)\\bwhen', 'who', @msg))
    #assign(@msg, reg_replace('(?i)\\bwhere', 'when', @msg))
    #assign(@msg, reg_replace('(?i)\\bwhat', 'why', @msg))
    #assign(@msg, reg_replace('(?i)\\bwhy', 'where', @msg))
    #assign(@msg, reg_replace('(?i)\\bwho', 'how', @msg))
    #assign(@msg, reg_replace('(?i)\\bhow', 'what', @msg))
    #assign(@msg, reg_replace('~', '???', @msg))
    #assign(@msg, reg_replace('(?i)g+[. ,-_]*u+[. ,-_]*c+[. ,-_]*i+', 'gay', @msg))
    #assign(@msg, reg_replace('(?i)\\bcx', 'cocks', @msg))
    #assign(@msg, reg_replace('(?i)o+[. ,-]*m+[. ,-]*l+', 'omg', @msg))
    #assign(@msg, reg_replace('(?i)t+[ .,-_]*e+[ .,-_]*k+[ .,-_]*t+[ .,-_]*r+[ .,-_]*o+[ .,-_]*n+[ .,-_]*i+[ .,-_]*c+', @pname, @msg))
    #assign(@msg, reg_replace('(?i)t+[ .,-_]*r+[ .,-_]*o+[ .,-_]*n+[ .,-_]*i+[ .,-_]*c+', @pname, @msg))
    #assign(@msg, reg_replace('(?i)t+[ .,-_]*e+[ .,-_]*k+', @pname, @msg))

    #modify_event(message, @msg)
    
    #@temp = reg_match('[^ -~]',@msg)
    #if(array_size(@temp) > 0){
    #    cancel()
    #}

    # -------------------------------
    # If a player is a mod, stop the script at this point because the mods are not bound by chat timeout
    # -------------------------------
    if(has_permission("rank.mod") && has_permission("is.virus") ==  false)
    {
        die()
    }
    
    if(has_permission(@pname,'case.tolower')){
        @msg = to_lower(@msg)
      modify_event(message, @msg)
    }
     
    # -------------------------------
    # chat timeout settings
    # -------------------------------
    if(has_permission("is.virus")){
        @cooldown = 60
}else if(@pname == "Suannaii"){
        @cooldown = 1
    }else{
        @plrz = all_players()
        @size = array_size(@plrz)
       # @cooldown = @size / 2
        @cooldown = 0
    }
    if(is_null(get_value(@pname.'lastmessage')))
    {
        store_value(@pname.'lastmessage',0)
    }
    @lastmessage = get_value(@pname.'lastmessage')
    @time = time()
    if(@lastmessage + @cooldown > @time / 1000)
    {
        @timeleft = subtract(add(@lastmessage, @cooldown), divide(@time,1000)) + 1
        tmsg(@pname,"You can speak again in" round(@timeleft) "seconds")
        cancel()
        die()
    }
    store_value(@pname.'lastmessage', time() / 1000)
    
}
