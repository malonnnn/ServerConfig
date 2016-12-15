human:/human $player = >>>
    @player = $player
    if(ponline(@player)){
        @pgroup = pgroup(@player)
        @class = @pgroup[0]
        if(
            @class == 'cosmicarmorsuperman' ||
            @class == 'onepunchman'||
            @class == 'christianicgod'||
            @class == 'infinitythanos'
        ){}else
        {
            runas(~console,"/sudo ". @player ." c:/mortal")
            tmsg(@player, 'You feel your powers drain, soon realizing you have none more.')
        }
    }
<<<
