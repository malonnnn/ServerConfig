bind(player_join,null,null,@event){

    @plr = player()
    @plrs = all_players()
    @pgroup = pgroup()
    @class = @pgroup[0]
    
    # -------------------------------
    # Turn joining player into mortal if the hero they logged out as is taken
    # -------------------------------
    foreach(@player in @plrs)
    {
        @otherPlayerGroup = pgroup(@player)
        if(@otherPlayerGroup[0] == @class && @plr != @player && @class != 'mortal'){
            include('/home/minecraft/server/plugins/CommandHelper/includes/friendlyHeroName.ms')
            runas(~console,/pex user player() group set mortal)
            runas(~console,/pex reload)
            runas(~console,"/sudo ". @plr ." c:/mortal")
            set_timeout(1500, closure(
                broadcast
                (
                    concat(color(white),@plr)
                    concat(color(gray),"has been turned back into a MORTAL because")
                    concat(color(white),@player)
                    concat(color(gray),"was already" _friendlyHeroName(@class))
                )
            ))
            die()
        }
    }

    include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
    include('/home/minecraft/server/plugins/CommandHelper/includes/changeTrail.ms')
    set_timeout(5000, closure(
        _changeSkin(@plr,@class)
        _changeTrail(@plr, @class)
    ))
}