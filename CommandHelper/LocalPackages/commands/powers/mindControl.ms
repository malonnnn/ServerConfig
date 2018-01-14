register_command(mindcontrol, 

    array(
        description: 'Mind Controls a person',
        permission: 'ch.alias.mindcontrol',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {

            if (array_size(@args) != 1) {
                return(FALSE)
            }
            
            @player = player()
    
            @vic = @args[0]
            if(@vic == '@t'){
                die()
            }
            @vic = player(@vic)

            export(@player.'mindControlVictim',@vic)

            if(@player == @vic){
                msg(color(RED).'You are already mindcontrolling yourself!')
                die()
            }

            if(has_permission(@vic,"is.telepathicallyresistant")){
                tmsg(@player,color(red)."Sorry, that player is telepathically resistant.")
                die()
            }

            if(has_permission(@vic,"is.criminal")){
                tmsg(@player,color(red)."Sorry, that player cannot be controlled.")
                die()
            }

            if(import(@vic.'beingMindControlled') == true){
                msg(color(RED).'Sorry, that person is already being mind controlled')
                die()
            }
            if(import(@vic.'mindControlling') == true){
                msg(color(RED).'Sorry, that person is already mind controlling someone')
                die()
            }

            if(!has_permission(@vic,'is.mindControllable')){
                msg(color(RED).'Sorry, that person is in a minigame or other protected area')
                die()
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
            @ploc = ploc(@player)
            @vloc = ploc(@vic)
            if(has_permission(@player,'powers.mindcontrolnear')){
                @plrClass = _getHeroClass(@plr)
                @radius = 0
                if(@plrClass == 'wonderwoman'){
                    @radius = 20
                }else if(@plrClass == 'jericho'){
                    @radius = 20
                }else if(@plrClass == 'infinitythanos'){
                    @radius = 5
                }
                if(@ploc['world'] == @vloc['world']){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/distanceBetween.ms')
                    @dist = _distanceBetween(@ploc,@vloc)
                    if(@dist > @radius){
                        tmsg(@player,color(RED).'Sorry, you are not close enough to that person. Please get within '.@radius.' blocks.')
                        die()
                    }
                }
            }


            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedMindControl',60,@plr)
            
            broadcast("@player is now mindcontrolling @vic")

            export(@player.'mindControlling',true)
            export(@vic.'beingMindControlled',true)
            
            export(@player.'mindControlPlayerOrigLocation',@ploc)
            export(@player.'mindControlVicOrigGameMode',pmode(@vic))
            
            set_ploc(@player,@vloc)

            set_pmode(@vic,'SPECTATOR')

            export(@player.'mindControlPlayerOrigHero',_getheroclass(@player))
            @vHero = _getheroclass(@vic)
            
            try{
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @vHero . '.ms')
                include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
                _changeSkinMindControl(@player,@hero['sig'],@hero['val'],@vic)
            }catch(Exception @e){
                runas(~console,'/disguiseplayer '.@player.' player '.@vic)
            }
            @markerPloc = import(@player.'mindControlPlayerOrigLocation')
            @markerPloc['y'] += 1
            @marker = spawn_entity('ZOMBIE',1,@markerPloc)[0]

            set_mob_name(@marker,@player)
            console(@marker)
            export(@player.'mindControlEntityID',@marker)

            bind(entity_damage,array('id':@player.'mindControlEntityDamaged'),array('id':@marker),@e,@idd = puuid(@player),@playerr = @player){
                cancel()
                if(array_index_exists(@e,'damager')){
                    damage_entity(@idd,(@e['amount']*10))
                }else{
                    die()
                }
                tmsg(@playerr,'Your body is being damaged!')
            }

            bind(player_death,array('id':@player.'mindControlDeath'),array('player':@player),@e,@playerr = @player){
                include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
                _mindControlStop(@playerr)
            }
            bind(player_command,array('id':@vic.'mindControlCommandCancel'),array('player':@vic),@e,@vicc = @vic){
                cancel()
                tmsg(@vicc,color(RED).'You are being mind controlled, you can\'t use any commands right now!')
            }

            @mindControlTimer = set_timeout(30000,closure(
                include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
                _mindControlStop(@player)
            ))

            export(@player.'mindControlTimer',@mindControlTimer)
            
            bind(player_chat,associative_array('id': @player.'mindControlChatForward'),associative_array('player': @player),@event, @playerr = @player, @vicc = @vic){
                cancel()
                console('chat forwarded from '.@playerr. ' to '.@vicc)
                chatas(@vicc,@event['message'])
                @players = all_players()
                foreach (@plor in @players){
                    if (has_permission(@plor, 'is.officer')){
                        tmsg(@plor, color(GRAY).color(ITALIC).'*MindController*: '.@playerr)
                    }
                }
            }
            bind(player_quit, associative_array('id': @player.'mindControlVicLeave'), associative_array('player': @vic), @event, @playerr = @player, @vicc = @vic){
                runas(~console,'/tempban '.@vicc.' 60s 1 Minute Ban For Quitting During Mind Control')
                runas(~console,'/pex user '.@vicc.' group set mortal')
                include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
                _mindControlStop(@playerr)
            }

            bind(player_quit,associative_array('id': @player.'mindControlPlrLeave'),associative_array('player': @player),@event, @playerr = @player){
                include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
                _mindControlStop(@playerr)
            }
        }
    )
)

register_command(stopmindcontrol, 

    array(
        description: 'Stops mind control',
        permission: 'ch.alias.stopmindcontrol',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {        
            
            @player = @sender
            assign(@cooldown, 30)
            
            assign(@lastUsedStopMindControl, import(@player."lastUsedStopMindControl"))
            if(@lastUsedStopMindControl + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedStopMindControl, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can stop mind control again!'))
                die()
            )
            export(@player."lastUsedStopMindControl", time() / 1000)

            if(import(@player.'mindControlling') != true){
                msg(color(RED).'Sorry, you are not currently mind controlling anyone')
                die()
            }

            include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
            _mindControlStop(@player)
            
            
        }
    )
)
