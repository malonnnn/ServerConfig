#main.ms
#bind(player_toggle_sneak, null, array('sneaking': true), @event) {
#    if(pmode() == 'SPECTATOR') {
#        # this might not work, but let's try it.
#        # this also applies to all spectators, which you might not want
#        cancel();
#    }
#}

#bind(player_join,null,null,@event){
#    msg(colorize('&aUpdating Online List...'))
#    shell_adv('/home/minecraft/lastonline.sh',
#    array(subshell: true,
#        workingDir: '/home/minecraft/'
#        )
#    )
#}

#bind('player_chat', null, null, @e) {
    
#    @p ='Tektronic';
    
#    if(equals_ic(player(), @p)){
#        die();
#    }
    
#    if(reg_count('(?i)t+[. ,-]*e+[. ,-]*k+', @e['message']) > 0 && ponline(@p) && player() != @p) {
#        set_timeout(3000, closure(
#            #chatas(@p, 'sup');
#            array @funny = array("i eat farts", 
#            "i have nothing to say", 
#            "i wonder if i ask for too much help sometimes", 
#            "i smell like feet", 
#            "i like to smell my own toes", 
#            "i didnt finish wiping my ass last time", 
#            "what are pubic crabs?",
#            "how can mirrors be real if our eyes aren't real",
#            "i think i stepped on a testicle",
#            "omg i think i have 80HD i cant focus",
#           "when ppl are creamated how do we know it doesnt hurt? we dont know",
#           "i wanna have sex in paris ontop of da ifold tower",
#            "every kiss begins with 'k'. ya so does klamidia",
#            "who painted the mona lisa? leonardo dicaprio",
#            "what is obamas last name?",
#            "can sex be good without an organism?",
#            "your just a sillow wet of a perfect man... u,take me higher",
#            "you gotta have a cool car. you gotta have an educashion. if you dont have that then dont talk to me",
#            "i hate when dumb hoes try to approach me with their none since",
#            "id rather kill myself than commit suicide",
#            "if u didnt know that 99percentdecent is retarted, you dont know anything",
#            "menstruation is called 'period' because back in the day when women's bodies werent as polluted, all it was, was a tiny dot",
#            "who the fuck is paul mccartney? this is why i fuck with kanye. he is always trying to put on new artists",
#            "ima give bitches a minute to shine dem i tell em good writtens",
#            "my dad sprayed his colon me so he is all i can smell",
#            "i want my first daughter to be a girl",
#            "if barraco barner is president why is he gettin involved with russia, scary",
#            "the average human body contains enough bones to make up an entire human skeleton",
#            "will smith kinda looks like the guy from fresh prince of bel air",
#            "every dam year we learn about the hollow cost in school im so dam sick of it!",
#            "how did beyonces album go to #1 in 100 countries when there are only 7? asia, africa, antarctica, austrailia, north and south america, and europe?",
#            "Dont go jason waterfalls <3 that song",
#            "how can yall steal my identity when yall dont look like me? it dont make sense",
#            "im sick of the US government im moving to california",
#            "im so glad artists like rihanna are able to win grammys. such an inspiration",
#            "rosetta stone did not sit on dhat bus for you gays to be askin for equal rights",
#            "i think math is a lie and physics. if we used this in real life we'd look dumb",
#            "lol i just found a phone from the 90s with a hashtag! twitter wasnt even invented then why did they need a hashtag back then??");
#            assign(@phrase, array_rand(@funny))
#            chatas(player(), @funny[@phrase[0]]);
#        ))
#    }
#}
    

#**** LaserBeam - Right-click Redstone Torch ****
bind(player_interact,null,array('item': 280,'button': 'RIGHT'),@event){
    
    assign(@pinfo, pinfo())
    if(!equals(array_get(array_get(@pinfo,9),0), 'nightwing'),
        die()
    )
    
    if(not(equals(pworld(), '1_9')), die())
    
    if(is_null(get_value('lastshot')),
        store_value('lastshot',0)
    )

    assign(@cooldown, 2)
    
    assign(@lastshot, get_value('lastshot'))
    
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    store_value('lastshot', time() / 1000)
    
    
    cancel()
    sudo(/lightning)
    die()
}

