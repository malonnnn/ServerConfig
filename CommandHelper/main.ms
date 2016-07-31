set_interval(5000, closure(){
    @plrs = all_players()
    
    foreach(@plr in @plrs)
    {
        if(
        @plr == 'Tektronic' || 
        @plr == 'Donald_JTrump' 
        
        ){
            continue()
        }
        @pgroup = pgroup(@plr)
            if(
            @pgroup[0] == 'doctormanhattan' ||
            @pgroup[0] == 'zeus' ||
            @pgroup[0] == 'poseidon' ||
            @pgroup[0] == 'hades' ||
            @pgroup[0] == 'onepunchman' ||
            @pgroup[0] == 'wallywest' ||
            @pgroup[0] == 'onslaught' ||
            @pgroup[0] == 'onslaughtreborn'
            )
            {
                if(acc_balance(@plr) >= 5){
                    acc_subtract(@plr,5)
                }else{
                    runas(~console,"/sudo ". @plr ." c:/mortal")
                    tmsg(@plr,"you ran out of money and have turned mortal again!")
                    
                    if(pmode(@plr) == 'SPECTATOR'){
                        broadcast(@plr "ran out of money and is being kicked in 5 seconds to reset his settings")
                        set_timeout(5000, closure(
                            runas(~console,/kick @plr "Please Relog. We are resetting your settings.")
                        ))
                    }
                }
            }
    }
});

#main.ms
#bind(player_toggle_sneak, null, array('sneaking': true), @event) {
#    if(pmode() == 'SPECTATOR') {
#        # this might not work, but let's try it.
#        # this also applies to all spectators, which you might not want
#        cancel();
#    }
#}

# Clear Jailed Player Inventor on Item Pickup
bind(item_pickup,null,null,@event){
    
    @pname = player()
    @pgroup = pgroup()
   
   if(@pgroup[0] == 'jailed'){
        cancel()
    }
}

# Shot Zombies give money
bind(entity_death, null, array('type': 'ZOMBIE'), @e)
{
    if(!array_index_exists(@e['cause'],'damager')){
        die()
    }
    if(ponline(@e['cause']['damager'])){
        if(pworld(@e['cause']['damager']) != 'greenfield'){
            die()
        }
        runas(~console,/eco give @e['cause']['damager'] 1)
    }else if(ponline(@e['cause']['shooter'])){
        if(pworld(@e['cause']['shooter']) != 'greenfield'){
            die()
        }
        runas(~console,/eco give @e['cause']['shooter'] 1)
    }
}

# Shot Enderman in Anarchy give money
bind(entity_death, null, array('type': 'ENDERMAN'), @e)
{
    if(ponline(@e['cause']['damager'])){
        if(pworld(@e['cause']['damager']) != 'anarchy'){
            die()
        }
        runas(~console,/eco give @e['cause']['damager'] 30)
    }else if(ponline(@e['cause']['shooter'])){
        if(pworld(@e['cause']['shooter']) != 'anarchy'){
            die()
        }
        runas(~console,/eco give @e['cause']['shooter'] 30)
    }
}

# Shot Creepers in Anarchy give money
bind(entity_death, null, array('type': 'CREEPER'), @e)
{
    if(ponline(@e['cause']['damager'])){
        if(pworld(@e['cause']['damager']) != 'anarchy'){
            die()
        }
        runas(~console,/eco give @e['cause']['damager'] 5)
    }else if(ponline(@e['cause']['shooter'])){
        if(pworld(@e['cause']['shooter']) != 'anarchy'){
            die()
        }
        runas(~console,/eco give @e['cause']['shooter'] 5)
    }
}


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
    

