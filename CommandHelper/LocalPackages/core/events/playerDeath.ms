bind(player_death, null, null, @event){

    if(@event['cause']['cause'] == 'VOID'){
        die()
    }

    @player = player()
    @world = pworld()
   
    #runas(~console,'/minecraft:clear '.@player) 
    if(@world == 'deathrun'){
        runas(~console,'/timer &4DeathRun split '.@player.' global')
    }

    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
    @class = _getheroclass(@player)
    @message = @event['death_message']
    try{
        @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
        @hero = yml_decode(@contents)
        @message = replace(@message,@player,@hero['name'].color(DARK_RED).color(ITALIC))
        if(@event['killer'] != null){
            @class = _getheroclass(@event['killer'])
            try{
                @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
                @hero = yml_decode(@contents)
                @message = replace(@message,@event['killer'],@hero['name'].color(DARK_RED).color(ITALIC))
            }catch(Exception @e){
            }
        }
        modify_event('death_message',@message)
    }catch(Exception @e){
    }
    if(has_permission(@player,'powers.cantdie')){
        set_phealth(@player,1)
        modify_event('death_message',null)
    }

}