#**** LaserBeam - Right-click Redstone Torch ****
bind(player_interact,null,array('button': 'LEFT'),@event){

    assign(@pinfo, pinfo())
    if(@pinfo[9][0] != 'starfire' && @pinfo[9][0] != 'hades'){
        die()
    }
    
    if(not(equals(pworld(), '1_9')), die())
    
    @playerUUID = pinfo(player(),20)
    if(get_inventory(entity_id(@playerUUID),pheld_slot(player())) != null){
        die();
    }
    
    if(is_null(get_value('lastshot')),
        store_value('lastshot',0)
    )
    
    assign(@cooldown, 2)
    
    assign(@lastshot, get_value('lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    store_value('lastshot', time() / 1000)
    
    
    cancel()
    @multiplier = 5
    @arrow = shoot_projectile(player(), 'FIREBALL')
    @velocity = entity_velocity(@arrow)
    set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))
    die()
}

bind(player_interact,null,array('button': 'LEFT'),@event){
    
    assign(@pinfo, pinfo())
    if(!equals(array_get(array_get(@pinfo,9),0), 'zeus'),
        die()
    )
    
    if(not(equals(pworld(), '1_9')), die())
    
    @playerUUID = pinfo(player(),20)
    if(get_inventory(entity_id(@playerUUID),pheld_slot(player())) != null){
        die();
    }
    
    if(is_null(get_value('lastshot')),
        store_value('lastshot',0)
    )
    
    assign(@cooldown, 2)
    
    assign(@lastshot, get_value('lastshot'))
    if(@lastshot + @cooldown > time() / 1000,
        die()
    )
    store_value('lastshot', time() / 1000)
    
    
    cancel()
    sudo(/lightning)
    die()
}

#1.0
#ENTITY_ATTACK
#Tektronic
#entity_damage
#
#
#
#
#lissakitty
#PLAYER
#1_9
#**** LaserBeam - Right-click Redstone Torch ****
bind(entity_damage,null,null,@event){
    
    @attackerName = 'default'
    @pinfo = 'default'
    
    if(@event['cause'] == 'ENTITY_ATTACK'){
        
        if(array_index_exists(@event,'damager')){
            @attackerName = @event['damager']
        }else{
            die()
        }
    
    
        if(ponline(@attackerName)){
            assign(@pinfo, pinfo(@attackerName))
            @attackerUUID = pinfo(@attackerName,20)
        
            if(
            @pinfo[9][0] != 'darthmaul' && 
            @pinfo[9][0] != 'darthvader' &&
            @pinfo[9][0] != 'darthsidious'){
                die()
            }
            if(@pinfo[7] != '1_9'){
                die()
            }
        }else{
            die()
        }
        
        if(get_inventory(entity_id(@attackerUUID),pheld_slot(@attackerName)) != null){
            die()
        }
        
        @victimID = @event['id']
        lightning(entity_loc(@victimID))
        
    }
}

#bind(player_death, null, null, @e) {
#    @plrs = all_players(pworld())
#    foreach(@plr in @plrs){
#        if((pmode(@plr) == 'SPECTATOR') && (pspectator_target(@plr) == player())){
#            set_pmode(@plr,'SURVIVAL')
#            set_ploc(@plr,get_spawn());
#       }
#    }
#    if(array_size(@plrs) > 1) {
#                if(puuid(@sourcePlayer) != puuid(@plrs[0])) {
#                    set_pmode('SPECTATOR');
#                    set_pspectator_target(puuid(@plrs[0]));
#                    tmsg(@plrs[0],concat(color(dark_gray), @sourcePlayer 'is spectating you.'))
#                } else {
#                    set_pmode('SPECTATOR');
#                    set_pspectator_target(puuid(@plrs[1]));
#                    tmsg(@plrs[1],concat(color(dark_gray), @sourcePlayer 'is spectating you.'))
#                }
#            } else {
#                tmsg(@sourcePlayer,concat(color(red), 'No one in this world to spec.'))
#            }
#}

