# Take money per second if the player is an "OP" hero
set_interval(5000, closure(){
    @plrs = all_players()
    include('includes/isplayermod.ms')
    include('includes/isopclass.ms')
    
    foreach(@plr in @plrs)
    {
        if(_isPlayerMod(@plr) == "true"){
            continue()
        }
        
        @class = pgroup(@plr)[0]
        if(_isOpClass(@class) == "true")
        {
            if(acc_balance(@plr) >= 5){
                acc_subtract(@plr,5)
            }else{
                runas(~console,/pex user @plr group set mortal)
                runas(~console,/pex reload)
                runas(~console,"/sudo ". @plr ." c:/mortal")
                set_timeout(1500, closure(
                    tmsg(@plr, concat(color(dark_red),"You ran out of money! You have been re-set to a mortal!"))
                ))
            }
        }
    }
});


# Harley Quinn immunity to poison
bind(entity_damage, null, array('cause': 'POISON'), @e) {
    
    @plr = player()
    @class = pgroup(@plr)[0]

    if(@class == "harleyquinn")
    {
        set_peffect(@plr, 19, 1, 0)
        cancel()
    }
}

#bind(item_pickup, null, array('player': 'Tektronic'), @e) {
#    
#    @itemMeta = @e['item']
#    tmsg(player(),@itemMeta)
#    @itemMetaArray = json_decode(@itemMeta)
#    tmsg(player(),@itemMetaArray)
#    @itemName = itemMetaArray[1]
#    
#    tmsg(player(),@itemName)
#}

# Fang can be invisible unless he's moving
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

# Clear Jailed Player Inventor on Item Pickup
bind(item_pickup,null,null,@event){
    
    @pname = player()
    @pgroup = pgroup()
   
   if(@pgroup[0] == 'jailed'){
        cancel()
    }
}

