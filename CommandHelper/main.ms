set_interval(50, closure(){
    @plrs = all_players()
    
    foreach(@plr in @plrs)
    {
        @class = pgroup(@plr)
        
        if(@class[0] == "harleyquinn")
        {
            set_peffect(@plr, 19, 1, 0)
        }
    }
});

set_interval(5000, closure(){
    @plrs = all_players()
    include('includes/isplayermod.ms')
    include('includes/isplayeropclass.ms')
    
    foreach(@plr in @plrs)
    {
        if(_isPlayerMod(@plr) == "true"){
            continue()
        }
        
        if(_isPlayerOpClass(@plr) == "true")
        {
            if(acc_balance(@plr) >= 5){
                acc_subtract(@plr,5)
            }else{
                runas(~console,"/sudo ". @plr ." c:/outofmoney")
            }
        }
    }
});

set_interval(1000, closure(){
    @plrs = all_players()
    
    foreach(@plr in @plrs)
    {
        @pgroup = pgroup(@plr)
        if(@pgroup[0] == 'fang')
        {
        
            @loc1 = ploc(@plr);
        
            set_timeout(250, closure(
                @loc2 = ploc(@plr);
                if(@loc1[0] != @loc2[0] || @loc1[1] != @loc2[1] || @loc1[2] != @loc2[2]) {
                    foreach(@effect in get_peffect(@plr)){
                        if(@effect['id'] == 14){
                            runas(~console,"/sudo ". @plr ." c:/vis")
                        }
                    }
                }
            ))
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
bind(entity_death, null, array('type': 'SKELETON'), @e)
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
    
    if(@pworld != '1_9' && @pworld != 'greenfield' && @pworld != 'destructiblecity'){
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
        
    if(@pgroup[0] != 'starfire' && @pgroup[0] != 'hades' && @pgroup[0] != 'thehumantorch'){
        die()
    }
    
    if(pworld() != '1_9' && pworld() != 'greenfield' && @pworld != 'destructiblecity'){
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
    
    if(@pworld != "1_9" && @pworld != "greenfield" && @pworld != 'destructiblecity')
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
            
            if(@pworld != '1_9' && @pworld != 'greenfield' && @pworld != 'destructiblecity'){
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

bind(player_login, null, null, @e) {
    set_timeout(3000, closure(
        broadcast(
            concat(color(dark_red), 'REMINDER:')
            concat(color(green), 'This server is now')
            concat(color(gold), 'an RP server!')
        )
    ))
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
    #@p ='Tektronic';
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
            #tmsg(@pname, "§4§kk§6http://i.imgur.com/0od9K1R.png")
            ))
        ))
        cancel()
        broadcast("§4§kk§9".@pname §7said the secret password for superheroes!)
    }
    
    if(string_position(to_lower(@msg), 'kltpzyxm') != -1){
        if(@pgroup[0] == 'mrmxyzptlk'){
            set_timeout(1000, closure(
                tmsg(@pname, 'You said your name backwards! Off to the other dimension you go!')
                runas(~console,"/sudo ". @pname ." c:/mortal")
                sudo(/warp onslaughtmental @pname)
            ))
        }
    }
    
    if(@pgroup[0] == 'blackbolt'){
        assign(@msg,"...")
        modify_event(message, @msg)
    }
    
    if(equals_ic(@pname, 'Tektronic')){
        die();
    }
    
#    assign(@msg, reg_replace('(?i)(0|O)+[. ]*3+[. ,-_]*(0|O)+', '040', @msg))
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
#    assign(@msg, reg_replace('(?i)\\bcx', 'cocks', @msg))
#    modify_event(message, @msg)
}

bind(player_join,null,null,@event){

    @plr = player()
    @plrs = all_players()
    @pgroup = pgroup()
    @class = @pgroup[0]
    
    foreach(@player in @plrs)
    {
        @otherPlayerGroup = pgroup(@player)
        if(@otherPlayerGroup[0] == @class && @plr != @player && @class != 'mortal'){
            broadcast(
                concat(color(white),@plr)
                concat(color(gray),"has been turned back into a MORTAL because")
                concat(color(white),@player)
                concat(color(gray),"was already that class!")
            )
            runas(~console,"/sudo ". @plr ." c:/mortal")
            die()
        }
    }

    include('includes/changeskin.ms')

    set_timeout(5000, closure(
        _changeSkin(@plr,@class)
    ))
}