#bind('player_chat', null, null, @e) {
#    @p = to_lower(player());
#    
#    @sentence = split(' ',@e['message'])
#    
#    foreach(@val in @sentence){
#        @val = to_lower(@val)
#        assign(@key, concat('afk.', @val))
#        if(has_value(@key)){
#            @msg = get_value(@key)
#            set_timeout(1500, closure(
#            broadcast(
#            concat(color(blue),@val)
#            concat(color(red),'is AFK and says')
#            concat(color(gold),@msg)
#            )
#            tmsg(@val,
#            concat(color(dark_gray), 'To turn off your AFK message, use')
#            concat(color(gray), '/afkmessageoff')
#            )
#            tmsg(@p,
#            concat(color(dark_gray), 'To set your own AFK message, use')
#            concat(color(gray), '/afkmessage type whatever you want')
#            )))
#        }
#    }
#}

bind('player_chat', null, null, @e) {
#    @p ='Tektronic';
    #if(reg_count('(?i)g+[. ,-_]*u+[. ,-_]*c+[. ,-_]*i+', @e['message']) > 0 && ponline(@p) && player() != @p) {
    #    runas(~console,"/bcc &f"player()" &7will be killed in &62&7 seconds for saying Tek's name.")
    #    set_timeout(2000, closure(
    #        sudo(/kill player())
    #    ))
    #}
    
    if(equals_ic(player(), 'Tektronic')){
        die();
    }
    
    assign(@msg, @e[message])
    assign(@msg, reg_replace('(?i)(0|O)+[. ]*3+[. ,-_]*(0|O)+', '040', @msg))
#    assign(@msg, reg_replace('(?i)-+[. ,-_]*[.,]*-+', 'fart', @msg))
#    assign(@msg, reg_replace('(?i)l+[. ,-]*o+[. ,-]*l+', 'el oh el', @msg))
#    assign(@msg, reg_replace('(?i)x[. ,-]*3', 'x4', @msg))
#    assign(@msg, reg_replace('(?i):[. ,-]*3', ':4', @msg))
#    assign(@msg, reg_replace('o+[. ,-]*m+[. ,-]*f+[. ,-]*g+', 'om fudgee', @msg))
#    assign(@msg, reg_replace('>_+>', 'looky dis way', @msg))
#    assign(@msg, reg_replace('<_+<', 'looky dat way', @msg))
#    assign(@msg, reg_replace('[o0O]+[. ,-_]*[o0O]+', 'oo', @msg))
#    assign(@msg, reg_replace('(?i)c+[. ,-]*x+', 'cctv', @msg))
#    assign(@msg, reg_replace('(?i)o+[. ,-]*m+[. ,-]*g+', 'oh em jee', @msg))
#    assign(@msg, reg_replace('(?i)ha[. ,-]*ha', 'hoy hoy hoy', @msg))
#    assign(@msg, reg_replace('(?i)w+[. ,-]*t+[. ,-]*f+', 'teh funk', @msg))
#    assign(@msg, reg_replace('(?i)l+[. ,-]*m+[. ,-]*a+[. ,-]*o+', 'le mayo', @msg))
#    assign(@msg, reg_replace('(?i)\\bwat', 'twat', @msg))
#    assign(@msg, reg_replace('(?i)[T;][. ,-]*\\-[. ,-]*[T;]', 'sadface', @msg))
#    assign(@msg, reg_replace('(?i)\\bwhen', 'who', @msg))
#    assign(@msg, reg_replace('(?i)\\bwhere', 'when', @msg))
#    assign(@msg, reg_replace('(?i)\\bwhat', 'why', @msg))
#    assign(@msg, reg_replace('(?i)\\bwhy', 'where', @msg))
#    assign(@msg, reg_replace('(?i)\\bwho', 'how', @msg))
#    assign(@msg, reg_replace('(?i)\\bhow', 'what', @msg))
#    assign(@msg, reg_replace('~', '???', @msg))
#    assign(@msg, reg_replace('(?i)g+[. ,-_]*u+[. ,-_]*c+[. ,-_]*i+', 'gay', @msg))
    assign(@msg, reg_replace('(?i)\\bcx', 'cocks', @msg))
    modify_event(message, @msg)
}