# Hit With Stick Lightning
bind(player_interact,null,array('item': 280,'button': 'LEFT'),@event){

    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(@pgroup[0] != 'nightwing')
    {
        die()
    }
    
    if(@pworld != '1_9' && @pworld != 'greenfield'){
        die()
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

# Punch Empty Hand Fireball
bind(player_interact,null,array('button': 'LEFT'),@event){

    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
        
    if(@pgroup[0] != 'starfire' && @pgroup[0] != 'hades'){
        die()
    }
    
    if(pworld() != '1_9' && pworld() != 'greenfield'){
        die()
    }
    
    if(get_inventory(entity_id(@puuid),pheld_slot(@pname)) != null){
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
    @arrow = shoot_projectile(@pname, 'FIREBALL')
    @velocity = entity_velocity(@arrow)
    set_entity_velocity(@arrow, array(@velocity['x'] * @multiplier, @velocity['y'] * @multiplier, @velocity['z'] * @multiplier))
    die()
}

# Point Empty Hand Lightning
bind(player_interact,null,array('button': 'LEFT'),@event){
    
    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(@pgroup[0] != "zeus" && @pgroup[0] != "shazam" && @pgroup[0] != "blackadam")
    {
        die()
    }
    
    if(@pworld != "1_9" && @pworld != "greenfield")
    {
        die()
    }
    
    if(get_inventory(entity_id(@puuid),pheld_slot(@pname)) != null){
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

# Punch Lightning with Bare Hands
bind(entity_damage,null,null,@event){
    
    if(@event['cause'] == 'ENTITY_ATTACK'){
        
        @attackerName = 'default'
        
        if(array_index_exists(@event,'damager')){
            @attackerName = @event['damager']
        }else{
            die()
        }
    
        @pname = player()
        if(ponline(@attackerName))
        {
            if(@pname != @attackerName)
            {
                die()
            }
            
            @pgroup = pgroup()
            @pworld = pworld()
            @puuid = puuid()
        
            puuid() = @puuid
        
            if(
                @pgroup[0] != 'shazam' &&
                @pgroup[0] != 'blackadam' &&
                @pgroup[0] != 'darthmaul' && 
                @pgroup[0] != 'darthvader' &&
                @pgroup[0] != 'darthsidious'
            ){
                die()
            }
            
            if(@pworld != '1_9' && @pworld != 'greenfield'){
                die()
            }
            
            if(get_inventory(entity_id(@pname),pheld_slot(@pname)) != null){
                die()
            }
        }else{
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
    
    @pgroup = pgroup()
    
    if(@pgroup[0] == 'jailed'){
        die()
    }
    
    @pname = player()
    @pworld = pworld()
    @puuid = puuid()
    
    assign(@msg, @e[message])
    
    if(@msg == '565')
    {
        set_timeout(1000, closure(
            tmsg(@pname, "§4§kk§7Retrieving classified image for your viewing...")
            set_timeout(1000, closure(
            tmsg(@pname, "§4§kk§6http://i.imgur.com/tlypRN9.jpg")
            ))
        ))
        cancel()
        broadcast("§4§kk§9".@pname §7said the secret password for superheroes!)
    }
    
    if(equals_ic(@pname, 'Tektronic')){
        die();
    }
    
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

bind(player_join,null,null,@event){
    
    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    proc(_changeSkin, @pname, @id, @puuid, @sig, @val,
        runas(~console,/disguiseplayer @pname player @pname 'setskin {"id":"'.@puuid.'","name":"'.@id.'","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
    )

    set_timeout(5000, closure(
    if(@pgroup[0] == 'doctormanhattan'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',
        
        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'jvRQbVMc9Cgziqz7KywUxL0TeTV7/op88ZgfbywriuP56RscgaxCR6j1/Ewv2I5maP8rCEcA6UBEUjbeNpzbUdDmVZsN2fNDnVZ6YPdlbAwNT3Cco1X37rzBvC4n1RbYBDTyiRq6N3/J9hPDHFqBZslf2rWhypOgzQCQEo026HNivyntRHwqqkpkOcUv2sQgTOHPpeamKru+8F2i6OdndHiHS4qqJ1CVY3LsowmY7eDyCOXVRbkhtjzvmQ/7YiMKthVriKpLVk9pswAKi8yfRgd9ov+7UZQWP99lY23JDmkGsJkvwINdNOJxatgBoakOaMwUQ86AJMSeViIOFm0cQ2zDPy1eesDEHkPfiJtp5XVUfhvH9L+Bga3MJznSbe0QspT39J0hZ1VrfGALBf8rff7GXFY69Ge9KRFsptowc0OkMqeHh1IdEIjSP0RJXTlckGeIdIkF0GRw8VHM6mvn4jlcg06BLHnhc79Jx1saVQPQWapP8O27YIZVG2ZCgQIgw3gzfbdWqfqJPGuob7nWUhW1djVOFkP/kFp1t9MrG/phClEwNmybQwrpk0VpX61Ms8cUEw0L/owwqePuzB0Hkh+v6sTgMCAk8FaElYZ9e4IVbeCMqKesNMO6voI001N/dtX691FtByLnTMAqLKZsBAfn3k0gDIor5zVlNzS1q+I=',        
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI5NzkxNjEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzViZDJiZmZiZTdmZGMxYmFhM2Y2YWY2MTM4MTc4NzZhOTdkNmE2OWE1MmM0MzMwMzZkZTEwOTI1MTI4YzFmZSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'deadpool'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Qe/Zu/vAw0+yEwTvANY2rnQtktRy+Rvxit/j8tfTAkr76WXcyrqD6c+UEhfxt4q/AFidowyYvhjpCJrhQsN1awT0IJU/IgLNtQnbe2pfWYkyRmuZLJheu/JSDl64x4YZ2XLfMwwYCq7ZfJ/rCGiy+OP3aFVXYOG6dKvDNPDy0GiZWOFqWz7EKMnzVVO625ivoZoyOIhp5Q69N7mwbiBgoSc9Cx+hXFOjrHghxlNOkSBkmkHX+ByDtsbk/KowC6pwTpYoGC4Kvl6uGuGMLabnExcIERCFalXKk/Np0+6o6k9QfY0IJ4tjex19wzQBl6p4hda9F5jPeocAgqzTrCpqnbGWQfakXPGZMbEYl5bQ5bNRBw/9DmStpZLwAMbVyjfZfS15RVdkwHaNO0qZckKFXg/UOcOOa7FtrYhK/WMRlUb882drsIqOLvLC3Rewu6mhQuulLEz7BXFtXB9nPsIlL2fKAXcNAusE4Dm9gWKVXtHD9E5oHda5qKL033pN84zcbcFgCQMJKqcwc12AIN7W0NZ0UHdj/AoQRNHAFeweUwgAIrajCvBHkAscrmCA4BvE7q4voOaEialT0zxx663kR/d0Pxq/Wh7UgudQ/jbi3KQEl8bqbbrD8RYYH523acJWBBc7RfPj8K6+njoRZQ+jqUFP2zrIdJiKzKy3cyHnKZY=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NDkwMTk4ODEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzdiYTcxODkyNGZiM2E4YmE5ZDk2NzA0OTY4OGNkYjE2NWM5NTY3Mzk0OWIzMzYzMDNjMjcxY2UyNjhiNDEifX19'
        
        )}
    else if(@pgroup[0] == 'greenarrow'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Kwulj9SxXQE4RI26IWFHrj5DZ2GTMbgWb74TCLvZ8ICIOW+34ycJWVl70L/BJ8M09GVKkIQAcNe9+wwz9G0ijLXozYTvSm5I6pn4Wt081Att7+yzm7wZjGGqJOdjSPKpcb7hM1Zj/++N051qaHTWNwMdVBfBojHtF3jskntycUdVXEV+ZjuXa4lcrfmlG4JbEzRPjc44b/GL86mW29JiKKPMPstw1AClea8H8GalpmXCFVj4yrYP5UteiME9758uFjhQPhZrhaAeXZ259ZrpVN1/oyGlmaD/QfDxgDEBSmc+DuqusO6Ak3mxOV6uxfjzFLwFDC+tBdjTms8X+qfqI/JyFrnSm7FCc9ueOIinYIF+ydMmg1tDJP53dwQWpWiVxI/zcwzblbdFmFv7v5JASYoI80G0SI1Wn5gLTUWMaBgOYXDVrMWbPqXKmHfHe6JvqWDpzoIEQV82QVWq33nhqeQ6kyL1ZDiQvLICN+Gz50dsp0bGTp9yNlf5JoMWmvDmImbzwf5Gb0mJ1yY9Vo+J/rh+Oj36HVuJ3pW4IAxcryvo6vXedlju2Jt5jsJIR9TydBigVXXJkm5Qq0w3mc6heu6R1RYZj9C/OW83j7ldGxB20sItk+KiqBjhJsIxMdsK9NEQvtlkW2qG38UpGCbhxqBaCJcxvPv+gsvXhu1V1Eo='
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTQ3Mjk0MTQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzQ1YzI1MjI0NTNhNDk4OThhMzY3MmY4ZDNlOTg5M2JhMjU5NjdlZTM5MTJjNzY5MWE5MTJmNzk3NGNiOTY5MCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'captainamerica'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'fW18bSRKrzC2x1X2D8M1Hzky/nD/XXFSGXK6Yn8NLaKcx3MRJ5LtCyich/ptgIJyJF6RqLqqMGPtxhzI+RLVtUBpNB+hJoRiUr1m3zcea590AI638G4PSL3bc2YLfLJJdAZhM5UK19kBTT9Eo6U0nCkCUqH7eQh7jTRWH6SMbt/cBKCWDYP9O104BcHNS/JqMpEJ1eVGRzRU1UGq90UKNEQ4yYdDIZJEVggjJoOUcmmi3gU6bZftJYQ3SZ+VhqC5E6nf9+SkVq3dLMmbMIpumAJbd9ALMtikKOtGShmwc3RNpkVfwoQbWnt8drYwE3Lt5f3ERyXSbEvWL3e5Y1i2GzMehpRTBM6iuT//RYZm4hps8Xls/AQUELpuiTvUECmJf1NcvoDSKp+0/OukCSXOKi1Ya/YvqVWeXcqxuti8TSA6vqRghydyhqtY9pELYV54BmV7tv+xSfzksQ8TIEl6Nfa3SZv6PWXR6jQduCYymnOiCtRLkyDjeGU+uDQJsgWNwPkJ1RwbJSKEwjeBbDAAsfdgSZmXJNVrHvOgLhZHBzvN+cTQSRpdEy60iwxtO7/5f9kuB/ZftgU775KHYCLeXC+h+1ClV3zI6GoNUSJD9RvZZAHrtOulDlH0zGRYy0iioW+H6o5ZtjZO+11Y4bHDA2pKZ5ZS9aY2FjfHTeM2XKU=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTY0ODg0MzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2UxMTBlZTczZDczNTM2MmVkMTYwNDBlNGM1Njk0MzEzYmFjZmNmNjM4NWZlNzFhMzRhOTYzNDcyMzU5MjNmNCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'mystique'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        '"bHtBLMcSBW4wMHK1lUjFlZVyKvgD0riOnp1lAZNG/9QmTJfqnNibwjYiYwvrt9aIvRzoQ5+AHB4S04VWHOXamTnoukKz0UfmzcEMaj4qgEZnXwrJPjpUq0HG5FwTMIp4+DhPOwxDjgVfLmpB38AA/MO6LZuAcK2xnLqkoWb/xHjIQyGZMXb+v3UegMFxQrn0jbmxY9JNpnKRdqYGa2lo60+u1lFJrVrSCBJkzjH2kTbUFJunGiimTe06CPerFAG9IBQlzJvFSxMbHKGrJiYScfeSCOYgGcuPin7Q7MkhGNLGTCJmNMQLPiiBIfpx8aMg5NCPGNIMw+doeJyXnAiYNFVB+IunIC/z9mJoz/D9KNh/go76NzaZxepihzyOFucO9KwUG7bD3FnOTH7NP8j24/1+bQMNZe44T3PiL9/vmnZPzLje7lJRnF65DiWa+xTIpkzPy3OqQluYE6aw7L2E8ZUb4ju3KGnsQ0UUxRBJIUX8Tif96r41fjT4dadXVh8UK9CMM94E9i3Z6I03mGTM7hEUiGprTx4cqBLUgBAJ6nTfv8f5n133nQObw3ytdMzKf/PKABLZIbQyrLUJ7ncs669NQAKZqWtVznFPeVE9t33QivzdT7yslqI/dlGAHfOHfglFTQ2nrABXBMZtXDfPXwm820NU6kC6f68D70pi1m8=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTg1NzI4NzcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9kZThmOTI3YzQ2MmIyYTYxNDI3YjU3MmY1NDY2M2ZlOWE4MmRlNjE0YzIxMmNhNTI4OWFjNmM0YTJhYTE2OTcifX19'
        
        )}
    else if(@pgroup[0] == 'blackwidow'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'CXpxExmu7xw43m4/sp+8cT5VMl7X9vhta/Vyx0idL070pD26fsmXraSX6P08QcBtgtr5gG8FxveSxRTBuAnNQ0agGuyyUGmJBRtwzprdxDK07OVNsLyHJ+LpKTogAjxLhfIEywqgYHBE5VH+LLq2dZQZSwlRqFZfJZoXaa8WV2lCVDXGABVhpQju/5Fv4/cXdPdFU4yKRLxLaueOUt07g0PFtw0+OtwSfgm35ixvdIG75dhq9/tN0gR1bT/JYG5+M/uhzYEwSoCrSTMKgXr+UTjBukOW/w+lr0TXkhlGfDfgGjHhuvKlIPKv/BFU5zKoYtrmhAoLCwkqd7GBGZWDEv6w1gMBTpgZzryv2zbqISybz6YNY77l6DNK4/gsTGBhV1Y8dgC1JcRo/TSWSOBsZ6c0l5YJ1bgm8ebIhB3GfNhUurqjkRCHEU1Cwm45Q5DiFLBtDBKeZ/mw5nOEykYVHtGViyh5IYkj/ERBlGo4b+yVpygcOJzAt6EDm70dWBjM1K8vEpHb3lk+fL8rqpyM7T5rhGltl1Awej7wXIs7TF8/viJo5hGEADzv8DguriFGpTPiN8seqjk8crS2aMs9iy7W2/eINoBQ5Owv9ZPp9OhYjGcY6lAdlSaLFZQkP7RKJAqM57TVzoBGHNwElyskCCa3UawsVyHZuQcUKjU83wg=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjAyMDA5MzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9iMzY3ZDM1ZmMzODdlNzE1MzFiM2M0NTY3M2M4MDQ5ZTZhZTU3Njc4ZWU3YjY0NTNkYmIyZWE1MzQ4MjExYzcifX19'
        
        )}
    else if(@pgroup[0] == 'speedy'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'ICoDMsdRP+AarW6+gyzbD/9SDyQ1emqKZbFLQjHBTDADT53eHqZRNq2NuKB4UPFnq30Wf8sxK/gc1LKQNVc5fhWPkFZw6evmmBEebGtSzyXXK/QLWj2Mqnsvs9MF9QqontIkMUvCHq8SObC7HsTHpwvw9ZqgFJCrGEc94mQBrcV/3KQg+l/dvzcTUNnMTS9tpMUOMFekTkjjCjpmOYkjgmbYdNhPpBQV1rRLxTml+0P/bHKg2KjN2GMpfbwfFF5vqCqbOt6i8Uxe7gkV6bAhCrrkU85YFVmCyHVM78WnatggoFn72Kcj6tf+WBphW9pnY+l6/UsqQh6gx7YLv4h+n1hn4vPcRnEpFfC/1UtZg+tdrfcREfAAyXi0ZOu7Qn9ZJ3xEYyuWQR+XK4/3b9PAR33ViqyyQDRpAR5wqYxeETUL7yWycVpmOmkYmROzUJFMC7H/KQ9TwMfmRbKlZ3vdMo933DKdh606BEcNgCrwEJtgICPg8FqELy4+km+U4R4tm4YpgqLrXlcnhlWPiCiDYG3XyYyCQAN2JqjAY5pwsxK6bcNL+KJDzqajA9o6X3qDCA/7KfpvWVL02HkIBOA47Xnk/TTmcssxqBUa9dwRhjMdG4Rk7Bod0nL8kKfn9TbJ+QbybrTjFp/kdtnyj7nBRyvnq08G90x3ON2HOgwDf1Q=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjEwMzE5NjcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS82MDI4ZmFhNWJhNmNmN2QyMmFmNTg2N2RkZDllYzljZmM1OWQwM2UyYmRlMzBjNzk5ZmJiODdkZjAzMmJkYyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'raven'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'oxyw1FYbZ7DIn1KW6ew67Pqq5PiD//ITNSOHEJWZHv4c2XaotFdKrat2s8osBKTXWF0dcROvS+cvCWM5xVwA8YIFcNZ1biLHu0M15lv8gzVkKPTCIoKC9n19U3fhPz3Mg2cV3YBryqLZCaeQQGZX2wlorpqE2BHj4LtmjTPGzBymoVBLGO6RpZ4u/IbOP2+S4FDXDfkH8H8ytlCVkOHUNc42hSpb95HbqByUcdz2++/gyQKVhVIKnuzl8bi241BRGIWmqlglQvELU/+GGKSrkzOe/uEy4Hpv2fJS/ftWTJRSbQ6s30V3Y3mcn9D3ItQLRPW3WHb59G2lThNuR9cDuJvxfL4S2vOLOw7gy5WPL0lufFZUJ8mGzs0LI0q+tcj3sijtxos6wpfXc6alubJB1HdGEUHLpGd/CJZjIyZVGKuS51A4LpPLgyjZlBHjsvdCmXJuofku75S19f2oz4WUfUytmWrW4Vie/DbuXqFFZfEdvtc3bVnz7qD+k1pdVSq0ohSL1dEhIxVU2OAPktAnlsHtlKTMiKB6F2zPm5i1NuqlYCgroX8J15EiYbHh49kR31cz10/BkRnelT2Ul88+gUmkMz9qtpaqrg64l5Q5IP/+my7vVwZ1MC/Wry5ZNGLRyyzFJH2z/jUXXokCsznGES+Jl6r7eubOd76U2asuYZs=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjEzMzgzNjksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8zNzQzYjY5M2ZhZjEyMjM3YmU5NTY2ODg5N2JjNTM3NGQwMTM1ZDM3OTgxNGY3OWYyMmI2YzViMTliNDAzN2I2In19fQ=='
        
        )}
    else if(@pgroup[0] == 'blackpanther'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'soTo4/s4tYPOPDdaxXMF7vaeEb0fEivWA+no1jrYzCN7bKp/3CX4Sr40dln9Q6Zc7uiZ/kY/mGdszfQQdCTCvuJL0Qi1uX6xGBdhKtAZbqS8qyR+wx2WVramj3md6/wQKCpDt1eh6QsogRfirTkWMjI+16bJzCij6P4Ml9oLylhU8XqmLO1aLRQDL1KpnmGu7st+0Fwwo2xeCbwgxv9NQRXQPjlCvv8lODSnuAeZIuVVPwrxCCb5R4KHXZa/jm6n8nLXnwQGVflUVwZbzGXsbbAVfUjmSxnSF8RAqQd5ilYcIJU1kvbhlirxXMqMgm6YBX54rK3AWWkho9j09I0y/8dU/XAsLBAnTyhfVz6D+cRk1NfSKEJBN2szdDY7B2+e1GUHt9jnyfrENFYYII18nuwulJ2Yqv9hUTxi0OGSX86UCWOQD6lGS6hz5Qp8Cz0hK4eD5wJBOabe7j5YByTSqTkHdCZyxVA3eu98DrlOgZfSWjP6Rr5BMLOXaEVyH0wY3KEAg8qP79ur6o74ZGGLqYLutsQRRJl1NSv1p/JJ1dX+aY/QC632eOEjx4/YjUxKVR1CK0/2eCj2MQBTGRdNMpu6CwI0N9RVSZoBe3HL+pIwe426loQgwYDh6YoSVbhtqZuG7kzECQURFN2jbUMSCD5/EC9/Hfi5vWoEpdha2ow=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjMxMTkyMzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzdiODY0ZTdmY2Q4ZDJhOGExNWZjODVmZTNkZDYxZGFlODg4NzRlNjBkOTU5NGQ5OTZlODY3ZmYxNmIyNGMifX19'
        
        )}
    else if(@pgroup[0] == 'hawkeye'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'BKlhnzJ0O+k+HS3BOWIySva6kOD8lbaMnSUZ5Q4iNKikZ7+pHSmGjDxjqlprxM5zcyy4JX/CzOXD+oRaTPMa2p654zgLgIwQVbXwmQRJNF3ZDu2iwKKQQXMyJ0y03P/iUkgdBMGp3HkLTB9ToGDS6YEZrij+CWf+FDhY9uaEr7uOeoQCgGTT1U31HOBAXlCn+wiO4db+3uMNqgTXfGUjGcBDjX0z2zFGO4bbzN1SinTcOlZOHFzTNDAGNAUcM0sKQzFLeI34Qr8rT4xK9u6HoH/aaopBxPOcxSZkky7FQcZpkjqKc+tTSNOUombbEwkofk5+PA3ILamZxYXBzHB8icQgN8hfj2WQSD4dEwOx7cxiWaodnLciYRAvZwfsDv1XsJpD+OQ55hM9xSw9n8SzA/PXPxYAQNx3qmqzLQzardvtjtMpgdDCeHhS+SlP3558VTRZx0VR9BNJmsrMpgegREhC/1Xg5RY14/DN//KpkJlTJnbyfcKDPVd4NFJfTPIns1WIDP08QnfTN/MEXbACiJ6g8/0zCCekFs5yaDyBffRxhrqK8VN87vJEim2jqNtzTLpIuvHqArNQ9qVSBgrR6i690PwnDur77MQM4ubp2OFX+2aQcDoqgPfA3+C5bb+6ifjhLJoahi440e0uFPvuDFYORawNbRKbvxwp6Zpfpos=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3MzE0NzE2NDQsInByb2ZpbGVJZCI6ImZiZTYxZDI1ZGViMDRhODFhNTdmNTFiNjc4NTQyZWJkIiwicHJvZmlsZU5hbWUiOiJIYXdrZXllIiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8yYTE3NGE0NmMzYWRhMzdhNGUwYmRkN2Y3NzQ1OTg4MTE0ODcyOWY5NTRhODRlNmFjYzc1YTk4YzU1NmNlNyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'robin'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'SQPn+JXx+ADd3+IAmIUYRRbyLnhO5/1RvhPPqnENUWG1PDJl8R5AoSI5t/oDSjwnV5nM7sc5/xp1bwgImlAqTYvhrAFiHxh+qtsAigL2nfgd0jkqesFje3c1tVIjBwduShcZnC+uEfIubJ1JqmeDVt39O27wtkLyhDWm73gXxZ0zdx5vgh/jJRYq96sMbUdSCb8DjrK/vXZCpSIN1KsAj5JYDml55jFTovujmaOLra6Cfe3qoUKVQPDj2h5MKv5B8+Sgl8L/NYFUFXzyy+BlZK7Q/roWihdYoUTj/LOk5PlGpMGzEEPgq8j8+/8PM9tm2yJVawEdasUbq6qGCy0jemQA+yvv+nzMU6z/7r84bscFRxCArQXRFneJwdx3s7aD1Z4FS4R+pzfPOEF0qV945Zw4jUh3coq456XSuq4P6gW+1Ff0CEmrnMP3qEZWG8XXvLwfX7EZhX2qyIlnvtpzsxnk11EIXjgBD5oBofzjwIwQm8SYRWSGNPPOR/QSzPYwMS5DiCAnWy7F6OToVtPIUzBhWwH0LV1lKJ74sWSSGqWi02xIgREXuZsEV6zyIXRwfYEdNXAQcNcJLPYF+KchkGsKW4Vy0vajouJrhlD5YfI0xNQNPK16Xjb51ejpZ2Z7tQCY8VuMVBjroG0AaLB+S4n5KpOacBS95QKopPhdRgw=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjQxMzY1MjIsInByb2ZpbGVJZCI6IjhjNWYwZWZmZGRiMzQxM2Y5YmYyMGZiNzg0M2IyY2NlIiwicHJvZmlsZU5hbWUiOiJSb2JpbiIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYzJjNjY2YTNmN2E1MWZjYjI4ZWE3YjE1M2QzZGI3ODBhNzg2MjMyOGY3ZTZiMjFiODY5ZDliNzI4ZTY3MmYifX19'
        
        )}
    else if(@pgroup[0] == 'aphrodite'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'W4lj/mZSI+D8zzIJCDv9MPgH0hHfj3/wLgEI5oSWo2DSbqK51P3SrjFvGSvwWSrNnBBRMeas1eMl2c/Y+AkKVndCH6np3+Qp3tnqISEDVDKQtx9UGQYcTk58n8wNfXuV6g+MlJw76E+xT5NOdxREWIrgJQwX16O/48BocG90OPS9/ToUh7wigslXeK2ksI7NuxPw0nqoDDwHdpKZmmee+0L812dCYBvvQhwReBI4Oj+Y2ZFqVs2YF+cZUSzagyVorJBNKWcK9OT/mTT7Z2r8g2UFyUUBvb2GShZagmfnl4mv3NfmMst1mpQNkeLtzN6GE0nKEFnRzXMzbqR/IPNjvpdWYwkhTa5yswapFQbi1+GkCKAlXTe/pwN4H2IP8J4yLzd46THlniVdhmwRNYcz/Fcn+iL56PiN30DdyPVY+V/FRFwy1aY7GhEG52w1N9rFuuHMJY/TMQjHvRdO073T+k77l2KOSNiAzwE+AQr6YLNuObMY78JBSE40z0RvN4Cx17vgoN7b2r1JXIxRnbPr5Ud4+Wo/6ilEF3pPYbZ4s7E4JfS2b/SC45u2xx8yIF9LlaSAacBn/g1XtRqvEquK/3Xn2KizKRLR87DN9/56hb63c5dOFKWUWKI5wiVmdg1/o8u4VuYRc9Lgp8g2vmmxPW0NYmuo6H0q8jFMD7v+VFQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjUyMzE5NDksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81NTMzNThhMTNmYmE3ZWU5MzQ2MGI5ZjUzZGMxZGIyZjY3OWIzNzdlZWFiYjg1YmJhMmJhNGUxYWE1N2E3NDNmIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'athena'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'H3qdVn/peycQJe9a6yGx+vrkv2n7Q2GDT8KHV65KEUWb2jt0ilL/qb28VYt50WnJdoR4HTkqD3RN51FPR+e+MXwD+cFdYiE61NbBOQO3K2ou0zShSW5QgZMGmIwDcQpU96fS7juzWAjRR4c0ST+UVQTFwhO1IVGd5L9CRAJA4LwLFGv8h75gQuGPGBkuY359cQL5yo4j/pVg5nmznxRomsAROBgEk7x0thRcqxUuHzjj23y2OqfIbiX1Mh9GxDyt0n2DKnheTNqTZHFBuzPj5cJOQ9Nd3sGMlKn/PSMPlmTRCqqTyLsdY6BC7tfgXZQS3x1jlXMLFBfDNhpBL2m5k4IZ7Ii7OngH/mX+JDFad/KtHY3hCqAxi/flYRzx19x+homZYhZ9dmt9zKwNWWhD6Sr8InUV27SuC3L+mjAWbEAww8fLwRpHndFg+1ONOIKpa2Vs/JO0G6SyEpGvOtkGJpg7O/tGE+1e5Ce0dGYQ8FEqEXCEx9m5q++wNKIt2yeI9xGyWOvYpxof/JPX7glgIm9UpF7CWS/n3kz6zaJIrZ+PnwRMSh6Wq0P8NN+XfvYUZ3D9vFq9iOQ1ENo63vW3PdXIkJa5+l+wHvG70DY2uPyszoGodKmKDqJmrNhfx+6eo+u9gy/t/eHWoRoq/TT01mDKUeXCcpQPOOYDEHrBKi4=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3MzE1NzAzNzYsInByb2ZpbGVJZCI6Ijk5ZjQ5YzUyYzYxZTQyYWQ4MTFhMjBmZTU3ZGU5ODRlIiwicHJvZmlsZU5hbWUiOiJBdGhlbmEiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9hMGIzYTVmYzYwMjZlMGYzZTk5NGFhYzY1NWNmZTk2MWI1ZDk2YWI0ZTg3NDUxZDY4Y2E3MzQ3NTVkMzEzIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'demeter'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'c+O4z2CSonwhDyR+tLaDIRVKufJepLWk3p6lxPEoOJQ+PCR7CD15WDeSqD2uJT2NX+upV3uwSsDgAxNXAMOrH6uYo5Kxs6cY1I3J7YegOR/sXV0qdpmv014ULZD6Ug9u7kem1DJiNqgp43vxYwG09NY8TeQIMmyM3YPw398zJZWB4pr08z4qWLZjk5fldHbfBU5/jxtm9nUDjHXft1l/hGL19CVqZF0/f/0/AwCMEoyWQ/2+EXLjE7mWJZMAw8r33cwUlbU7+6lcOJR9uT+lyZ66RiJbpiIA7GAFiJm0WRowYBB7+Y41EMId44sxoMNsMyCY6ZLXaWZD792OH0bVrcJp+C72H1mlLCVQx9JW5ZI5ljkF5RiXaE7EfLijVBviO8HNWIBIW/DJvOT0fkDyN9YI+nZpVglJ0PwaZr9QAjTPA/byj/+qaKAvB2hFiE/Mh7yYs8allONRCEcDV9lZKHo6jITLuoj+RPhFT791HegAYJSjXuCqM6Y/8d1/V5VYsQHsqj6mp7M/5F5MC7aKgZTMTjlniVvwr0owk3UKWJGkDyfdLy/SfbkztFJpwrgeXbTVjouOFitEs9Z6piSww7evdDJgRe2UbnzcSpLg/zwQMpbf3WgQBPmKS5h+6qobwHjU4+C3hTVISIjHkJHCCFcFH9z3jJXPLH/5b7Z0AKQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjU1NjcwODQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS84MGQ5NWQ1MWRiZDM4NzJkMTE2MmE0NjE0ZDZlNDk2ZTgxMmU2YzViZGQ2ZWZmZDQyYmE0MTQwYmQxYTQ1MiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'dionysus'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'cHaif1orTLpnAbFjlzcLYhl4SPVyx48fLf8y0qXpj5ly3K5Z1Jdf/PWzW1T1Qr2D7+GB1XL52GSZAWVAZuCDtwRXy62YYksfl6NxX9V1clltyyNErV2WRL8QyZbZgP1euiNnkCRjVR6c9fdD2Yl59qWymLoVzwC/TV1fcz1kdpeLF6+yKHjOOsWJxB96AsB0MVPL5uMiiAFXyDkG0p0OgXwF/tGQTUAviXyDBtt/zzNyOSl/WFvytx9XgxtPhx3GsZmYDVgb38uZI5d3tO9mUFSEtAa5jaXin3fUAlCHdG0F3WTq5LVGwfYbRsjKOW+UDGDyU7CXEL8xf0acy1Dpa15Se4/MQ7ed4/dvyHtQ1FYCszxWop1X0Cr7zfUINJbMNxZA25ULUtU/zpXhRIL4wUOPm6Q0qoVPvx/NSNUDnKhLYaf4tLPa27v/MUJWqY9jWgJ2/Sa8MqldawEWOYvwF7kAeP/v4dvTa0FhsjTbDgS4JLVOruRdux4S+moGCzsJ3AVELBZ2vgubIyQ5WDRSmzOFtacS2GDEiY0hGNAs7uKCrZOGDv86+FdQRZmDL9Io/P3jZioT9Eg4FT71CSCNaojOWAZnx/c8RRCz82gGicSBNmKvAIfc3PT5QmkL9XqU/bQFJvcJvt3v+/2UMcbDFrlLzsdXeSyi89V5ko9S8xI=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjU2ODg4NzksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzM0ZDE3Y2Y2OWEzZjRhNGEyNzVkYzI3MjI3YjgxZDNlNGUzOWI3ZWVhMWUxZDBiZTYwMzIzMjkwNTdlZDRhIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'hera'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'lnH4aba7t7O33lmBAV35z3GOdLoKBJf1cyQpyZqFxG0fJ1+mhTa91d/fccDfFJqjCNpHdSsd2iBQywrnu4YA10MX/Pg4GN+2U1LOZuoxfFVMTd0yLaFOjRrLKmwNWp7tauXAcI7s0/K3eGWOkxWd4jvc/3W1N/f7NNigm1cY5OYC0YzjvXybaaAvFxIY2nGesmSI+u2+0WehdG/kButf43Hbm0mVOru6zKvayC4ATA8zXnyqMVi7NPAXu9q+PZqW801rRZVPURUgJgfdebojGi2clj05y2bqhgoGP8iB9/NI+MrZbNYNikJFwoylicUaIQoGZonoP3mEbBXP2IUYaLJ+4Mm4TdVTIK8MT0qHlPz0C2bPExm/B75QAaLM0QiIpQfx/lq9OLYx/mY4oabuffWTk0V3+Go++0I9GXSazUk7uUeop0GEd+lBFtohQcv9OKIbTt+9JSK+yIDRfIpOSVr3XdqGhkyHfts4SHB9z95jKoOIyjeX0do/8cMHdP5J5byn8er9u6kGAxvGbDMynrDYChFxhhskHhZ2XkirGAUOGZdFVMGoG6IglfvVYhYJ4E/wFxMAclV15x4fEog8NjusMzN64p/l/6ApbLOHb2gAe6+jAEFOOYKr0aH0J9x6zbo09e/Nd7pIUU0tytGorz/jU/RMxzI5Z8GMwJJxGcg=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjYwMjA3MzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS83M2EwZjk2M2UzYmY5YTU1MTVlZGFiZjk4YjRmYjZkZmM5ZGEwNTg4ZTU2Yzk3MzkzMzVlZmE1M2VmYmMifX19'
        
        )}
    else if(@pgroup[0] == 'hermes'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'hawkeye',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Jf2OgsEDIaSZZOeFm/ztdqTyPNSGaxa2BMfGq1dFDSbSVb876w6BsP06TaEgPL6YMBnWcXE9H48ZoJSPVg9Oy1KkDlkN7RTFziyJJbeBZEhnmXC2Lhvw8AaK5iQDlcva31pHFWwWSZTZ+zqiYCgtnzKId0iWxgN50cHQ7i1Z6C05ahdtZum8kg62WKlAcWtGoDoIfVVjcXyOi6JhXMu9svem7jfBAhzvqnXG3z2BdBc3qge4e/2o7mdgppH6q+KefXjdkd8mqxoTH2QNXjMvyYZlmR0WzXLtj5faLZwhwTKBopCwwsBVIaedCnxfWZh4c5GbQvCNDQL9frgOBMDToQkGq/fIelqqscCi5cjqX7MM22VgtL3Ya4OGCszCsJuvA9kL7cja6G7rsfZrmE7t5ZyRhJWImCfw4BI+56Emei/UpZ5QbYk8Bvf2mqy85hFlQS2nwmyMuTRfTNFPrncB5VR2GrCKbYUrXQ19jOHGNT/YATLEvbH5B3mWjYnijXM4CW5MeyW1ejx6UDV6B3MJsm4xfp3tKi4zwF5alfCO3PFXZxNzfVED84TaxWHHN86Di0eqfOq18BGB2v3Yxp/FbrdeK54NdF6tSKfQNXJo0h/g9I4MKdYNgifLUhuFKdq5O7q5zUjBOLiPWJ4IAO4om+9gj/UkhICZ83GuZXg3GiE=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjYwODU4ODgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzVmYWQ4NzhhZTlkMTY2NTRhNjNmMWUzYTIyNjE0ZGEwYjY2NzcyZDU5NmQ5NjEwNGJlY2NhMzNkODE0NzAifX19'
        
        )}
    else if(@pgroup[0] == 'hestia'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'sBH7M295z7q12ZfleEf3LT2D6u8zuEGLDTfaewlX+BEucn140gWpsEVUnAVKYqUaKTgzV/BmKhadEB2pAkX9njNJKK65AnUyyaA/H9AcfUX/Ae+YCEeodGUpJWaWZtarI5izyv9+Fz7iCY1JDUIM7aS420fYMnt/UmxjG6Mfs1bgwipxE8gmxvU/p8V9dQTarD6F8jX6P8QU5O9N671ygH87XARd8M2HHR09qZsKRRXJGr2sbWdiXvVGTBVY/DEyuuB/Kj5cG4/MxR+Tn9Qc1XyQpTm4tyg65KXyVl8fodzeBO4WL7D5bEQsy8cxbB6FhKQOA41EO75kqqYy/15w+7a0qb03+rzHuJLtJWHpoj5QHOcO5gSAw4hbgkTJOhw6UrasT/hR4eFXORxqOIM2+1Acc0p0zxCOlm0p+mwgrVn4Cp8Eae+c9TsSu1aajr0i73m+bBmdMlT4ugoZziC3m+shG3CruIbV/hNr5DS9MUkZZVGt8RP88OphX3XZyQw1o1fi+VTyGXcPQNtnFYt+GlEMEnOL0n/jWCVszF1LbheVlH9A3KF6pyeHtPbWx4CxfP9SDQSVGxzw+mnFNT/vkPYWrogwfdkHnhzGLiGGuFPTsQKHqckjHIMY7al8J05goy82/Abh8PiJsG1xBZmkT+9U5jdbVk01JHj7e8O1bZE=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjYyNTE3MzIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9kMGJiMDQ1YjFlZjE2ODI2OGE4YWU4ZjE4YWI5NzgxZDc3YmRlMjM1NmY3M2M5OTkzYjRhZGFmMjNhYTYyIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'blackcanary'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'vLX1PxYRVV+PmTjZNGvVl4tKO0MPuCO+FU/+V/4yd7GJewl43YaRskxCixh5oOLkgRZ0fMZ8uuFJUdfWtUJM6IHcFhA9aAigPjEkBiO+lcMSovVIK7L33k6Tab9af12YPY53iboKEmrMdd3Jz8h8GAedmqP+2G1kgr+0C11IbehtYlqztCPQ8UST2elEnmQWE/GxiPsxfeF0vk5XthUpsrKBHF36lKjeq3Pyj6Nh2I8OWK28pYBbo4j6x/pf4gOZ/c2Dkm2/RQ2xPahD7V3fPWcaZjKI0jU4CRs1anz7Ag25LsVN+JCwnlaTmlMU0qqmfTUE+zIQdcaeGHEiMP+EPOHZyr1WBhUuQ0g/J96UtDhrzFiRHf1OcdFsMGUOnriQrG0aL9MxS/BVYL79TFRPtCrIWLutvG74rEiQm9YW2U7cdx5G2e6Tl5dzoaqWz+3n0SsDnLNo+sDlLxkRyRAFB86XecccuvDKZY8tSIirzYC3KCNT0toMjmZJg4In3MPpIGL3xJyk3rIVw2GKPEDRMvvIbruCGKHzm87mTvEZ573x0E58FnA/EYebmFI3pIx5nZmb+Gxymg3L/9w3Q8B8ejnSB0nTWTX+F511Tes/uNZD359zOcT6pBiugjBArtSvp++ELInKKBFdNT30PihU2xdIHU4pwhutDo7aMWEy3f0=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjE2NjQ5NDIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9hYWExNjY4M2NjZGRiNTZhM2FmZDRjMTMxOWQ2NzY3MTc5ZTg3NGU1Zjk0YjE5ZDZmNmVkNzYyMzc3ZCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'hercules'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'HeIxGeYHkAc3nuq7GRbMf6bdZIRZ/YztpI+lKKKDnIXyqYF+sGxAWUdVE9u3QujXbD5eYJ489Z/BYHJ33GrYZGdkkxdaXLOCgGYjh/PxVhD6RochhEfXVta8mkJlh4oSAS5Y5dELEMAxOhXZbVbOSP+6+asqM+pM6lve7Vod4ZzORL/iK10hvSjWQQWfu6uWaYXIKGGZt857xD/oNh7am4+z+5ffL+NZwfOvCHHx4Eccy0eHvqYnVjYt8+hPWixak9JB+G+b0R3+7KmYIJbTTjZUf2TCejlAz7RqLM1wJIFohv65QBVBvq3O9wXbWvujlDatoydjy7uF3gz1QDYuKWfFHiU/xi6unuFEJtvd2JzCiaeA+xFqWGRwQRAsDctJdP+Cd1AB8O7N1Fx01RP+vOp32RNmgmMXpIgCkVAB7xXBeHN58hcqghckSOWTH80hmVFDftoju9Kk1n31AxHLZ8zQ02YidhLyjaWF5Ksjusw3YwCN+K/sj+x2o8UO1nZ1PLPDTdzsMlXF4OAmhRmfg0dz5RcSo/Q+xrf2C3g45uEV0BbEqxdktSYLO1mw99YF4OrT9lfl14hefIszOaVT2coWbQNTau/PPbisccIpX61rkCC/IgzaTHexM7JEXC4DXkND9fAktAij7HkzBl/NuJeobe1McoBxtAcdiMR4hrQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTIxNzk4MDMsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzJmZTExNjlmZjQ3MDVmYjc1ZDQ4OTYxNTVlODg2YjNhOGFmMmRiZjcxZWYyZDVkMmI2NjA3MzQ3MzJkYiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'wolverine'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'A/v+41l5cjgExm56xMc0lBL+c7ng0/eyizXmCUI0ZuH1MvLt62OZ4g4h2q4iuevUAzAWO8bKbzxeRxjJtecqAKjvKJ1B+Db+IDubt6g9DfBEoUXqmJ/1IQI2k5MVQsHtVe7EEhHIbkfEH975G33QgPNIqV9URv1eVkZtzRkMp9UiU+Y7AWU6zQ7ShSkFGJ4b8PEtXLlsI7OKPaErwC9hDcK8D6MGnxjDmsAEOYQf5htGlJ2szbdxoVFcouyHc028mwTZYqg6NL/LbHhk31segzM0fMSxosjPfDZnl6xfr7NF6jQZU0zDdb9KGUL23qSL1ASIiBqHdaWPkN0DygD7pFyDnkpTej5u2vasAijR2TpjGUEHKzxzPuYunkOt/fo7eVzJryqF1+KJeYEe2CXLZEfj81gKUHLkFDilW6Y2LV1j6cWGq0a44mSGDjNlrXqVwlQDWMqPyMVQ+mEx/L38CafmCKyuE36zxPSwQX5d6GMBHQtsUlAxB1NTEPZG/s4ZQb668T2gJOGgNyTkDgELJrs43hS9rnjgysXRLyJ7J5QP9rH09zdZMEvxCMqRE/8T4/t66FkFC53xSfoIzxfZZTQcgotXS16KcCG5BeK8VtRBSpzciNEENnLTSJcQJVRuFMr7EGcztLwB/CsANKw8MIdkGocGtYOlaX8OEvdsqYs=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTkxNzk4MzYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzk0MTVmZWMxY2MxZWMzZTY1MTE3NWYyMGZjZWM1ZGE0Y2RmOWU2MjZkMzQyYTkzMmIzNWM3OGRhZTM3MjJhZiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'spiderman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'LZpw7NEzmKO3Lr8sOImohBwK6cstWrUP4fZ3AhnvBBCT2C10l5YIU3dusgzqDWFGf/Dx+PZkVRT6DUOt+f+uj1YwIC45OLjDKrhNDdD/lPIFp/1QloZR8+WcDOtuWclJWbIlvExt/b+HCvkW0/q/h+Uq6kzfGQ0M9zUxM+CQhS1jk1fDq3BTzkpZN6JWvKKphTfPPCSSsdYSe4NA1EM6TbFRecbb7RK8Iv5ZuUaBOCYbI5fi9rI2I3DpOTVfapGBipiIPvOjPcfK2otpuhFbsCsm+EeCbOGsBrgIOrx2hTWkUpWoFPGpjXNJAolOojJniskOMuIXM85y6ucbBtf0AHplVNMmnD92MioG7M/F/mwgA9pOPI4E2Ev0a5GBfZDt53SlOsxdAET7jrfFs40RP+llEwZf88UCvHNs4mhp7WPTutrES59oTzJyI/h8SYNR4+psU0EsYJ1GSvtxiq7Q+CXewFh+WAs0c6T6jhCo3/j9TYT2jp4D7pVQcgW6RVx/fAcZJxYu72t/W+zt+2m349NnYXCxpkoifaClE42whKFu0XJPbWYanaHE0dVSUqGihlLWEfEdLzV8tr1twk3fHBVK2Dtchw29GWrkQKgcRGVCuoor3ixEZglv2AMvlhMhJ7Yu2bl1iVfcY3s/F/kmuBls6OfdCRNgutPsie0728Y=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NDkzMDM5MjgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzg0NGNkMWRjOTI5NmM5NTIzZTljNzJiNmI1ZmEwOTc1YWVkNTVkMzE1NTA4OTczYjQ0Nzg2Y2RjMjZiYzg5In19fQ=='
        
        )}
    else if(@pgroup[0] == 'thehumantorch'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'MxlHmRdMhusNaLMUfbZW0Q96XV/jw804bTSxtLiIYMfbBo45miH7UE+gqRXP0x2sF0IBWEfSXifvdV6gmKTMftRc7wLmc1pNtPfAMotH0AKaDVSxnFI7Ea4KCysspCxkIpPBWRfDLyIQQ0MzA9ZlqGp3ClqRnSUiCWN02yr2uWhjYnYkHuJ6a7tAIK6UP0/KnqKmGnMfnU4StZqozoaCaJFJR0150Dlw5sBi8nwULHGL0e4pE8S/gC34qLZ6e0Kf7pfONev6PG5gpQOmZoqwp+3OCJ4+kcGbCPZ3lg0fR9CfRZk28i7dhnM2+9wT+FtrwjHCAQSRSTsRNIgVPdxIvRYIe9S282S4EcsX9WqctrlZ94kMD9evGUvzMXsclf7MazLgNqnO8MvQ0s6jyFMezsDIB+o4sFoEL/FzQr5HfyC4R3UbGGO0OAIOKFSAL/j1iZbPhE6yPeTsuEhbJ7tbCv6Vo2HPdSTMamSDRBngnswwpXS67cO9MzCpxPfYLE7C2AhTzBiT3onjQajEMu0XJGi4jPqJV5X1vs/c3YU/Oo/PYOl1DywInR6yde4xaZobGOyhejWDaQmcTyvETKNI3ZyCtcC6nt9J3SzzAcI41A9B8i9DR3LYAAjP6yMg51+XhJ5IzCH3VBOunKnAfXLi8ASKS923B0n9SEpr2qY9gF8=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTk4MzY4OTksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzg3OTlkZDZmNjI3YWVhMTVmNjMxNmRiYjdmZTBjYTQyODQzODM0NjVmODgxMWMxZDc4NWJlZGE5ZDY3N2FkIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'antman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'antman',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'iL3dsBePI026HHrTU1uYcdCcO0CB/nv5Z1zaSITdhcvrSx8r9nQGx4KXF5v7pDaTCeMvNPjvk1ABzWMNzy6zyhhtpE/rPtqKkmhBzpPyj1VqtG/afW6WEz+28o7jKbC559R/VFCy64IwIyEW68DZ43ZRIsEEce/L+B2e2mtchaVAULid3sq1Zw8q+oRXwm6vSUVgZSMl47yB1t37AW2j1YJjmW4znAw65VFuNxsS4m1qi5QeXLPB0CX2sArHFRHnsLDUJNAhp7Z5OgTBe1kFQRtNPm3gIFF+nbOcqhq6cgKBP32b6+yjK3RPWg348fMyo/TDVzBla0TKaF1f5BAxQVN5A4T3MF+gRV8Ch0X2f3l3orsfHxerT6E7toVK0drJNbTUwSaERz2RqIef353aOqPFGAScTmR5GLlMRRhoWXVDOCHIdS8+TTYuRaHPZh9TLqBuSXMGBMwaEVMDfWlTD1CPsfQ2MInbzY6yMGtuxm8vxvBxsnbhDlbd/ROYhXRQf4R9eMgamGCY/STCmzBKGGMNtZbXpR6X64wPXrBHth/rvo6h+U5iaxNjtQqIrkWlbDl6k17zvQG113Mpc0p5Tg1scZnH2HlOPDalir3ka0FrjJ2p1TJoMbsw+1f63T548DBF8GerXnUY0gC2CklGTLHck56Sj6y+F3uAYVEmIXw=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTExNTQ2NDksInByb2ZpbGVJZCI6ImI4NThjMDk4YzI5YzRhNGM4NzY0NjJhNmQ5NDJjOTE2IiwicHJvZmlsZU5hbWUiOiJBbnRNYW4iLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzliZGIzZjA1MjdhZjA4ZDhlOTQ2ZTQ5NzY4NTk0ODg2ZDNlYzJjZTJmZDJhOTg3MTliZTI0YTdiYTc0ZSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'darthvader'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'W0OOLQ3k7K3s1xmKqupTESQahbFlkO31KGwReSc9X9mtvsFoDRTTlS4b5OMhuFZ2sVTo0d4+BWH97OHrVsBw5aggZ6VCzbZfcYw7Ymu220baRBRwtSiJzWjRjGctaKxrLRI5rbl/uX8MHenVunzi6wjN7xxdv/XLYWGNO8dxYU3rxXVzudbvZwmFqYw/0vlfiPmkajJzjL4RrGLiiw+vmr55o0SQrY18af6Bv9rTbTpBX45BScnavYiHFUl4w01wB7wssA44GgSYVLOKknAMuy7UIdFROMVOKIHWV6WcFJ/+Urb80++YSXsYyaP1pRaeJ//tanphDCp11ZZxNDVbawH78Pw+RIJURB1CAGhELP/SZHKDcegGJsaA5/6GPULPBOqQoNcsSzWL/wYz9jwNAOg5X19FXZuLUU5FGrtW3DWGUE0xngN10LFBEtBuuH1Wrp0uYx2VHAecIJcqknfrlmuTAHR/kM/+V88ac6kZL5mqZu64gbaqRDeo0x5DhDR07upi0AI2SpwPdvY9dN4rG24Ieec9CXZT5/4WhoY/xnprlAyVZL4vVFAG9eyg5/vRjo/wi71FjoSsqniqV00KsFVXcYQZ+/uoXliPxzevghYxXUonfvJSMe9Y+ioRrwib7uhCsXXBvb0+U+0trmI2yoTx8hc9CsmNa7Cb6/jq8XA=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI2OTQwOTIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzU5OTQyOTQ0OGFiY2FmNzgxNWZiYTcxYmEyZWE5M2NkNTYzMjI5OTg0ZGVlNjdjNWE1MmQwYmJhNjY1MWUifX19'
        
        )}
    else if(@pgroup[0] == 'darthmaul'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        '"tDSS8my4IXRrpDW/SEeegWvU9F8kZIvg0gmg9mY2DBBt/1ViZcxnbv61CjztxHiErM0brUp3ZoJGEi9Wgm3kfQFYLILskrgQBdoKo+6dV17vob+5d+jPVAsRJyn/fNdxn04KK/2C5sNgK217DIo4mCe9j6c4q2MwCL9nfrrjxPiZxY3yLrGDMdR9JZSHq6SocASzycsfS9DwuGieX9HdH0Olxm5NZeqXmw4I4EQb6BQcLJte0PIma5uMeKef2etCzxhlXEGKLlIw1YbRJn6fYp9BWhDRI1scRC5tk3uU77at+NNL7y7guysrDZDjszd1yEtuqo7lEJ4H6vbooKvUVJcrRpm2SEsIU2ENnZ1k9pahIpeFcnHjrL1ONhjqjDex0VV5pNXct+qYa5Yp0xP87USEGEoID1qpjvrgluoq2Ntsk+1aZtHGMZkpBXPpuKmRgXQs4z8Cv/ud7YRMoDRjDqqW+eZ1neW1wk2EQ7v/qxwbtFSmhW/Hd1+JQB+VVOSaJZANiJJPge354FFFOdit3DmAQYDp762IVoZ3qwEocOcRanPPkSCUuXpn07otBw/VhUo2OPuJaBzm4LFCQIgXNAQbBSD+I2t5ex+gQBRZgct2/gJx+IqDOKGGafWon7Zl7prh/JEiPauPW6BUliRcQJ4Mjdxf93GYs3N6Gk0g4XQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI1MDk0MTQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2UzZWYxMWQ3ZDU0OGIxNGRkOTZhYWNlMzM0NGQ5YjIwZWUyYmY2ZTAyODFjMTE1NDdlY2ExZjQ5YmJlNmM0N2YifX19'
        
        )}
    else if(@pgroup[0] == 'darthsidious'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'k7KDaV9M5Z6tuMdYUBG/+73lGln8mSk4spJwSTTtlGHYPbiY/+tJRvOK0DiduPM8wMDKqiwfc0XOnzIxPA3llCWDRkC1yNl355DCjWHeeR1L94H4jv1A0rkJBILEVMviN6qwpNpJXo7nGMAASuq2gHDbbUjnpfQ8u7347iQFucGWLMaPeRBgs9wGfaN61p1jEtIfFS/jir+SQEiAg5Un079zDN8gB4/9hsK4r/hCW0+9W0SsClC0VtF/+5NF0YzSOyk99wYLCIBlQzkQYPk5Dy4oPw7i16+hQ9+w8crowuq74IsEt4o1aRD6WfvhGLY5FzAi0zV0ReM1+M4HyTQIa3FbrvYOkvkLpljh3yK0MY+EvFdj3iz63AC9v6Ig8ozraXlekOuiFhCIHvsBWOw7zmMCSyDWjrLTtJiKfmh7S5mPrXG8X0fnzodz0LGn9j4j4EpVhoVXQfeJSL11reEXzOWNxCXv5O+OJiRH0F/tx37wHd3ac3LjXyyeijCyuVhQL5Gh/sWwQB3Pv2cXiVRznU/FNU6q69NoYVvJaf7EwbNECevkbFmkUQYD0Nfu56eoLVUOwB7QI3aHv4W6Qkf4WEde6W/KgipWCWGPZCAQfTN/fiV5STCxvz+Cbfs0uwyfno3QFOxU7LDr0MpsO26a6/LQMpeZu9ptxT7Wt8sKFIQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI4NTA5NjcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzkxNTc5MGU3MThmN2VmYjA5YTk1Yzc3ZjNiMTkyYjVlN2ZlMzMxMjFlMjhkMmM3MTJiOWZjYWRiMzc2ZmNhMyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'cyborg'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'PnkQsIiNFisp5RZj560gNnddjccb4zIZZijvl3iq1Rtr9mvvgRVaJbeKoazCbDmPmGHKbuP3U+QVQw75h56YYEf1mV1KOlkqB9+xILkQvJeaHe5D+4dSWoG0v6MpGjpmmLaC92Mvu1Wyu56Mark9JSY/JYHWqv4REAQ9jd4Zy0oYjAdc952mIQCe6k6vRwrradP9fe9zHrU/1zK/iIIsOtqPT6bBXzA5ALGZebJ6zK5WyIAxuF/m6ND7TYw/UvxTA/YvBGiLa5efvaohe2PPy6bHeyZB6nsr+RHOqr3gSSP2qC/W60tHf2XL9Jwz3T6JRckxg52AATg5yE58KNCMGZRu2ODKJP8sS7mbbhkqWb5tPeOke0m20cP1TuEXbcsax8I9z41BDBacVPfJAGKf0y41rbpdZWmZDkTQKmEtJqlkg7v2oa6oaVBbBPon+eloMU/nVvdnp/9ZePelrOBG4h2KXy4MbHAfRnjYLy+ZWIBLZpGlWj+PL4o5Xoqueu5FiGtu2OFOeh5sI8cLdRtuKf497m+eo4jEsk/fxj5IATqfgCojTnR0IpLH2ntzSIZL/6Lb/3xxU/YU/aiY/xq3aSZ4ke9vyLXv/e4SBe+FW2rK9ASfy63Ujx0GZVqgXkl5qOBP3Qe8sgI+Mkd5OgwNE8UOWfBCEfHS8THtmx12+r0=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjQzNjExMTYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2VkZGRhOTk1OTRjYzJlM2Y0M2NhYjkyNTlkNjI3ZGM2Y2U4ZGU2OGI0YWU2N2ZlMzVlZjg5NjViZjdmMjMwIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'starfire'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Rod5X3ph7ZfAx4NOQF6QhSqenkC1ZZSX53V31+ZxN/YA6QruyCAmRRE70Upr/NwF4U8OWgXdko8O5JeAjqb11qAo5EDMDumn37+kI98NM+1SBPLPdG23t72iSXPlSbXj8a+Be73kaYh8nNA3S9yfCWNnKopUe11VoL3zxv/ZlMd983QAhvRFC6z52gr9fDPa8XGF5ynCeV2yIzQqgC/vA6x+nBhiFefcIYpKn/bsudS36t4T6rBBjBiDQqT6DGS4+a2TCNVwMjcD0i6hcVELWOPrNLnyuhzKOvy/cPoCg9nEVKcTG8MgpeQPx6haVHYKvPSHsoCdEDF91i6J9o2RfImkY9z/mJjOxVt88POk2khiMv2I1zyvb8/5sM4rFc1rwtJJNwiyGX07qXuuqZnScaWFG1lq2/NQAK5PqNlQ1wVepk712pjtXZe4c05zGeIyj+NISE5MU5tMpqcVUeJYr3H9ZJ9NtLHikCdckANYltMNZ+ifioOY9CgbLnOh3c+8aocEBMlOb2GocMFI4B1m+0egRe9cQO737+hv5ewTuabSnfhOFb6o+3+wKKxlbBrbl5/kVEGz6+x8htvxe5sUG5nJt3bhvgiyQErQFn+1rStJBbEueFBY/wxW/CmEVrL4eza7ClMS99WlXTLDSS1lERvMpdtJqIDpR4XJX7uY/1s=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjQ4MDAxMTEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9mOTM2Y2NjM2I3ZDQ2ZDE4YTg2MGY1N2Y2ZmYxZmIzNjFmMzQxMzUyN2Y3YjcxODQ4NTIwNGQ2MWI5ZSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'apollo'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        '87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"P9X16sY7ypz1YpJ+5zdsG4nTKo1w79o7qFh2tHqR8CjPnQo7m482cvSOmHOpkRJEmm2OmrbqDsMe+A1vG1v0HNntQHfoHtYV5DATFi8WQ+oQv+PTatmHdWepRmX6wxobduMznY0A4ExAcFAy80kE42o6wiSUcgJm4E+gJ85Qs86dmU4N3lho+vzI1JIb9Cz7DACysQ+J+zF3+3jlhw05lDTcN5K1VXwj8Mypo0rMrVE74LPdNfMOjXlywi9YqTW8Q8c6GeiJqfR9IKk7maDjVCAEaw6qmkRVkD5ZJnaIosioD36DHSmpPEvEdrKsxp/oLD8O6CzLfBDpbeUkXZEDrPcHNqz6oC8kjSmhzJ22LYJFVMHjsP+AI8EzouiN27AQun5F5Slc2uB6bE4BPuLOTNH6gojFQzfAbDp/Zkltfq5SUQ7Y/3DTRv6y6u+aaswfBrYVMvn3K6fXR5nmCVLNPQZ1Cclkd+/vNpbPw2Rrxtc0Je4x0PJHNil/484zgcR12DUYW6xn2pEjlLCkv4kEBWzjiOxuOjcqqKCuoK+/DKwreEZfnT2uSN+vwcFxVXKZd0zWzVK7kj2gtHKZACc7B/9FqrqA2lvyILKEZ9qRItaCuM3JHf9cWf53aBwNM4udRLDJ4fRkACA19uakD59OaXBUFdSI1BFFKHq2E+ZfGbA=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjQ5NzM5NzIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzc3NzUxOGJjOGY4YmM5NmUyMmQ1YWE0Yzk4NzZkZGQ0NTlmN2RjMmVkY2NkODNiNDUwNDZiYWNhNDZkMCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'artemis'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        '87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"jloZnDMrpB7vc9a81990/f1qBiYdcxxzWp9ojti1HZ0MeFUbCogAsImSrnQ+uoXjnVnJy16p1R7oAsROwIfXDYQLfQ9vmYYtU9I0Cm6EB0xg/IWcvkOC0oaAniJoVog3umVPA30qcvUsvXKP7sLQg/eEft69a/VO1aFGhy5DMF1JUY0KQhu9kUP8AN2bQ/jhagM1E4Xrv3aC2U6FEuz3dYY0b1OaG9wRu2CKB+9oqmporf8pAJF89IWTIOdWYOK4jtGcGPOSJfNHaVps4QhPJ1Qlio3pvHViwnVjrhvCdkqLd1esFqBKuHUFbXDdGbHdfsJz+uVHN+5/6/t4dXugkVrfr1Thpi1prPnxnB1AiRFp+maESo7traKHbRzmCJgtfUU0b+LSRViAeK8zyV0w7ZPfY8BIC2xdqS+1Y3hIAfA4l5z4ltSaq5gLpM77g1aGxTd6ORBckv+/Uv+dMNWtcI5PsQ+feGbcAy/M+KE5vA1VyYQNmmY93SIm7unHsQ6AdkI9zjOjeC76aI+yO8z8Hv/w+nu9BHUq3L68E1kBuqvNtbeiwEaUwa5OQKzn9+qY82CxCBtBssh4CB9ZUYj7RZcv8MXwF5683OOcAXgHnulf8afQadQsEhJxSE8HFA6vvXPrzRaMze7bFwCRLxWflpUoZrGsJBxgInCLma7RwT0=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjUzOTcyODAsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS8yZTIyZmNkZGFjN2M5NjYyOTVhMjhhYzZmMGM4OTJjNmYxNDIyYzFmNmY4NDc2Mjg3N2I3MGZiYjY1In19fQ=='
        
        )}
    else if(@pgroup[0] == 'blackspiderman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'nDRekBs5EBPpqV2AxX1LCW+hRQpnywDqyiS1Y4bloJn5OJEYTyMFolXdQdRRlMBfz/POuNCUP12J1ktrJliyaYv2Q5gvq7ySJ6MJng1SZu4PRDzgtsGI08MAmHFVPfQnCyi3QHNWGSpHM4PuBnFGHqu/ArKLYF8Vw0P8WKuWPGJTblbWMe4Pl1Gtvz28nAz+qKgCkfitsC4NKVA209UWsWe4N7sN60MzPBp7YqQPCM1akiAaN7zMkDmwe2L0mSR3ajESyS4VTX9Ujy1Shy0F7tb6NM9PAmrq3NFMCVcG2cGuh5O1nzd1py77R+Xn19xaItt8TJS0z/Xgll8ldKIQpszHTocrOq1VMWdkhR3zwTG9pdEFj962UTw5evjWwDgID8Ce7tEju2EqhLpsXQWWSyHUHr4A2km7gkfZDKZURObpuG1IQzh75gPBG+cTIBu7X6BEzNUnEatN1uKre3minlVY9QsEDPz9WSXFE9BAlTp3HQg+R/DY+etpz5rhwLXL9+jMUeUycqnvnnHPEFRU2wTwCNF3LQgrHenfUUa4AZ3GDHF4B7W3vsko16QUCjWoGJCtSPQSIKBWK2xDSPj5enD93EpWfglkL1EDzbppJ5SFQEJpiEd1h+n9aBIzrMGoemNS/PvjaKkyvJUg5q271eYI1nrYWd5hIuM2VdlS9Bo=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjY1NjIyNzgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzczZWViMWI5N2E3ZTI0ZWY5ZjRiNGVmOTVmMjcxYTczZGZkY2Y0MjUzYWU1YzgyYjE4NTA4NTMxMzJhZjE1In19fQ=='
        
        )}
    else if(@pgroup[0] == 'nightwing'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Dx75srg6fRc3fOdoKbEEo53hp3R7ypLwJgT5mqd+b2PjFscSiLMZYG3sd/mCgWNpGxx7PtEv0BB2lEwn84FyYswPDgze6Z+IgyX3zxQlm+doVH+8IIpTmfHHp1y4v5DIEstp+kPNuoT8wosfzPdrERs66BdSgdmp30BYNQz28rJ9rTeG4N6gvCjmRK8xKZxl+j4yYiI65mJNTNeC8wniznqhHtuqsuO4FoenRTX22FdcetdrrTKlT6kTBUgDfiok/U3FUm9Pv1IJjwnJni4X69mrMM7/GTtQvlsgYogEwOMX+MzWr/nDARhymMgf4NvADPi+y+4t0FYfvzppql5YgZi1ikOVUBmpodcOAZYBolW6i0HKzOcnxARnw2wKEY38F3lSx85zvbOwSY2c32SJCRoYc7rYwybZA0hv1ZKZkLAQaRL//McnrfpJtZ7gDI1rpZF8J0dNeCkHm+HRH9+o4MWTsRC+dPc2WiT//s+8P0x0BU65+2tG6NwVlivVQiZnsKsASy4br6KhE8m27Sh8TFQHhk6yLRp0i3G5DPIT6neAYRTJ9fg9MxFWZBLOSdrzLNH0lEvwFQNit0gas3ty+oElKbnrBW2ao4GDaaLdBx1+AeyqbCbdy6gpACLP6+h5uhQzGdzsaHboaq9wh1Os0tpOGO8igECug3cr+RP+jB4=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjIwMTMyMDAsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2Q2ZTRmNWU5M2QyNDk5MWY3OWE1ZWIxZGQ0MzFjMmU2NzllMDY3YjNjNzkzOTc5YmFkM2M3Yzg4NGVmNDNmYmQifX19'
        
        )}
    else if(@pgroup[0] == 'superman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'n12HtxORVEoDI6+HUojhNLkvmU/XtC5V/P20SCOhynxgBgqi3xcHu5UY4touepldXZsU1L0SwLcUpDIAaV3EasdmK5onympPU4TDORS9J6j1BC4xivbBkZ9vD4q5f9h48C67b5nDtwUC/xcs4mVfVdaUtSWRzMlIywWQIiwj1TlXhb6C7qe5CRuaiMdGMIRL3xbL9MXM8w2mV3NBtDki8Tbxspj6pW9HhToWA6KW1E7n1HRxmUnf8svzaJ0NQDZ4WspQTyrf2pWDnCJ2CWK9DNH66VEfPtipxCnf4YiuS8JHKtBXOZMxAimyDOdV5RI9c9gMGbxcWCJxAmh3KL5qALL1ptsu2BfMY4cyI4TvB7pBMSzi+sgc9hbHCXYTmpFF8WYnvcDEpcdYmFD5KpD+WZjUbBUeRr/6PZGJB6oMbk1Pn3y3qCSbFzzrOoLMEAnlEOHYpolHymSLj6e0z7aCp8K0xW2PjisApyRVlEGMdeYAZsBtgRoXbpCXU6rS+sHGGkakClSd+TKegyaF5E3MJzdDbONAqBt6i+wcB012W941uqgSLwRQoKYeyfKPmRFaZwmMP1hqYSTevqGT3CJ5DkTHSd1CCCufC9RfpX7ou9VPrZ2oCNdreagn3H1d45NovMaknPqBUmAx//v3autSokR0IV/Z2tIe32ROX+4CH84=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NDcwNTQ1NjgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzYwMTNmMTkxZGM4ZjAwYzE2NDRhYjUzZmNmZWIzNWZiN2VmYmQ3MGEyMTRiYjljMWNjZjJlOTEzODlhMSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'hulk'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'XNLbC32ml/WEDICCgE1dT9vHmvsLSZxvi4aVYgBVHVdbeLkodpwXjKsA4xzoA7D7ro4poAFeHzlpV8BxSjYra4DcIOR8+pfBzlE1ux/XThfimXCEJOLEEf7YHud2nflYXJx7stdmDu1YK1uThvVZ3Z19gRHM5oIAnaeyCeZlY8yiJ0E/ZL6dfG7zd86Umtskv59JbOonHS03kohapZiO26NcbTRD0b7Synsa1JBbsIN+rS7kKdLOMey0hnFeBx4XnEffv0V2GRWntPlKn3xPKq3vy87LNNSihSrx/bdGRRbqx2SI0VJYQBqmEoLvzyZTKSQ+tOwTkuFuB19aLenNksP/aX13gP7LfH6hUVIbPqs4mMPJP+BuuMygrdmIHUQyoMCifniX1a77TpKiJiv33zQ5uMpyVU/jH/nMIJmkKQ+Ku6fNjJGSNS3ENCIUhD/mUyAU1j77PKUHhIxcsvyD1pyU1l255e+uKJgO3QqMZXgKJkdHC5iVk6i1qKdsSDp2JL4exXRFh67mYzl9TTlHKWJJHkUCF5s6b6TSYJcV7ltVRU0grtEAy9iYPaGr0PIYKiVVv9WFt937T+LW+gD/Zkvv5xlDrBiftb8uTW/7XnU1GChfvR7bRuklnrjfUbJ93WJL+md5AMFXC7mpZVYzPKT0NIp13tf4fxRgVZQ71xM=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTAxMDE1ODYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2FmZDYzZDY2YzZmMzYxNDc3MzRkMTk0OGE1NzNkNWJhZjY3ZWM1ZDM4YjNkNWYzZDY2YWYyM2ExMTc4ZmM5OCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'wonderwoman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'aFYtShn0ssurOM3u+EYDdoa5VNl+4AntNAPXZ+Bc6Thkx4Br0NRaFRvh+jF6D7UBQGeP1gQ/CUVwewnb1GMQFl6CZ9CO9595tGUf28UzS8eCTr5Obt3Vla6CHykiQ5/l979akX/Hm0hFHBQ2cNVBNKIEWEm8XxUjow6JwrgfjhPGADiFITU+x/yMhXd3mD+Af0leHjiMmDZgmxEp0DxWgWM78XcN0vEwYo0vOR4RqBWgGgqrIphUjfxP0YmLzBibUGMOwIgRiI/uShv6eIuXahpoUv33PzovAuGJYVNCh2N6o1kp4vcE7izDtDuuyUDXnW6NyGhnG24wIFGncEwrsWnDEcGfoMdcarCxliYZ4mzdKXH6EPV0MmQBnHgBigO8T7nhXQy+cgXxwisXOqZUOy9zc7lD7vg/BkDqw0OGsqA6+1OfNaQFxtsajC9dafqjDwJtStkYImpm36mtYpJFLwzvOYS/kZ/mKWUX7Jxjjdh/keFR6zOwJMzK1RbnzkTH7VM1kJj9NyhKB+27bri3WUHw6HmS5WoQJLFbH1gm5CyGQzOCjclsoVxPlgUTiybcNYR8+3kWKE/tsx/q+eGuokZMVAN2ga+ohDVOLZQdTJj3htIteHKBTRX4GzYoMEJWrGMo7tG0QwKYvfuzsJt1zzNckygHluwpUT79yBLn7gg=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTIzOTk5MDIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81M2QzZjM4ODYwZGZiZjY2ZGQzYjdlMTJkOGJkNjgzNWViNzNkNDJkODk5ZDQ4ZTg4MTU1OTYzNDczMTY2MTkyIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'flash'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'cujvw/4jiRBXzm+Tz7Lziq6fjyMiqbAFUeVJlMcBI2Ku6DDySGzuXP3h11iwWU1TyxksPON7BTyr7rqjWon0QuhoVsXrY8IrF9bRryHSszU1j/8gixLknNKxKb5VZF0g6f1mggKt1J5pLdwOXwr0U7xCmckKuCOKSIsSBNzDLVt+NrjEC/p5KiGo0MpSkW4X73X9zHyFH+qWNiBuAYC7ZrjRYtR86le7QvtPAuYluJvLyjBlcbiupaNJnDElqwCeV7gzDzcyNQcxJmFiDXiURXNO/iyBhEawLC3I33VqaEKbugUgbK/fBik8ZbEtA/Ng+SNz8UkC1KefqFxCWHJr73whSmWyqjGZp2u8xCb+8+H8zm+n6tdKB61sq4k2i56ifPZivtBGlFxiYC767lYe+A7cjBGdjBmpHzibz+UfwTl+t7gyabEaTFJz5tMKs+wd7ZRXK71r67TmJ6R3/8ypmzLLv67tRbnIp0YrVtRgVmI2gdP2Fagi7o3za0O3lfWw+F/5azwzqjKo01JIbTra9IN6+jnuCy4qG/XdCSXQqPqUNVFvdfsyqafqAdyWtg1WvU0DMoQzVupaV3wKObUFkVjnnfJL7U7gQwsQbYzViboUbyhuIWN62tGVWBpvdV3OFPbE9GyKyPkQOfZ5rhV2w9uZpop6Y594smZmidE715s=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTI3MjEyNTcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2RhNjg3ZmJmYWI0YTBmOTk0OTU1NjRiNzNhN2Q1YmE3ZjE5MTQ3ODRmM2ZiZGMyNzgxMjcwZWUzMzcwYTUifX19'
        
        )}
    else if(@pgroup[0] == 'batman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'SR15FEYOESBW570M+IKHpRjykgMd3ATxyh4S55Up0OUobbFPyhlZqh0i6lPm11Gba9v0+B8JT/dPeNxDQuaKgLJoA8jEFVeSdmN4hnd4X//1To1LrQV6LNehxQKHk0cs3l9DSsWR20iBgwN+oKD6Ylie8PnDF7nzXVbNsE1ZcV16DyEyiFp75vXl/CYYVsLWaU6WQP3ghCzupGfMPHFgg5xBzmpO1JTARrh5+awjcpMv3jXc9XSRYTEgDKpMgyqQVrNBlAtZa0r+s7s6HBgYPz3we9S54J3JtpG+gsbt0axwFgCOXoF0fsojLI3VIBVDJKD0ORpZw9t4zG3PaU30P5o7wwirEAwRqVhQDmamBtCYqYARuuvOfQtz/zSIrhaUuqpau/IFu05pro/IKBQzh6Yc99ARjOoscQQR8e200f9NWRCnaMaLEAfE5u944BOILjW4A5SPijQLd5VRZCp2HzN7CLeM2P1RLcNQF3eb3G+7PZN0wiPwlATU36KDhbwjHj+r3/y2FU4KJLvC7ulNBXdfO3f2C7cj387fQwm1l/HgVwUvRLVr70YxNefwXFWh5xekCMv/M82Qjr97vbQ9LY5HCKCAb/HgDz8gU7mxOiCrYE1Oc6yfvA2Oq8+Vw6E7EuDZLfv+v0Us383sS6LYU3lvwtFOkrcsDtlUfHY4ypI=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NDgyNTE1NDMsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzc3NjZkZmM1Mjk4ODRlODk3MzRkNDI0ODRmNDFjZmZlOGU4ZGQ2NDMxMzc1NTQ0MjQxNTg2ODdkY2VhNGFiOCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'ironman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'RJ6VYTqYh1oJMwnOwPkFUsqC9IWVd4bXl4HbVuXG+D97I3XVZE9ldVgZp2iUlEuNoO2Oq3hkR9Ue7p87OWUw8C4w859/EzkLmNdb1rns+kU2UU92NaeqhpGyeLE7TDsNDhIxZRMwqWNinw6LWz+2XT7/WbyYcPUzKgORUkCtf6jxf96A208IrU8yLTXsWizDcHQ24qnLlHkvzwIqOgNzTtozBUSU2kyY9xE7YW3Kzxh5qK/dnZok7Gf+blD7NY050pua6UkCyTjD0OeZh1JSOW1HN40QSQjAIe0G/hqAbNjUGyICNOQUbYUDQn7pOziQ8Z8RFTOswaJsXA2cqlYOYSDLQAnup2xMqwuizvfkTpk5fdqqAyjImVpQHjPE+kWqkSPCgI0yKoO/gk/oJ3AeS3OllVIB0pJzjE9FAPklxUcx18lrHbc1fwIpOHOQ+9L7RSxW+ft0EiGSfe56vXQ5ae1AjWCwXlXcbgOMBKxTmsVcU7wQWIfknlI2vcRVrJGyQA1TnnhF4PqIMkL2UdEW7Mr1nZhOvRRpU2lrvEyY0vyfpa6ZMmSvcJK9SwoNePwrTk6nMTdamKvuL4hGVzTeqlKEoe3SMiCHjZLYqD/POPPkTudeVQg9l1RQXy+Bhsd+0SNpP+qYflecRyo2b0PwD6xDp5IL8nGhsel8/yno5Ew=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjY0ODY0NDk5MTIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2VmNzVlMWUzNzkyNTYyMTNlY2JkY2I5OGQ1ZDcyYmE4NDU4OTRjZmUxYzhlYzY4N2NlOWJiNzUzZDQ0MjcifX19'
        
        )}
    else if(@pgroup[0] == 'ichigokurosaki'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'ckxM1Ts7gjMy1eqSPgpwncEi7u01NLEFZqJCLIRe6BNkYR0xYoHNX/EN7lOzEViBNboGhfcVp2TCHPQxxwZV+b39mBxuDXJN6UiDJAt+V16YSc8lipdmAjfqXN2V7jZde9YZKL1we7dFY1CHk7bbxpK5X6ZmbkzPp6COeJtMDE1gL2J0NM556crOwG+/MWpLf74IA7SYkR1kFBWkORm1ZABHsuUSMs7vw5LqEMEMj2KOyPSK8AUoAe+vpE/pE+i20k4FysaLV8Y9pLaLSTSqYacUkaetk2V8CZeHuKREeyN1hJUcAAxRgHPlRftDmEs8mlG5r2EpHoBRTd/vEtlst3nU78OdIsSsK1YvHXdFQAdZSyrtdEHAT3cDhnxT211cAvAO5cI31N+qbE7IK0AZaVT32eU0NEgSS0jIVcTg3JKTrsbqKW5Sfobl40YOsk3/u+Md4d/njjzw3QniJy6rbx6vABeHVbMZ8F0dlwjIONgIbpuQnk+gvdQ16PQe/lUIFLjyRRv8qgP0iPi7vFXVlsyBLgdbqiHISxD5lLHM1Wuo+ufLA5GVrxNh0neHvoP1Gx0w5qx2agQuLR7XtJ94UKaCpILYwaSHzJrlyhJot0vpr3a2HUzEO55h7kvjppkCSijBBJOFlMRCgmB4BUD0JCWNW973XfE9q/l+TIrd1io=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTU4NzQ1NTQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzIxNmU5NjNjNGY5OWEyNWI2ZTlkNGI2ZTM2MDE5YzUzOGY3YTM5OGExNDlmZjIxZmM2NGU5NzkyN2M5MDllIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'supergirl'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'TaRns2lsGjFQsxTAvIzjUz0Nsh34VUTokC19ezKHFsNRfWUFmZ51Ab4Tox0kIfy1YDbc4fae0hn7twng6BWnUnYZh88oEwJp3QJbmQMt9DdkUwazruxKs04hRSgT426Es32glU4D2p35IdhQljQXcwtLU/iB+38ssOTTmWETM9WKm3mrgOoot0UuBCSMYXBXpp5phu3LnHk0cfBZqJkqEsDMKPrw0kryqxxRwy1mnCMHHQ2yNErylC8djZGoKGYMUD4EEsBHGwlch3jEGL+4s5gRLF0Qu3+vOqqHqGGhkP571OfHoUlvkGKOYzrX6LDUe+p7iqZxHtRKwQKb2cn8ZAEfux2ekdYUfecbrvaLS+/rX9jS+5L2Ohk0CVjDv4SE1B+npqnUMThlmpuNaBnum3amtM7l7LsyYtbENLpWo+keICkPJfRnLehrgG0KzTee8V18UX42tdn0w6dRZwN+jdmsujSdILw+RE6ctsCEA9ZNgjVdSmQInxA5OB/MQVW/Chp87JlMhdCn4HiK2W5f3Ow5DuSnlz7XOBVEvoqzy04HuAhE5YR0FOxCGFqYlzWOBouCmW899+8ppSo72lt9YnAoKOUGR9c0VYxo/RUKaRcgeZu/OWi8qwfYCjH7DseiNjVedCigBvyH8DD463wJ1ZSwUbw8t07FBWaBvmECDfo=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjA2MzY3MjcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9hNjg1YzdkYWMxNWVmNmZmYjMyZGJiNjM1NjkxNGJhZTdhMzQ3YmUxY2VjNTk3ODI4MjkzN2VkNjA1N2VjZSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'storm'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'O8tTjrilmyrr6SY8bgVxrV1NWQRz/QPe6qaKBvEaOyBmEg61QVQko9QKK8WxWd3ylcAhsm8jQ0MqV+9+BEly221o0SG8CnmPQAk12m6LPsSTygcEzaCqyyLstfO1yQP6SDo2QnJNHuMzqcrRKstOYkbwDBFbRRdUu9rOfO+Lcj6rflVfVQCyvyEKroPNHqSvHPg3c4UB4l9XiVIIgZ/qEBM1GdckjpdsYX/iW7w98OajGNk4t96eE8jCZNQqMcDuRA4NGz3YcoJ1PPKOnumo638zMsA/Cu1bfjPjHItUlzj7aaRAx5lvAiLG4MeOL/7o61ZexsZbjqRrZ+x25TfhSw45syP7ZJs/m8iigEFDh4H9M/StPDceKDzuBS3SpADLlAbYmtqN+/JowFN0FMXEn8IAA/Y2Xruxniqts4Ox7hqXxdWu6KgeJ5vtlx4CunEF17JZ819JRW0Q2vgbkELgyn6Pd7J6lCWvXHUw5megooA/skwYxBmfZO42giv+dB6wHeXnS1igA7DV3trD5V5NKH30xiQRV+wjh9rjeKQb15bqzYfDi1/LK7Gu+7O74FcZOZ1xGFf6TyWP0Zw88EyFDVwQUsbail7Ohq69up4yLKuRKk0+TwyqQ6G2rAHBIUdDW8PUOaUcz/vh+xPNaZ3epEwR1T1wC9ftevnliEGy8CM=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjY0ODI1MzIzMTksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9iNGVjNTMzYTUzYTU0ZDYxZjkzZjQwN2U1YjQzM2RhYTE1YWYyOWUzNGE5NmU2ODVkZGUyN2U4MzYwNmNiMWEwIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'ultron'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'vMMmjwhJlsXKfnqw8Kp04RY9gEF8w6OQr1wxmg67Ga6McFTnt1V+LPGRDqEVpGk+KLfJynb/HdljCKMOD5+Tq8YgdII0lgnU10MHMXiI+HWe+ryfxCT5R20QmHhkkPzzArgJuMOktZKxPx5e5yfIPhJwI+xNwNSnrVHDaPu8Tbze9yraPEaSwjHBnTsfn1xHCmB5OSZoWNIst0Te2NfT2sCll/gjLW6BMKDkfEfmKSwDpFk+MhdCrdYwiWUjtlVokum/QYx/GsOD+vxUMpqVnI66hqoMncfT1Y4eENxjJ1tmgAxsAOP6GPhJkSMnRyO4s3sSR/kEF8xPga5v+VGEd+X8FuHQ7fOM0zhhK6pieP3tyxAka5RbpqEUzGiFH/hBOKS8PwJ4ux0OhfAuP4p70ABnI4e6tL6+nZUpdn3rcmwlb5CG8dkWeUCzRAum3YaD78Qzs4h8zNg7eghODX79j/cEoH7ue08pNVvi6sS1PCxHqXJ8xeqhzRRcxavCr8ho/44JrsHiHPOfVVuH3j5EnhVGGvUpiEbUQ2vlA0S+Or6zsXlrv/wSrK5UL0liL3PoaGwuyZshjuFFkmc+4h4bmW2AOwm2Jz9ZP2UHush43SH/L5/YaH7R61K0Lviws6JnWAXj/kuyKy1M7bQVm6wHOOmDu14OavNMSd7vuaiPGlY=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjA4MjIxMDQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzU1NzM3YjkxMzU4NzdiN2Q0MGRiNzQ5M2QxMDljYTcyYmNmMzIzOWFhZDg4Mjg1YWRhMzkxODlmODNiMWEyMSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'martianmanhunter'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'F6K95H3K+oi/1y076l2ewjcV2hZWewVj4lA6pFyuB4t2jgtv1gkuDMr2tOBeWZaO9sH3J5lV20wag/pp28CP6qyJjh7aXuS/llrz+K4CxHN9j4K8ZZXYkegLWEAfaxIcuQRBHD4GDEjuff7JLemqo9fqykouIUWthCAnDKctjpRdRGa9S02PZo4hPSJ090UM8sbS/Gw5sEWfspdA7eMbIoKAwK1XjCsOhfxJBczxKihVzyakGhBWn+8I8NclqIRHwx3/Yl2tyZeVd/tVF8BOlBljYxdvsE/YlcEhdgHHZKqQPXrn02UEbjtqAPMSpbmtT47YTW696jBKEd1FM5wptEy3YBC8LlKL1g6kslQmWQcl1a5DrLgv63vEm0GH4zThBKzSR7PbnYnfiXfp86zruMFRc/Nu7YrmQlW97YiVUIdfS0Y0mUaI/YgTbCxK6mEYXtjj3qsERMEaV0miPcYM0rK253CWxU9VlAF61B8qtvLNJjSDHAwMWB3WtAxBz8cFDYfdXWFGNJq38P1vUst8ihByOF/bG1XkKAJTo+pXImVUa77EoeQXsr09Js+mVkS0722S+Dpx77kirThO7eXxft3pwCw9FpWuYHrg0OUPFdHLHeEmyQrDneW3ahFpFyKX09OeZcYiE++tpjLp2ZlhXEV1EskbvF0lqXa2YmEnG8w=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjIyMDkxNDQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzhmYTkzNWRiYjg4YjQzM2YwYzlkNzgzMjhlMzcxOTYxODUyNGMwNjAzNGIzNGY1Y2E2ZWQ1OGRkNTZmZDZlIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'warmachine'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'lNxvpGKhNTc7K/7O71pVvLzRNrFS4qxd/v5zpY23Rezn+a3BcuIuZ/yKT7UPHbsAKzetcvgq9WUXDzyjiQZpkiv1ibH531a6njuJuRj5t1Iq2z+N3PjKmbAefhSeECxXEgzA5DRlWMyAUWGcqfSkjW1nFteMoeQXK/xLSq3AysWlptcLB74rWllddv+dVcoES05SPHcwQbyKVE/IMCm2SGyKJ+JLGgnQkzEL/uHgcDw3eLdZOOi1h7YuCjd3mr6EvWIUuXmhCxkpjyLzUu8Z0u0IqXh2JLT1aaaJjUgNahwqXCWBmrZ4F6MtFMrTTHeazLE5Lf/vqR0tEEqkph6sP99+fBXvBzvHi2vom0Zrvp+uPQOzpQwTczbnnsYxgHVX/WmUut+hFZkGW5ahFxjtojBzPnCyneyrHIUteIO1ntvnj+ErtaMQ6sVqn7s0Uq5Ei5SB6U54jB0/MwSV4+tU/Xo/FkkVMMlej/0ae8lvV0u2h/E8rX4ynSiq3ZQ0Vlb8Z47t/v3llFzM83l5k5h3XotXoLQ5BBahIiQDq0NG3DVyH01em6Kemw6N8H7xG36nENpOpnqMIE7fAjuEIuY8pmdUgCwwrIGHzRrmZHI/zkQY/YT+jOT/GTGRpfuecBJXKDNemp8pkc135ng0MpSjMhl7JN4d3rTK0pRiytgPfzw=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjM0MDc1MDUsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzUwMTM0ZGNmZjJiODM3NmFiMmI1ZGFjNTdlMzM1MDkxMmRhN2ZkZWRlZmEyYmU4MzEyMjMyZDFjZDA4N2Y4NWQifX19'
        
        )}
    else if(@pgroup[0] == 'hephaestus'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'D/HjWP2y52oRI3F3kM+9ERT6ycc2Kc32ryJxQNLBXl7yeqhIqxydxQ+xQNx2jvC54KLC//UbT9Q0XwsaUPHipNu9xN9zBaJCUK56gCh6G6FpqG4iO/cRB4r7aFYTNrlhWm9zBncfrol5Ia1HBHUA3LV/keJmO0xCOBI+f3n1msHRUfn7JRx4Tg+eD8CRjHG9xYhLw/RXUkkKC+3yJEg5liGBGPR7hgHrlvVJ5dc4Ct0KYzAz8R2Y1jYU+wvhO5S9LUFE8w6lHxKVxKUuAIhzJaLYVXylpzwgoE/LzJUjfROYrIGaG770q5eN+pLrgRJYCXNBlGo+JdUp98E9i8gL1ZuNC31m5PAGYuUkga1OIe+5s/YBvEhEIdLyv4deE1sG80gGkJphQUmsLD+NhMQ445DmfpRskJIN8I4Wa6vThGDfpBdtRaFAFtgHeGSUptdmOJwMd6E7HyI2Qmn40jBLjFpupg9ZSqZln7tfL0YEPDaYxivhf2ubuUkBznLsCsiZ0mD0GFiVl1iSjPm4wNwaVRp+rsEmPn/PLBjTAgCAB+RxfIpP/UMsW4utstDxTYWBGhFOF+bGRhwqJAl2ze/uEIav85zyguXTtaeh+2TqQZIUdwucQRSvbmbAJg5mh6xdtLatwGA9KiGmCbX2jP489raKTwkwZSdOm9xwBVuagts=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjU5MTgwNjQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzM4NjIyOTE0MzQxYjQ2YWUxN2Y2ZWY0ZGIxYWJhMmZmNDc4ZjBmNDVkMzcyMTE4MTRhYTI4NzJkYzk5NjMzYSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'zoom'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'RuP/oK2EqxOla6NrkgmCnPwXPF6C1f6xpegE8cUBM/hZsZzqztcRgupKiTFwcAKWcKbdan/C6iPiVzsv3pxRBXt1S3PjMVQcsF/KsG03UP43Au6SCge+vxvLuOpeCeYj8SdE7ZbzRTHsLdjnREdqnpt0ENSUHkww23bqI++uYqPXwiYV3S6a3KFrj1rDXzFOjC4FPEAfsyRogkAhImpeQpQxDlMT//HyYoIgEzZMIdSHyNEcORwJhoMdjzz99xD87FlDZ7HpkC6ovu6TRxQFtRrt6QLPERDJgXA/A+R1Zz76aLej5SuOIWmnUSH3joK1H5ykCaD1DLsLsBv9fuG4KYRfib6tutDux+se0CCMyrFl+m40hGXb1ssu7WkMcPjyR8gGERrkWCsaEA4+utvn0Vonys3t5hkjwDQJMg7foTWbgRH38pzBSghOXxvXGiOZtaA0QX+6hKjkRh5oJJISHbrAs2Tg35QrrSh+jJfiioOhyqNG+DBt7o7HPtg0ZGxfh7UWIR/h+DpN1tvqzV21+oi+nAa8aJAAZZ1T0VSVhfeMOXG1ies0zBMn0taaUL6jLGo4mCjnEnxDBZQbCL4iDtxUd2O0CoQP3Hwh0aeBytPE1WiDNBv7KleeoqSjzjHCH35oLngeeMnsItzRH5AY1fSP6zRjeEPbS2sL5rH941U=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjY0NDE0MzcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2Y0YTE3YTUxNzA0NjZjNTRkZDY5MTU2NTFmNDViNzY4YjBhZGQ3NDJmNDExODlmMGIzMWI3MDdjYmJkMmQ5YSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'naruto'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        '"fRJ45wSY4k4rNR683M5CxI+7hcl3g7q1xfdWNU4hL9NmN0lLrmVgxkdgDOmeZlUTzQKP03Z2zDc11Jw5yPhs1FHct62uU+pEldSNNCI/X1cPHS+8KmpiACLroBzXvd/+nmoytf5c1zvveh6FphhgixsNVINvMaMR9TKDhdJKBdnKY1/XPIjHHW7Rh7KGAr4WfVyUYbiNKyz0mRSfxMttUpJ0xZoPj1cz9wZq9pn17BCiuhjTTVXGOdZ5x6I4i6bTblb87vE74g5KYoBqaSiKjI0dPSTaSdmIXjNf2liu2S7x1ZdytjlJIyDENWDee8naAMIsff8qX9zG82+EpPhgNN+WOW4KHXb3j7hCZo4oRlgIhPHl8TdmHmwgag1WkA54z877wERQ+qKvST1GuLAVxEnXxSf1k7joyaw4AinCx8h4X74abLsHFbAzrGmIjndDxLH+9AKZi4lidPdQK8yCKKbgx41nMHRNpqi9omqNoiCo9oCfp9Q6fNv7NrMwXCkRXAQBhQS/ATOXzT3u4KiZYirTVgPOLGZ8gH8cEDWP60VsHuRxfog5gbffEL4HkBgMoUpf2I4fPG4PYOL07+QixRpbJNiLM8DvYf7oke7LSHeoCiD0AtoFE0XbS3nQND7oGcCS8SV/LsbqwhRwLEfEdHebLO2Un3hHJ/lsJHtVnik=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjY3OTEzODQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzM3YmRiOWIxMjc2MDhhMzdhZGNmNzQ3MjU1ZDYyODQwYTI2MTc4M2YzZDY0YzZjNmJkNjViOTUzZGEzNjllN2MifX19'
        
        )}
    else if(@pgroup[0] == 'aquaman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'PaTXS0+nmGzOohQTzRihnvTkiegnqwcWP/RL+Y9YbNUnshgFY/3riwpQZc0kPczrOQwBQPy5xnVUQXhLaD+jD76vUvrdSOsvChb76MNrFi8AxPX8iNFv9st9UkOMJ2bdRhYH3a3skorIv0oDIw6+jwATqnxmUe3BZk91vanHj1tGG5Y+eYpVpbhiRpUmnhPEf6zGvwgxID8OxKzRE+ZU9ou227b7ljRnV1iIoo8IVN7oLm5m+SDM5B6FAljN4EtYxkPAuD5pCFGpgqM81uZtNv2t9wu8NpfW7i4MxQr0RX2B5pqOlb8lOSPTpBOH/DLiTED2zlxcwym7nVdaj2qtW3ukLCwqz+6FrWpr0X8ODyfl6qXjYhuIaK8a6Zhi1PhVCWUxKR5P3JdMDBHqMZV1dbknoWxdX4c+Bk5pL/URagdDjQYNO0qBPGo1Dgxxz6etTDRpfye76mka5S4tUWrP5v251x37rpuavlrgCKB3Bc3BYdnn4GaNtyif3h5sGOHi7+e5MBa7jTg2Nx5sJEacsN9lbhgvYDGGmuWmVIW99ElKIdJkLJebJx5JfDJ0vRjF+WMD9zNLEB9WYkJGh6cLTNZlBu9G1idXtBO7x9p9mBjylTonQrBl8nI4Yq82ldZJYUMs718TZJeYKkD2AkbNME24N8m377vkorxuD3ENIlQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTMxODYwMjEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzkxYjUxNDE2YmU1NjY5MmMzNTM0ZjM0NDYxMTNhY2VhYzgzNTM2NzI3YjZlZjk1MjdmNjI4YTFjNWNlZTUwMzQifX19'
        
        )}
    else if(@pgroup[0] == 'greenlantern'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'thor',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Uu/s2BKatMUGgvb2nZnEdsNL5glQpOaoYcuripH59JAG2eJ21NRHl4gkR2BKUyZ7yfWk3tdfQH1S2cDqXCD7UIBPdQ7byzeREBuzDiKhbaZwN0xuqOrl7FXCpHIOTUDfuKsleDokXaXdDcKLVnWbvHC+ulFjegTjgR21IgoqJRylI/qB2dGwnqxmyjS9cnzQ4sby7u02nqD/fOZ/Mf5fw6JHdQjbWsdtEbBau4ztyANw45DOsYvc5H0Ns8v+qwldXaLwaAnR+LKqQTBxNuqNKd1XbWpOv/Q0VH/4vxBYb8yMrSchYbqoVmiCDDN2BOHuGevrnVPsbvQMZErZSLz3QrltuAOyZKeYLb/Ay2pFmbVIhijN3Ptwx0YIc8hG0l1J/wiw9k+63UZSIYfXrs0JWMRe3g6ppbLfwgNDwSq4LI1SGyYYA84sO6HlafD3ZqXXHvlvL4qvjNVbpf8KXsMIQlAvIBudkRZ//FX080IVxkEeNS+ZAdfBR21ZnVDZ3ONJOzwLpmkqjDxaTGALsigC0zl3TNCAAyGVK1dMkIaPDY8illj7Z4yawWHm9sbKtWoPr7ItkiwCyxSf34lO327nT4MkeAzmllGSHTPlmdTv5VDnwxb13lwQfKkjJr3TZw3J6s4w+doP6jJb66JVZJ9inNc6sQ6AYCOyTOF7SOqRrXQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjIzODEwNDIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2IzZmU1MzQ5ZTJhMjQ0YzVmYTJkZjI5ZWQ1Y2Y1OGQ3M2FkOTI4M2M0M2JmYWIxNTgxMmQyOTQ5MmVhNzQ2OCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'lexluthor'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'B2CnORq8pQz8ooyfLjkDKGro7+BkUWz8Yf+kKUvg05vR0a/vttMflWkTbPlUlOPxuA0Ni2jsXn24+VXXdAj3Qdc+J7jOk+RJqNEiC+RsMKiDbpdpfjFs21kikNpNEMO1NkWMbXDsjvikuRlQXEQt+9oIYOBk03c3gAW2+XsZVescwXFaii/c3OesiDL+jnCGUf81O2dddqWpE3fiR+w/GSrfOopoFIeQo5aDOapT9ERF17OHoveP3fJY1VholAMFzjQHHOfPEqPE0+3neSXbU8sDdmOjGNEHV5ic2MU1CBajTMTdr0glSqmLkfF6ZJBG6pDv3WLWSR4aZDOo7rryXNH+vbNDuiPNUSetjnH6Fg0Z6hhVxVigsysG6h3o03hbKRbnJMJTV34HHmvDurbSmeLFLtDGQvYHscnhOE6NH16SOXC90IwVggpA1pb5dp/AUx2VQNMNDGaTT+tFFAD8PRlOvtV2BEF3Yo9Xbg9WpoKM/q4OOWjZGBH/5BO0xNuF6nkPX1BYpjh5BSm8Qb2f1qtNrGXGhj18NUod59Qn8JrLvmmGZIl0GhF6Ejb4YE6XD7nLHvolC/D8Yj/rw7jg0vQjPhtiS3j8h4AsryZMfsShTvrVZ57vw1AXCF8V6+8PyU5jMyaYvr6Xm0quofQcoiNlwsjypLeXKNSagARB17I=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjM5ODkwODksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzJiMmIwMzA3YWY4MWJhNGViZDFkMDVjNmFiNzViNTkyMWZiYzQwNDgxNTM2OTM4MTkxMWY2NmVhNDA4YiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'thor'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'thor',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'cVlGgL9zjSgmXeS+2S+Y4KS7R88XBb+nwjDZrxDLUEyM/BbJGrvpwml+VTr8UVJ7VQ9pC8hbRZ/XrYnj0Dge7SmvTup3TsvN7wTqMIYBF6TbFrt9JYEhjQgiOLUUjYK2JZfa4hnnZEz/8EAHXz1tpcwRdHNoQxpwe4AF+XS6hW/TmMjav1YPBvLSdU1Apouh7RzBrYokFAylysXExfmuBVVJanOAnVXNm0uOPkPE6/xHqe6NAoAADgQXoBl7bWUOuVBSSiFixJH0gJZeDERkKIGLmGOYzZeOn5doGj+t3frlKjZhcyqJ5CYDcG289L8HxU2OciFIFI20sSs6KFwqj8DHj76/Sq/9FixBNITmeJ7Tsd0JmbOPgPAdAWqwN+1WK1I3ImiexZp1xPn19L12eOMdE2RZLAkOeAFemKMSdCZnHQnW6yyOk5bH9uhkgYsFFB5rPKPUUl2Oprj9Dlit1FUuBqgL/Z7cW+LjPG2itYUnTp5+mZJtmiixoVKXG5ll7N+zXpY4n7AWzZzlki/yN20sbFgiFuW0oanO+R00B1UOjfjA9+osxUgAC0fU2khrAA3yLik785IzhUq9xaW0922vKviETwmVUAiBzjo0JM0Mh6REm/XM76th9hLaZfRvvKa8ahPF0yuXJwUMsBl5vRaVsaEIVrZwC/lunBOjHPI=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3MzA0MTA1NzYsInByb2ZpbGVJZCI6ImZjNzE1MzI5NDI1YzQ1NDg5NzExY2MzMjAxMmY5YzhiIiwicHJvZmlsZU5hbWUiOiJUaG9yIiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9mOWU1OTk4NTliYjBiYWNhMmU2MTYwZjA1OWJlNDExNTNmMzBjMGZhMzVlNGFkY2E0MmQ2YzNjNGMxNGJmYzcifX19'
        
        )}
    else if(@pgroup[0] == 'ares'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'thor',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'lLK1RWt4hqSaA4rjPZVurxuAldWTuz9jMsnwcaGXfV/XbqHqr2EFqwzGKobVNI14FT0r1vG2LORmXJhkZgIcWhgg3DepoJeJgKr7/oxGJe0El8F/n4rZUYPxNC9Fr5sfk2MTYey5wzOL6QN6vViVp0nJ7hcSOntB5oyLaE7o0YVxOy2z3aKoq/RYvCUX+QVLQrQfhILJxkAfnZF6WCuCbp0wknZ/gxYHPk5vyr+Kqep1LjMyM8JtoLRWaSEThtelJYhEC7QsjYLOuDMTWHW197EFf0+UTiJY7OTl3KDoN8dv0JnxvhSNCXU5DShG3YlVoooxUUENRlmGWw0+X4NZq67X2KM4LbMKcTmAgTgcUVGD9MZBMbx+6VZflaW1VN+V57jB3/JgrZf5lmEn00wTI3+3tIE1NADQqkoRsPqDDLH6pNjykZoAB/dayB4P0xdCVHxkugr7hmu3jMyA2l77YNrmZFYhEd/WQ90P4JRsJEo3U1X2/BbwStAwUO2vaizluiyEk+2w6Ax4E9Hh5WAunCUSdfTus2wHg36ovNslFpixJ2KLGwWxP7lT9UFMqUveCf+kAn/LiIqxMNJ4ksNj538DSDu+pq7mchkR2v0Sb8F/oL2Jnfv0OlRsKnX6pSC9JDO5ODqW1W2+6rX0pzZayrMQdQUpUHyZqwrmKVzN3sU=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTcyMzI3MjcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzI1NmM5ODk2Y2UzZGRkNTlhODI0ZTNiMzZlZDhlOTUwZGM0OWE2NzJiM2QzZTY1MjAyZGUyNTc3YmY2MyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'hades'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'FsZNvFSOLUftm2x1ULYBi67MxVC8pTqgep4WQypoV1mvfC47oKin0ihZCOMg7peDslXSZ/fmAKXyni2UAIb3YRccBtQvjrWkt19n8gSPfuzTcwRxyZWHolve4l5snO3jBv2bwYYmQt8qiwcuukuK4jXEfYOrMTcco65Zt2OTvfNGF/GZj6fnvmcMxRoJAu2R8WAhwWtHCdXtWgRR0pvcBrABuBJ3ew5nDB0j7we1GD9dYHqKL8XhIVK+yzNsRraYukMcSHsNbW/73zNEFi1oEV884Ywzcvav9go3kCYUX164+cgZdNK/MEEpe1RhK+fgtV26Lp5uEWX4T+Oyzz4Fv4CDmkml3Vzr8bKnYrwi4P6wJvDLGQIxMGED1KD0roMFCAVtSBHumK/BI+K+ve9WGHfsKxPBrMpd8fNlexDpdVfXUOyA7drG/cW5hzxFSoAubH0Qah4OrSI73ZF+StVIz6CE6g190JtUDYtwXjnir1vq09GnfzXqdCCGa+Oa2OCJrSOO2cZkl6bEZufY5tG7kUHHBV9DCYePl6hlRIIXl0HzF7vVT5IeAaMTDHTobbGk8ehehjT38DNcatFqQ5+AvaBveIotZbRDhiFaVZkMxQfJ3zq/PqZ37sDWGLjIJisUeSWuKsMFP10xN0VjLNG4FQPCTLN22aI5dZ5/RHIuTXE=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjU3OTExMTgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzliODE0MzdiNDVhZjI0NjU5YzIzOTMyYzMyOWUyMjRjYWQ3YTFlMGEzOWVhZTE2M2UzYTk5ODVkYWUxMTIifX19'
        
        )}
    else if(@pgroup[0] == 'poseidon'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'tszjiRuFykWGDmesqHb9EKEpIB0PSglX5Rz8d4wjaUEMgL7910r2dqD2whLygkbvYlfmWbh+pgNy4Hg/C/+kSFPVGhy2CFkUAwMLf/xXgAbafiASPy9doBxZQmwXQBTpsKisxYF55Uz+XC9G4ALZ/WUnzi+yfMuVWGocZRJnw4W6uf0lkyaJPPWHuGWJroNQkgpmlkAqOkxFhnX3ThLkfutie339X2D1YfyAWU6/pCjKtFcGrLWsNmgcXeB+wAQYwqtuvGUNMRr7IjMgTy2/G6Pr1qrnu8vd4YNS5mpEsqmqZFf6PEdsrrRsGKTrgmYABmd2OozvwgjmI5XqSscOEmbdxG0FzPXORyujuVuAEfQQreMlo9XQrQL0PXQscexrC6yQr9XR0RK9KL2XgyRhVH3VIwrFcNACpFXqbprcERd8HUJIDDRleEs7qGcaduqkdpwXqqxAqBtFG4WFavH4RPjtibqxj5hM8TreAmVJU9cG9YRboMBOrqbK9+Grwh4Y63jzaOwGerT33z+YSgJtfLV8kJkSibkxb7veFUJgSpxFEt8ahF669Cv0yNIm4Ai0vTjAeCJqYZZkTKMsPKl7dKUHj624Ay13KsyfnRZ/aWRMHvbduvZPatP9y3iBvJ6Sxch+lfR51TtJjUKfVogZJAchl37P+Oh7Owc9FK6hBMs=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjYzNTQ2MDksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzllNGRhYTZkZDRiMjhiYzRkOTI3YzE4OWRiODQ4NDBiM2I0NjU3YTcyYmFmM2VkZDViMmZmZTc1NzJlNDMifX19'
        
        )}
    else if(@pgroup[0] == 'goku'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'OkxWl4LWbPhZcKlLlob59vZ4+cPVtcjMEC8z40Tu/evDxNlv7AkHGtWrxajr0dbei2gHR/+EyFvXletcDJIp72YDC3GEeHasOLEeg7joKXCdOwsyFalLRn92zMuLCqUEDxi2nmh0aoYdeZBBKet2cn+ih604IMyrD9e7FOiLp/ucmS5vtrsGTlrwpA8bvZwauKWKOxsPG54GcQe+gp2e0EAHnPNIwPNMl0upX7pfYEviToPPDzo/+ubZyiCefIxBVLultecyOOC/8Ox+UBjpDrtRaMT0vM1OMovc7uzneq5zcyGIEduGAq6DrKB9Iyc9DxGCIg1sQYIxsvQCOAFXhhBOjjPka0PFZH0Xsh7pxxzqcO2BaLvi2gPRVml6UsFEz9kZGwC9XNBYGbqtkLXzi72WA2Vbn7TZefsLKXmpBZ6GamB25/qFRdevJUNKIONUGo22P0y6QS9GoQWjymOVVbh+aipQQjuY+X647uNeQEuidUNJ8LV+WapglSNJFUdS4GBap5arDCSQ1bqXjcLZiUtlPS7/Nvig23PeLNn+mMqki7sG2DyF3nxj0i2PVKuugaG1yIGvvXLNDopdmFtgslDb/GWN02yZxLDOKnZ9aeWjBluRzH5FP3li+X5T0M6Dr0zGw1iQmHAcGhKlQ6yiAMWa9z6977kXnWTNtbEh3ZQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTM5MTIyMzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2Y5MzI2NjFhMTFkN2ExZTJhYjMzMzJkNmFhODVjNDQzZWY4MzQ3MjU1ZDZmZjNjMWI5MTQwODE3OWJkNTcxZiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'vegeta'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'o0uUtV11lIT2N2GA8/Vs9vjzCmmcaHvfe/5ZG96esYiDm17thIaXafKsZgWTsYAlkWtCalDdmfQvthCufFpbV4Ep87X6u5dHAtXjwlkv21Ic1JOU27xU+Dxi3IQKg70GRo7a1qKVRcw/GVhyBHRtoEa5/Yc0Rw+HuXewHvou6Ouw9EfyMhgoOP7HZRMtx2OskCZj0TmBwZAQHuiCvLCLmUGSTbfOhNUKgvSGhnx48QCiTpqrriuLQetzZ/+JR230GZ2hSdxxlxMSfs5dxBWXCUltBAzEgNyoA/Hey/URzNcBowYjnFdOeqiZAfO1lJxtCIARelaC5GAyfehUkptom/ic44l0JvKVK/iyxN6soZZjwPAn/ZNm0qTuR4gM/v6PcJm9VJCoQXO9zyn9D+dQ9MInievr2jdbRTjLTcKTs9CF+RB3cBC7dGHcICBPycVXOgNZfRz9htTdCOtW0GgVkzhN5PPRTYv6Ao1K5XE9UCaXLcS0vhwOLyICox7X2ddRUjs1VV9Uu3ThEFK2fZnezysJNmWDx4SFdcIqDQUH0E0SQxespTJSmYRjAsR3OE7ifkbkpS/mYdrOsMOmuOWCH0YcyMif6HtQLlfstamY/Vvtm051GOX55+F9Fya9zRGBt6PvdGnG4sgVsG4Q8YHtM0R9YsIK5SeGKxP54Nqi6dc=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTE2NTQyMDIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzQ0MjRjZGNkZGMyOGI2M2MzNDFjYzA3NGJmYzdmMzBiZTY3NDZiOTEzNDFjOTk0YWFkMjU3MmQzOGFmIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'zeus'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'RBSeUkE0yh4MALgfnwOeDzCzyaw37UsawF4rDwKziTO7fURV/NbmKtFPBW2dkn7dcgGswb0mQb+AEGB5YH3V30S0hgPLd6O6Bs4CiH6s58zxnUeqiVbdTLv/GD6dxQ/COV15hKR6yYADcTcvXd72bYhVJ+bLWiDZqtZpjJ+UZQiuQEfN7wGjgvBBQG/zxSs6Zbzk519ZBR9Gpq9B4zyYHxTLD3jemjrGaMJrUoS9XaljEj8cZydgZ15dckWMn78S/Jygt3Ync2BprP9rGdk2TFUcacx1pRynSP7EntBBIBRnrS+walaMbaxhDRZiV8CDqOhxHmVhnrFWd8j1YmydWxDUlRgxr7LzIXPYuyEljtkIKaEkXb31ytHnSAAYXcRoh4uakle8ItHTs/00TwYbYthJHJ3Pz9e6FaXmoO4us34yiBgE1iBLW1fyjPa25U2Oye4RNXBVsRP3rT3cX9V48+hyJT7MjfsfXyaaQq5iaeltpkyQXzYgG+dCtEzO9QNy7+xDT6h5dUS4cLR9qNyI8qhNujYF42bZnBrZ2urLtltuBiGJr2HnV63LdfnJGjTdkN63ZYT3JaVp2+faZncrKDS4W4ONF3D0Uho1XHTEijnR4AeX21TR4zEaKMS+NoltjUOriL0F0/Fh7tXXncUHszyRZbzQhmAExvb2da6VS5M=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjUxNDY4ODYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzhjZjNmZjEyMTM0ZGQzYjNkY2QxY2UzNmY0OTI0ZWNhNGMxNjhlOTU3OWYzZWIzMjJiNjYzMmI2ODU4OTIwMjUifX19'
        
        )}
    else if(@pgroup[0] == 'doctorstrange'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'sKLXddFVzgq1IhsWXfuDllDcJAVcWkDaDIrTV4aEQTXRnM52SpAezE5uI7fzLxU0RLSF81HCkzAhQUhsd521HEv+YAdmh7xcATT9JTLWB8VNx1tjwcPatmiSmVzhZ3JZ0GxkZOXYkhnc/6nGN9JdKlLrD7w4wgxOZofEZ9I/KDgyIq39bP15MBcTcLtzw844ukGBkdadgNFtkZnlwqSfjcOUN0Csremu45qDc7lsvAa4ArQeNi5+zSjV+/k6uGuN2MWDZBsTeQvf/RIQGxJdmBcPWgTpPX3RYaC9EKQc8OOetW0PUrOoCKlTv3iI7FZfyvGpBeLzC4l5W7RlFbAhM8SSGHTW85p1zUMhLd/RsrNbY5Eh8wKCS0nyeoVxVr44pMa0Tj2T2LqNVR8RT4snaMXl6ZsxL6hKJw4Cv4FDbK3lFB0iVzCb9oXniq9585vabKqZcHeKzE6RbT41uGk/1y9e6k8WsqJ4prqwMCTKbvMF7tcaGMg4A/tK/jluaho103uRiiOOPbQCk19gCNSxXISC33I3N9MO3v8DODoclAmwttEUgIlW10t+aMtmWr3r9GLN0TlnhE2iuSrExtTeXN3W3bBKjZUDpWkrqYO9TvkbAfz0uzK/SjJ/3OhxyX8VS4Hz1sXqp+8M1O84iNKrLGJaRyQ+lDCM/yCRxWY8op4=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjY0ODA5NTY0ODgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2I0OWFjNmU1YzgxNTNkODRiNDhmYjYyOWJmM2U3M2JjY2JlZDhjNmQ0ZGJjOTViNjk0MTRjNmY5ZmI3YWRkIn19fQ=='
        
        )}
    else if(@pgroup[0] == 'boros'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'n9LrlCx5Ydzr4uKLflHmcWCZ7pwmRxygmBRt0zf/Rx3CDi7k+Vm1Bq+EPMGCbp9MX2V7ZzgZtyO/It3jrVHNhRkVIJ6/78lHksit0BiTEYGxeSRE80MCsnEiVaSiRALtCiR9QU5dTR1/73PkcfQsj8m7n9ASlPRIie5/dNCmkI8TFfII3n0tlbbsLwp/8ElUFtN82O+Xhfc1XLzaSTJrsIVtg175Sk4JSt1VETpo3AQ6ySbFE34fwL1wzKp8bzDW7MB9ZGnGVUxCKU0jzPGVB7R/5hJRxaVWgZz7VRQPnva2XzSqd87wirWXAtY/JFNxsW8uMvUMEtHm805QWnQAt14OoO1s4OCRZ0T+5rqqEf1HP2eYc1Qx+WrUMk+ESuDwDQkgG3ru9o7thziwAWtLLmv7xZc6rYPJ/DgeKvz36VEanU9y/IUcaufZ3kElRFjoEE1ELJR7MbjSg/pdf5Vdqb4rHjiQ+IuDW8VKhHjs1eX4/XPFelN1Ui9EbWu9DLflo4SY4fBYdLeXyuqZqr+KjgJpwP1QNuwztFOKw6NCRGRQ/Alaqst/S40RupoPioTtIgW13K87t3q27h5asrve0g5Ke9qFqi7AsbnRAeG49NL5/OTkQCEGb19PpBMOWMWlvF0Ga3LBFRezGEUGRmJzh4Ojs0jbwS5IKaQ2aibuP+M=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NjY2ODY0MzYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzFiYmQzZTk1OGZlNzU4ODdiMWJkZGNjMDI1MzQzNjQwZmU5NTc0ZjNiNDgzODlmMjU0NWU5NzZiYTQyOWIifX19'
        
        )}
    else if(@pgroup[0] == 'onepunchman'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'YqEfqse4aHeaQYupLBrg85bAlPWQiWNyHoGBsO4D2uzxbfi6U/bUc2UeMNl3F83szuglKi21t8bgiUM6MT4KG/0vL5KAWKS/JeEm2sAWhTEJ8r5MPJ07sL7K0ShCwHOY/w1sDzwPI2wntdBRL3PF/fRUhH6yIUg64yvG7aBTBcrGv0z7Gz7k7WqAGUcu4iv4WW2WC3QRn7Qk6JhFVJ2YAeAkHZG3NDIgCtcUlUWruedeezwnZ8cEhIJm61SZ+06PooDC756CS8igtNQX5JDfOjNEmjPPoDjSGFExr0kQTUWDOuPOgwBY2NroyPhw/94vGmQos/qjCKLzZwLhX9ILGnecOCWIos0uTMmBZxMQ8HTfXv8Uw6xTQs/xJxqxt5cL3zddJB09cw7fy7y0WcTjcqw/itPvmxmOUqwGe+yDAbjV2A11yi8Ca1d3ptLFAN/qkDC8mxELwlZBMFdout7Dp6+6ovBXdv5PfUsqDzFgRpPH3UbDQeOf6cYG7MkVr2MUYJjr/ZnQPoaJ6hfpTA7GesLUjJTD23P867PoBzIJh09R48YdXc/A/C5okqi1t8LEgBiTI20yTFoMBH7TJ0bUdAu+Crc7vvbz1MHZZ0JRhtkvm/rue6THa+6jZ9x5NhAypXJx9vODCq2l3WEdJAoQjgCN9Y+JxE3fjRFD8MNQDE8=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjQ3NTQ0MTg4MzMsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzA0NTcxYWMxNjVjYmIyNjdlOTkxNzZmYzdlMjkzZDY4ZWEyYWQ4NzU0ZmFjNjI3MzlhZjFhODM3MTE3OCJ9fX0='
        
        )}
    else if(@pgroup[0] == 'kidflash'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'lELtZMJ+SSeppXs+2Fk6aEaBT237vpJK+6nJ0qiYv2lFNvy+r+IDpr1G6jl7rxfL3xPrSs3EH+efZBStRg+3BT7z52v+qKzBJUAiWisz2d7YDDsYKITCvIlJWN02MAiTLl0qn9Ax6pkt5gne8Q5KY30YCyuL8o9W7pGX2gQuzKm8FS5NfWgT+JiT2pSYc6iDLUdn+eKF/eRd8y5+Q7LcCKhMA/L56NkIn2YpE4KwW+3y16PZwDh2k4ez4CN5OTBDe8A8eUO7DqkvebpUyyYpYIkqendRqNlm2C7iVCU1ZbUeJzAEwYLUNBWwL45ash51RppmLG7eofABD4YfTDPiiP0gR/7qdO8yIOWFm7DeNEzDOnoV76zSPLkK3mjWYX/XzSS+q6QU0e6USCA8ow1xCH8BfwOOawnt0Bbh3NpHaTgj9L7tAZ1MfhQuF3083acA7DwA5I4iQWqTZvBck82HQVBM/6hBEfTB/UyJKaDRJ6EbSQzadw4wiQJN1eOal2QPPUnfEs7PdANJRYlqSv3HdvakgCtbvqMnp/8pAFUPXEwANaEZNjk46vXWtJUDq3z21w4RlhbQlmz5a2jxwFbNbpZdVRjYhGjwVpkEZGzeh31SqRKXQ0EW6jDeYRNSYXkWQnoChrtRqJ1g5VtNovbzZ+yY6862xFjipeXr4uqP3i0=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjgyNzU2MDE1ODEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzcyMTVhMWUyZDYxM2Q1MThlYTM1Y2Y5MjZkMjg2ZWRiNTQyZDk1YzczNTVhYTVlNzQ3MDNiNWZiZmU2YTc1NyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'howardtheduck'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'HmlUGgGGZQHLcZBLL2F6HeMzAXfjQyK0F8KQyhTOS6jpsvGWb3OuxY9wjkZDzEHXwBFRzLU7L0XJeVCB+UzvOxtm+01EsEMnm0Kdz6PRPSw9m/fDFwYKMphivWg0nQBi3Euu3kb4nanH25Ef9Pa55LrINPTYY9PQb+lsbAj8Ept8DixqIDudtfhv1BB+w9Wz3Js3VIj7rq56IkfX3lFDSdM0FkuXI5FyGBXN3s11iUvaA/socncmz+aoAOMrtzMDdqi1qXSPfD10kTQStRkFx43iQUAtq8PcGKFlwlDZj+L/I04OdftbOoUv1I37LYbe9dFr5RnEdSRnA6cC35v8gepHilaGHheYQlIjWEjfSM9wGAf6R+/MQjkB7ofjY+R7o02Y1bbDeL25bg5nxLLG9yf0TjQ5MSBwBANuRtM4OrpV5ou7Rdmp7m+HDXsA1PTy0wPmr3rochHmFucjARqfNUgk8yd6INaEWiAQUSa9r47M70fv4LpRtUNCAFPDnFhecF+WLP8rtpe0CwJ9DylVxE9ww2LWmmiGy1WSprGnJQc71ZQpsDY4y1sS1X2MSLTAeXKxyZVe2gRNDUlvnc98AffbzDlsFS+oDhDLebyLWyz7KgTVFpHKeKoXaLHIwuHioV3NbB6lvO1nCWMIcgAeKiz79SuQmybQq0UHeWdevyc=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjgyODExMTA0ODUsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzQwYmMzMjYyODliNzkzOTEyMzllZGVjMTQ2MTIxMWEwMWU5MTM2Njk1MTgwN2FiN2JiYzdjZTg3NjJlNGE3NmIifX19'
        
        )}
    else if(@pgroup[0] == 'magneto'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'goteamleogo',

        #uuid
        '0130299a4489429db4eb68643a4c6ac8',
        
        #signature
        'uK6yrjF6fTCe/AWAI9Vnmh0U0ng2RewCb9OA9g+SQITHYkew4/wpO/Frvtb1sWnszBEAfHrXrl/vXtV3pTwOzzMN3YB7M34Qo2Z/KS9TassekOoAGGZTaJDK4JpOCdOOGnemJI1YI8X5Eh4ROPdR6DyvfnuK4MfMgJr/I8sCX1tReyv1JvuPVkeprsdGUSUmETdHLYL31fvOM/Zp97FkCiTB3AuKMawZWCE4s/dGBN+qqI6Iw8Qw+lhzT4OGssBUXET5gZ9eVV0HzPbko6P+R9kNYY9e1PRZVI4ZkkkCo13x5Sos8iic4Ei2D7rmDqg16dM9jYP/sHH/+n2kUavR6NieyRgb5dgYDSiQvgJR+F1iWsZ312ThnwVydgVFp+S/tBd4OjXJmGNFWtNAg2SU6XsRw5lQ9MZKwhihgp/MND9B4tRT/Iz2O83Qz5Iq92xRlBUHNdA4aJVA1Ndxo4RFn3w7bnTPzZgcG2xpxwS7Gg7MqvucDbqfRPd3hxckC5zsZGiR+Ju9zAi+gGe05Sn0uCxDHCbRnRyDqFnGAW18EXpSdRfJouN8NTm8LxB7V84EJrWjJU2UzdzDJgC7Vb4pXfIEZRpDtZiryI5zk56/C5i3U/En9sbsbASRbbCihhM2b7QS3uhlf/8s/w7TPYiazwlgZZ0PpENDZo82RBmrweo=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjgzNzYxNDk4ODQsInByb2ZpbGVJZCI6IjAxMzAyOTlhNDQ4OTQyOWRiNGViNjg2NDNhNGM2YWM4IiwicHJvZmlsZU5hbWUiOiJHT1RlYW1MZW9HTyIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZTU2OTk5ZWFkYTliODgzYTkyOWZhZDdmMmU5NDcxZDQ1OGQ4OWM3ZmRjYjg0OTVjZmZhY2RlNjliMzYxZSJ9fX0='
        
        )}
    else if(@pgroup[0] == 'daredevil'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'goteamleogo',

        #uuid
        '0130299a4489429db4eb68643a4c6ac8',
        
        #signature
        'eq2UCkT3YooJ/YxZp9yoMyFUD/XVKGPy+BkmAPJ7i1t/5Td3k/wVb52VNJlGQm2qHoXYcpmubammjB7h+LjA2fLPS0i8DEpIYrzbjQoRIeSmkZ0F63pjoGjsQZjwruT0OOLba133ICpwMuNNwsXmiLYButvK9KpTHvkhCEWY//czYid5v81+2WvV7qJ0KYfJzbRfnwmtPDPCZ1pCHsy9IPBRJaO5mWTg4zuLTarEzt424jPwS1bHGIkuI4Da2Z6NerRsQtsgBv4wiHzY9MWhOuDH8/gP0dA+ZZ2CSDown8AtzJc6A0XdPA/1bP+DY+zzt9Oauzou2cbnZIuArk2MCNxdO/nJ4wlHnyUrq+sRTo13p6jd+VwA8M9r+29nF0eRcl4zN1taP96+VfIisewj0zHk/5kfyzn7Ux+j1k3uY8X4DW1YEXauzHKYlCb4OQpn5D7WD8QqwEwmpdc6P0GZJW/y9IVFVk/e0NFCrSbSpqxQT3qaFk0fhOgLWRN/ePUX5KOt9R+FKdgidV6TH/680os8HYmAuieTA1YJa1aJ5fnVkSWjjd4v42NoYrNnRjWQ3s+8Qu0ien/d/TH3bsKoUNPj096+R8qtKfUAh/TSL6IeVULOQnQbJ9CNFxce4xL3PXwQ7anc5/5q14C5HzF67Q73vwnBPitvC+KIkkfLKBY=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njg2MzQ5NjM5OTksInByb2ZpbGVJZCI6IjAxMzAyOTlhNDQ4OTQyOWRiNGViNjg2NDNhNGM2YWM4IiwicHJvZmlsZU5hbWUiOiJHT1RlYW1MZW9HTyIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZmQ2MDJhYTFiODQ2ODRlOTE4MzRlMTE4NTgxMTYyMDZlMmZlNWFlNjg0ODdhYzM0ZWU3YjdjMGEyOWM3NiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'reverseflash'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'diamondmaster03',

        #uuid
        'cc2d2734e7844250886d5c6c714bfb09',
        
        #signature
        'CVeuYW+3D//vRVzraEwgfgh4zAJORpJLvMb/yehGyBYAyWmN1c4M89ZYvYLhyhJfUsGFKTGKMAB/PI4lWqOVkJ0IQaDrV3+SBw0+1LdLyxfhBjM98bNqj36v5eCXeXeKGNF7k5h6iRR+uzMFmgzP8TvHnI813n28LBmh7dHcFl1kWVbmhZc2YbTGs3zXgQ6Psi6q61LuMjkIKeN0i3rMF7dkGgblpKwpV6D8kktgcy2eQJtRCyUUCrDfa/+Ntp3Hck52Enh3kyLgBcNipq8aYUqBH3BOfgZln58LvwkbCflTESvZm5NFfcQAK2qLltdKkKGrCSOowT6mADpTU1+Aakb9DoCD/Oke+wftM6FEu6qZ0rilewi3OAiGqojmPjbvAzy3aHDGQ0Pi144lcCPMf5hCTeQCDfPmE380XK60+S1jI74q6RIn1DStDZYbD2NpE4tmxUUKbHAewjqlr26/5VrNVWGAFxl5LynuGZu6Ryc7rItiTi48zwNBNRfgRsPpxaqby1Gc0XYBWweUgenoR1sSFzXSwnpWbcs18IJXcdAWwPh/KTy+9LursIcWjZP05NnPhbK2WCRelS0Y1xSCh8cBy11JGmZhLPmyV1BTFsT6nuc0j0GMP9N21EZjFftGNluKs5MRqjGaNopYm8IlYA/iWfqN4hs1XWVRd6pFGnM=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njg3MDA4NDI5OTMsInByb2ZpbGVJZCI6ImNjMmQyNzM0ZTc4NDQyNTA4ODZkNWM2YzcxNGJmYjA5IiwicHJvZmlsZU5hbWUiOiJEaWFtb25kTWFzdGVyMDMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzg0ZDlhOWUwOTQ5ZDI1ZGJmODU0ODA2NjNiZmJmMWVlZjdkYWFmZmQ1MmE4ZGY3YWY0YTM5N2Y0ZjY4YTI2In19fQ=='
        
        )}
    else if(@pgroup[0] == 'blackadam'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'diamondmaster03',

        #uuid
        'cc2d2734e7844250886d5c6c714bfb09',
        
        #signature
        'Ichd3mbmOE1rOu9WH7c3HW7BiMQaPDIotJ3c6qyYsH5VaWUOnzIVXAX6kg1RhfklLw8ydpy5c2f/yDZyWw9EF5ByNvzCKxfjAX9HkmOWONb80T9m9Zq4LZ6KN1peS8pZsJVEI87Y971p4lXhe/4oEdTbu8z+BMZMlPbykW+dAW8K1em0xjfFRP5PXdkUk8Bv+KoqX61HZ4I0kaSJioFE6VQ2jFZjUZnOEHRIsDIDYQ/4ngtLwH0mcbPdIR/LWjfqK8cVPl46OFn4X6TpV1dYvlEkpxPJDjSRQGThoGvL6HTGujnhfoPRWVjNTEUIPLaN9mkxbr6hm+gKcbZIiyNAqCVe2B4nGMJpZ4Fl1g0cpdqGI7GdOQSstk4xodktjMKH2gGlMX9f0n1R7dzfiOqVivug1xGkEhgfkfHoVdlim12Dr/ObMH69/XL+/20cwu7wKdPl2Ym7uE19WObDnxmgL9b4hohoo2GqELcyjZNianPBEo96FvEmHkK0t4MnvapGPU/pqVq979OvRr/W8CpeGGMIWuHzPDcXibEafxagqfHAM9z6G/643TC3Iv0PCkCqtVwbx1NfawisjjxOc1vPSfGtmOn0NIWA2wzVBzDetZcTFmIuC9j7gXtDfDZ8j5+BkDIuMSYjdatZdc8Y749JXoJrc3DKM2294gv3ya9TzF0=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjkwMzg1ODAyMjQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzViMTUwMzA1MzA5NTUzODdmZGFmYmQ5M2JiOTE3MjNhMDljODFiZTI4YzM5ZDk0NzExZTVjZGNiZmUxNyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'shazam'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'diamondmaster03',

        #uuid
        'cc2d2734e7844250886d5c6c714bfb09',
        
        #signature
        'Lg9yVIGpjBX3xBjArKU/R6Y3GJIgH2PgKDJ+kD/pIxWuCArpSuYwZ1C0aBsot69WuGd//HDhFD9BBeOX2ijSJynV3/bTCWB67pJxeCylekRgiwk9aRz2ePAWk2t30G5LtVOcnPYYMzqrvJmY0pioP+sDkdP8gNZyeA6+l9fU3KemO0Mm4BKY3gXZdXs5MtGqhjx1r+oSEZ6+q2+T5hFXsXAJJJyEjeFTQV/sYX3in2DkDbXA5reFAVE+R1UI8oKOL3mdjSBUQPxf2UJyD12uMvG9D+aV/phflmb19O13n4sMuJsp6DAHENeM1/1hsDjz9gqbgZkt1Qj0JaKYc808JgvbG2ZxEp/yCY+o/e7qoUaX1K4eHWjb9hchuT2F2mieVsdhCqOmVomkl37vX5C9KSbrXSPTwdjxJgqm+UVPL1Tp6dhMmFIQoyXT1HBQrkT30MNN2c0K0bpLeU3l+9cpCBbkEBEiMY4P3SKHVu5KkTdECz7koneOx2UHflO6CmkL7mzEs9wD3zzIq4K/lIi632wVrBDp02ZcPzTFDEy+JBlIOSwiNiBnhzot8fPgw85ur8qxe9HSPBLfrWRRtPyR9q5MWzUsIvlgToyc/xUuOkdZ6gw5FzeuD7o2qyOgq9ISbd+EMOxdZsWVqdwiFOywVJknTI8YBHsfcWYGZH0+gnI=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njg3OTIwNTg3MDksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2UwNDVhNTU5M2I3ZDcwM2E5ZmU2ZDAyZmNhMjZhNDlmYmYxMTg0ZjVhMjJkYWFiYzYyMzA1ZWNmNDlkM2ViNTgifX19'
        
        )}
    else if(@pgroup[0] == 'onslaught'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Y8TfQJSFGDuN4ulFB7qPYT1D90+3iY3b7tyShGDe2yIrv7VI+i3nna13NbBbZXEdX5NZVJrLtcLMKkUq1jjV8ijHc+E/lIeLnf19PmHJ1ZSQXKc71KY6OFRIURc5NF+z5ShDbzoDdtv9JT5wLEUNVoD6qZKXim32zicgaj1s6AyhO7LpvnYvkUZ1kQDw+mV3SI3q9becc9Fzr6GZgNot7GLUjEiy5iIYnVTE6ZPKpjW2QYx29+WAUrMwpqIC+E5ogJUsT5BKt7dWlHcTZUGbxIFzedKwBxE+XFIVjuYmlb/59PPtrvBvGhy67clBh3DtpYAHG6vxwiR2g6BLuczbObOEicIuJuKalpEhMeDxD/JG5f0hsjkU+8z8ra9vhLyyld9Atuc1Qcy/yyqxR5HKGYQAuDri3QDtf691yvJSD4aI0Cgd4xPeZihT9iirdndxcBtvwCKRZTwadUDoQDbRySvLvy5ql0BZkOLJthLqd2j8NiVdX/1xLkNWlUN1kR9CaVymTEGPn0W8Lg/kCR5OREBvOmDVgb3mb+SHEcx/1BxsFZSxOrM2N5VR2HEKRf7+vYPQfgvmW79vHse1rJ9eJkoUZ1u0VBsrZJmnxxSW8ezTbYAKdlpJnLgZk4p3n52N/ri4xYdW0duV+OazKtz3eMQjthHUoxUI75a60qDY9OI=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjgyMjA4MjQ2MDQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2UxMWRkNDczNjFmMjU5YzVkNDk5Zjk2NGM1NDVjN2E0MjhkNDE4MGNkYTA5MTQ3MmI5Mzg4MGZlYzMzYzE3In19fQ=='
        
        )}
    else if(@pgroup[0] == 'niteowl'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'Llfbzn2v2OtKF/garU9Ouod6EnMLQHamvHEv5l0YT4UFEXOB1wRddgxXFFNvpUqRhKeETPD47NRcqYwJ4QOvK3HGKOkV5n6oCY4V4m4z2lmodPh8EUvs0X+8l3CtCAHIU3rA9qdCfXNhnd9LGLCSF2NCB9Yk4RuSVqSbCXYFPn3leWtdctbLfy0X07/+mhE6ybWGELI8d4PQkBhEzCM70tH08KYLrTxp0CyS+pJ96A7Tu594VUoXcn8xjkXeObxC52RmgYkxKd8Ellvw26Ho27nxmP8FjzCJC+YB2/TgzMVYXvS3AGE43V5ISiq91w1I5Dus2fpKrt1CDxDfIfce1mhs1A58nGqbSJDJARwzwrpEn1uSZHh5yyI02M+EkHXMiVpZQ34m6DMX1Uo5WVLLbM+ElmiJFX+miEf4bfMKKHbsiOg4DCEWjhcTJyOu65pM1BmY4sch37XWxRBazuSxWK7T1EV8U7A8ptiSxsCM8JAEar3IyqXgiRqdzDNBixWdf+TFKsKx8scHcN8MUVU3WmCuJz5fmJ6Hb9/WIyQlV9lRfCIjqWmBC49krcVUQ2IetEg+Uw3ZMOKlgCiwAbGxteu7rz9nYZLXBecV4UflbbH0h5CvrBDFI79N9dmgTo00rJWZ5SwfsCl5QGFhb2Sm8HPpyRZZ+xcsB9hPijjiKJY=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njg4MDQxODQ4MTIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzU1Mzc0ZTFmNzI0ZGMxNmU1ZjJkMWIxNmZkZWJjNTY3ZDJiZjI2MTU5OWMwMzNlYjMxNWUyZDE0ODNhYjY3Y2IifX19'
        
        )}
    else if(@pgroup[0] == 'doomsday'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'aCqllc80vvswwdl2uu+z1bod3zBcXyexOKuSomPcmvJbFqFIzknnW8S7PCDdIdjgOvP1wZuEcxO5NYpbNfOCXNIkqCZzSFeTdqsTW+PRLLp2GKiRtEC7e9QqJt8zJW53L45EeThebPnEuX88wJ61Kcneh1JryP7ddpkcqr0MBFKTRoN3NOyAKHo0YdH3QiJ6bqqsaea3bPE9JjMeRdhkg618jxTyPjEJk4EgfvOqYuvHEEjoHNzi7n0Cq/cfauO7SH12nsoKucLMIFTKiaGPh5NGQjxc3xUQVtLg8gATL6OKovp4E8nC0L2g7MjU2QbGeXbvfnhKVwMDUcDGrhJDrEN1qoFWxO39lQw25xAFMzEknA7Zhc9UOpLZue6stoAFFieeggJ94raOBD6cfKnNyXdPjYxAc8ljz08QkIAgK6QCItE09+w9lhnKKXNCo8m5qC7RFeOpTZ0hn1M/Dy1Gh+RuzLP8UqHsPe03JrAxUD6qJdFKlN7jsfDsQPpgBu4oNPYJg7R6OYHwAHu2WD7r4x2HqyWnWrh/sB5Lqeo3yOGczWSAbHNDuh5q4XqVzZFDMfEbVMEpH/OAoqGso7qOTO4lGMjHIKg2Wzug1yr6MrOmmPqqjRIxYPIXGGUplDngFf5iq2NcpFXECetaK8+cEQucOaNoMyCeR9s5jfdwQVw=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njg4MDczMzQxMzgsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2I4ZjE0ZjcyNzRlZDViMTY3NmFkZDNhMDZhYzYyMzMyMDVlODEzOWI5YTRlNWZkZWM4NzNjY2U2OGQzZDU0NiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'thanos'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'WvQkfp/wV4xB3GUxakbRkTNN77rUzTRqq6bxV04zl8OSCPkkyeu7350xFRLnbeX0WhvRTy5854wklyMxec/3qKFw2aKC962CG3TB9M+xYTLjqN+dB+UfiOOXrmNgBnFeJBfNZYt6th3H3pJHAfkHOSxzmKOdM8D0ZS0MAefv0Z+5FMqCzsYXXdwi6893lZEv3O2GWXD4Syzn3FViLl0WvAEddrdF/WEnqcLbc0msFkRp+wb0CmhN9MxX/Cy/C04+HuaPg2LCLipkrbVqN5LizyWybWx8FYLXCz9MrRuZ9Gspb1ICzZP8F9qG2TZ3dc5Au55Gox7O2kj0J0ox3XzOfDXf5mBWwU33XJncZMuuRco+sEYwjK0INDAWIbkv2Sesp2ado/oNZltDQsJ8JcpLat9R+Tsf5mYmF3nF0GW4A/5wqBzwwQvH/b+bosXU9ddQepAzAYxhnoX6D1PpPGGTknS8LNW/d4suGrQmoBVs2+ydwPASheiQCCypeovZNBRC1wcImXTtgHsrzfMqHLt1ySmYPF43FYZiECyJF2UrYBJSFsuKsAnzCf2KqwJIhD6M4+Rr84AnmlkENfk+pj8qc10+rGGBWCfRoMs4sez1ml4MPp0SPcpZEygt2w4Zyd2Ooid7FFJ7d8Fqtm2FzUDkylM9VMPtWIkMcWk8VKB+ZOg=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njk4MTg0OTQ1MzksInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzVkMWE5MGE0ZTgzYWU1ZjAyNWJiNmZmN2Q4NTQxOWQ5MzU2N2M4N2M2NzVkMjgzMDg1OWJiNzQxYzBjOTMzYTkifX19'
        
        )}
    else if(@pgroup[0] == 'galactus'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'rxUFJqdFKw1Vbx/s/TQcm9tqB37Y80PtpPA8kIRS54hQ+WIwp3ZGTgDcIbXaGViUEh+bWWtmYgghuZnLzDybproRnc4LhtsnH5Ik8ka9EqLr3YGOVK7pKUcMk9lI78XJV1zGcW4pMKsQBctkyacKuMgJoo8pPfETWfxlDs7PJOh07TSazd9iJn72yg2MyfiMDYzNCm7F/eo+1zxSXP7ek80yM9VrG67YfbZVftdgaKQ/OtM5psKo0YdIsFp8/jo7CwHahcWDyXL039EMuKgPcVrZMOknS2NRKU5+6/etNZ9sZ/eygBIKbWgBdJ8ZVZSfE2fY6Zr7qpVRaaog3CePX4OFSaJR6T2b5Heo17myTzoiGtlYZSFCoLn1XPPtSwQvwREVddxgcoNORCRBzdpuI4At/qL0dcQ+rh/yAeSqOnnuKuJCRehEGQO/mx+MCAYVN1Kjg/td9cpCjM5vvB2AGytsvmSKH8QoYtMVZxNejSp61c0zOUiba/KINoYiHcliQy/eEEqsIoomh/nKxal50xC9qBpO+MSWDR5Ka8Tzow/Ftap/WbIdKdbDXr6iey05KwBptc6q+UGmN7CWpIXJYBCsrNjJGWRx9HeB8/lkWDiIZEcaLxjcBdss2jEpIxIpGJFSpNrcDAMn2EhSqhlUa7Bo9gT1t8pHDEQo+lc3v+Q=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njk4MjEyMzQyODYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzY5OTZlMmE1MmY5NjY2M2RmZTFjYjMzZTY3ZjY3Njc1NGY5YWY3OGMyNTBjMjVlZGM5NzBlNjM5NDljMyJ9fX0='
        
        )}
    else if(@pgroup[0] == 'greengoblin'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'b1IGHPwu2yNI2CL5lCagC4pz60tc8tqqIm3Z/AS+YcDf7dSXMWfklUvWR9Vl4FyvWGmgnIXZ5y+C94NwP8xn6EuPMsYbskbMBwkuLw8+1wOEmgkwYVqv5HNgvlUmb8PNhZaKsaWUbYkxqgEtENbeoB/DkDHSJxGOUe+/d66EC0XPdFTjYsKWAYnmxKL8UuYf31yL4StSILm5DmG9tXkd4ER49N2ZG9IAjnyPsFG5RyCZgmNCUQneqfkIgJzq0yGb9/0bEjRulxt/o8d0DDnGcSYvwpd/DJ9OFMp/MuD98pT9mRgoYl6XQxWaKcHpcQnAVCqCvLzN+PDDrnJaAyeHgZV9vWPTz9W+dS3c+BqUQbuX0uh+r9uB3NnKhYiD+2b/5kMIr8bRNVY6MjK8bwe+Cb991EBr39UeXsDdt4hzFotITRqKeCZuEPtxlUUA3fyvKO8BRF8n3nyp+fD73CcPiquU3lUHWqgbmUlGBAAHhR4mRg/QBqJkwrVFKnRwng4PvH/zOE+Y3/YH0zwwgvJ+2Bhj6q9k+cxsya2iT7mzsIQ9CA+V2hWhKEgqEn7d3D90HwTPgXfzGu6HUozMzP0am1ky1s2h8xD9P5b3+37RgqaqaTNx4yrnrnXWtYN8jSJ8pssGqd6fEVGjTygFLEto/s7fWucg8h5gl0z6Fp2P1XA=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0NjkxMzQ3ODU0MTEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzUxZjY4OWJmNDM0NTk4NDRlYThjNzFiZDA1NDQxZWRjM2ZlOTQ4OWQ2MWNmZDc5MGU3OWJkMzhjZmJlNzUifX19'
        
        )}
    else if(@pgroup[0] == 'wallywest'){_changeSkin(
        
        #currentPlayer
        @pname,

        #playername
        'tektronic',

        #uuid
        '87fb3c6c5ff64bf6b326992c6137ea12',
        
        #signature
        'VAdJJWGxmnXCqfLMszZa8l5fSKwhAjb5MUoBdCS7cgMKPaPYQjk7M0liP44o7XbZD0bKITW3zxuzywjDdhhKI3RNmcoKdDjsv20EnJaYQI3eWm51UJNuVns6SAIDxDNW4pSYnnr8rOABRw7whgcEHZMAFp7WGMhp5tdF8dRk9N7Kc4UsFixUzFfezGBs+ia+dJ2UoH3cfqaZxD/u7sJHZIYDT8Ksuz0v+r/4MhsdEutH6AOJuxcQhn9QF3TmXGZ+56BNZCqLfuNGJu0xjhjcuphZj+j68S6tmKQ52oWBS6g5pe3i3D0E9Rd6LmNBmQio8EVJ7SU1v5It0emOn7Mlbe/4JkuJYI5TQAacetSBnJbTnVr+N7dJrwDle9GhgquZ58w/f6/j4x6daMlIZR6MvhkuN8AAdUylIdeAOHy+u10H7BTqGSe2i0/gdtg6T0Hgl7DOJFTiSthhfavB84I0/b85b48YMWmXcR9jO3/Um++L/9vOOnPq4vLCdOQilLlzSIqhjmq5fHWlFJi8lVWBTkQV7ilHE9mwNTQeq6wXAwpCaGIvl2qIdz9h968mLot8yxvFEWseolFs1sEb/tkz/8KkRBkCEJtL9k86RAcEnS6xENDx21LiUW4+wV0SuugGOTXguamQ5Ne67eeWfVJ81/N3Kb+z8AkiLF8JGfydwLQ=',
        
        #value
        'eyJ0aW1lc3RhbXAiOjE0Njk5OTQwMjM4MzQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2YzYjk4MTZiZGU1MmRkYjNmOWQ5NzgxYTMyYzg3MzNmZDMzMmQ0YTZhN2FlYjU4YjA3ODE2MjNkNzY0NWVkZiJ9fX0='
        
        )}
    else if(@pgroup[0] == 'jailed'){
        runas(~console,"/minecraft:clear" @pname)
    }
))}