# Nightwing throws lightning with sticks
bind(player_interact,null,array('item': 280,'button': 'LEFT'),@event){

    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(@pgroup[0] != 'nightwing')
    {
        die()
    }
    
    if(
        @pworld != '1_9' && 
        @pworld != 'greenfield' && 
        @pworld != 'destructiblecity'
    ){
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

# Multiple Heroes Punch Empty Hand Fireball
bind(player_interact,null,array('button': 'LEFT'),@event){

    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
        
    if(
        @pgroup[0] != 'starfire' && 
        @pgroup[0] != 'hades' && 
        @pgroup[0] != 'thehumantorch'
    ){
        die()
    }
    
    if(
        @pworld != '1_9' && 
        @pworld != 'greenfield' && 
        @pworld != 'destructiblecity'){
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

# Multiple Heroes Point Empty Hand Lightning
bind(player_interact,null,array('button': 'LEFT'),@event){
    
    @pname = player()
    @pgroup = pgroup()
    @pworld = pworld()
    @puuid = puuid()
    
    if(
        @pgroup[0] != "zeus" && 
        @pgroup[0] != "shazam" &&
        @pgroup[0] != "blackadam"
    ){
        die()
    }
    
    if(
        @pworld != "1_9" &&
        @pworld != "greenfield" && 
        @pworld != 'destructiblecity'
    ){
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

# Multiple Heroes Punch Lightning with Bare Hands
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
        
            if(
                @pgroup[0] != 'shazam' &&
                @pgroup[0] != 'blackadam' &&
                @pgroup[0] != 'darthmaul' && 
                @pgroup[0] != 'darthvader' &&
                @pgroup[0] != 'darthsidious'
            ){
                die()
            }
            
            if(
                @pworld != '1_9' && 
                @pworld != 'greenfield' &&
                @pworld != 'destructiblecity'
            ){
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

# Player Chat 
bind('player_chat', null, null, @e) {
    
    @pgroup = pgroup()
    
    if(@pgroup[0] == 'jailed'){
        die()
    }
    
    @pname = player()
    @pworld = pworld()
    @puuid = puuid()
    
    assign(@msg, @e[message])
    
    # if message is 565, display a link to a picture of the "superhero warehouse"
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
    
    # If Mxypztlk speaks his own name backwards he is sent to the nether and de-powered
    if(string_position(to_lower(@msg), 'kltpzyxm') != -1){
        if(@pgroup[0] == 'mrmxyzptlk'){
            set_timeout(1000, closure(
                runas(~console,"/sudo ". @pname ." c:/mortal")
                sudo(/warp onslaughtmental @pname)
                set_timeout(1500, closure(
                    tmsg(@pname, 'You said your name backwards! Off to the other dimension you go!')
                ))
            ))
        }
    }
    
    # replace all messages by black bold with "..." because he is unable to speak
    if(@pgroup[0] == 'blackbolt'){
        assign(@msg,"...")
        modify_event(message, @msg)
    }
    
    # If a player is a mod, stop the script at this point because the mods are not bound by chat timeout
    include('includes/isplayermod.ms')
    if(_isPlayerMod(@pname) == "true"){
        die()
    }
    
    # chat timeout settings (hark has a 5 minute chat timeout)
    if(@pname == 'HeyItzHark'){
        @cooldown = 3
    }else{
        @cooldown = 3
    }
    
    if(is_null(get_value(@pname.'lastmessage'))){
        store_value(@pname.'lastmessage',0)
    }
    
    @lastmessage = get_value(@pname.'lastmessage')
    @time = time()
    if(@lastmessage + @cooldown > @time / 1000){
        @timeleft = subtract(add(@lastmessage, @cooldown), divide(@time,1000)) + 1
        tmsg(@pname,"You can speak again in" round(@timeleft) "seconds")
        cancel()
        die()
    }
    store_value(@pname.'lastmessage', time() / 1000)
    
    
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
        #modify_event(message, @msg)
}

# If PlayerA is superman and PlayerB was Superman on log out and is just logging back in, then
# set PlayerB as a mortal as no two people can be the same hero at the same time
bind(player_join,null,null,@event){

    @plr = player()
    @plrs = all_players()
    @pgroup = pgroup()
    @class = @pgroup[0]
    
    foreach(@player in @plrs)
    {
        @otherPlayerGroup = pgroup(@player)
        if(@otherPlayerGroup[0] == @class && @plr != @player && @class != 'mortal'){
            include('includes/friendlyheroname.ms')
            runas(~console,/pex user player() group set mortal)
            runas(~console,/pex reload)
            runas(~console,"/sudo ". @plr ." c:/mortal")
            set_timeout(1500, closure(
            broadcast(
                concat(color(white),@plr)
                concat(color(gray),"has been turned back into a MORTAL because")
                concat(color(white),@player)
                concat(color(gray),"was already" _friendlyHeroName(@class))
            )
            ))
            die()
        }
    }

    include('includes/changeskin.ms')
    include('includes/changetrail.ms')
    set_timeout(5000, closure(
        _changeSkin(@plr,@class)
        _changeTrail(@plr, @class)
    ))
}

bind(player_toggle_sneak,null,null,@event){
    @player = player()
    @class = pgroup()[0]
    
    if(
        #@class == 'spiderman' || 
        #@class == 'blackspiderman' || 
        #@class == 'carnage' || 
        #@class == 'venom' 
        @class == 'cosmicarmorsuperman' 
    ){
        @eventID = associative_array('id': @player.'climbwalls')
        @isSneaking = @event['sneaking']
        
        if(@isSneaking){
        
            @ploc = ploc()
            @block = "106"
            include('includes/spidermanvineplacement.ms')
            _spidermanVinePlacement(@ploc,@block)
        
            @realID = bind(player_move, @eventID, associative_array('player': @player), @event,
            @player, @eventID, @isSneaking){
                
                @ploc = ploc()
                @ploc['y'] = @ploc['y'] + 2
                if(get_block_at(@ploc) == "0:0"){
                    if(@ploc['yaw'] >= 135.0 && @ploc['yaw'] <= 225.0){
                        set_block_at(@ploc,"106:4")
                    }else if(@ploc['yaw'] >= 225.0 && @ploc['yaw'] <= 315.0){
                        set_block_at(@ploc,"106:8")
                    }else if((@ploc['yaw'] >= 315.0 && @ploc['yaw'] <= 360.0) || 
                    (@ploc['yaw'] >= 0.0 && @ploc['yaw'] <= 45.0)){
                        set_block_at(@ploc,"106:1")
                    }else{
                        set_block_at(@ploc,"106:2")
                    }
                }
                @ploc['y'] = @ploc['y'] + 1
                if(get_block_at(@ploc) == "0:0"){
                    if(@ploc['yaw'] >= 135.0 && @ploc['yaw'] <= 225.0){
                        set_block_at(@ploc,"106:4")
                    }else if(@ploc['yaw'] >= 225.0 && @ploc['yaw'] <= 315.0){
                        set_block_at(@ploc,"106:8")
                    }else if((@ploc['yaw'] >= 315.0 && @ploc['yaw'] <= 360.0) || 
                    (@ploc['yaw'] >= 0.0 && @ploc['yaw'] <= 45.0)){
                        set_block_at(@ploc,"106:1")
                    }else{
                        set_block_at(@ploc,"106:2")
                    }
                }
                
                set_timeout(1500, closure(
                    set_block_at(@ploc,"0:0")
                    @ploc['y'] = @ploc['y'] - 1
                    set_block_at(@ploc,"0:0")
                ));
            }
            export(@eventID['id'],@realID)
        }else{
            unbind(import(@eventID['id']))
        }
    
    }
}