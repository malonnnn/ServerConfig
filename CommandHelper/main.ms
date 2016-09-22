# Harley Quinn immunity to poison
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

# Take money per second if the player is an "OP" hero
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

# Shot skeletons give money in certain worlds
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

# Shot Enderman in Anarchy give money in certain worlds
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

# Shot Creepers in Anarchy give money in certain worlds
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

# RP Server Reminder
bind(player_login, null, null, @e) {
    set_timeout(3000, closure(
        broadcast(
            concat(color(dark_red), 'REMINDER:')
            concat(color(green), 'This server is now')
            concat(color(gold), 'an RP server!')
        )
    ))
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