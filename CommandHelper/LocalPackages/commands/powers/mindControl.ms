register_command(mindcontrol, 

    array(
        description: 'Mind Controls a person',
        permission: 'ch.alias.mindcontrol',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /mindcontrol <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
    
            @vic = @args[0]
            @vic = player(@vic)

            export(@player.'mindControlVictim',@vic)

            if(@player == @vic){
                msg(color(RED).'You are already mindcontrolling yourself!')
                die()
            }

            if(has_permission(@vic,"is.awesome")){
                tmsg(@player,color(red)."Sorry, that player cannot be mind controlled.")
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

            assign(@cooldown, 60)
            assign(@lastUsedMindControl, import(@player."lastUsedMindControl"))
            if(@lastUsedMindControl + @cooldown > time() / 1000,
                assign(@timeleft, subtract(add(@lastUsedMindControl, @cooldown), divide(time(),1000)))
                tmsg(@player,concat('§c[§4', Error, '§c] §7You must wait another §6', round(@timeleft), ' §7seconds before you can use mind control again!'))
                die()
            )
            export(@player."lastUsedMindControl", time() / 1000)
            
            
            broadcast("@player is now mindcontrolling @vic")

            export(@player.'mindControlling',true)
            export(@vic.'beingMindControlled',true)
            
            export(@player.'mindControlPlayerOrigLocation',ploc(@player))
            export(@player.'mindControlVicOrigGameMode',pmode(@vic))
            
            set_ploc(@player,ploc(@vic))

            set_pmode(@vic,'SPECTATOR')

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
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
            console(@player.'mindControlEntityID',@marker)
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


register_command(mindcontrolnear, 

    array(
        description: 'Mind Controls a person',
        permission: 'powers.mindcontrolnear',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /mindcontrolnear <player>');
                die(); # No need to go further					
            
            }
            
            @player = player()
    
            @vic = @args[0]
            @vic = player(@vic)

            if(pworld(@vic) != pworld(@player)){
                @ploc = ploc(@player)
                @vicLoc = ploc(@vic)
                @x1 = @ploc['x']
                @y1 = @ploc['y']
                @z1 = @ploc['z']

                @x2 = @vicLoc['x']
                @y2 = @vicLoc['y']
                @z2 = @vicLoc['z']

                @x3 = pow(@x1 - @x2, 2)
                @y3 = pow(@y1 - @y2, 2)
                @z3 = pow(@z1 - @z2, 2)

                @final = @x3 + @y3 + @z3

                @final = sqrt(@final)
                if(@final > 20){
                    tmsg(@player,color(red)."Sorry, that player is not close enough")
                    die()
                }
            }

            if(@player == @vic){
                msg(color(RED).'You are already mindcontrolling yourself!')
                die()
            }

            if(has_permission(@vic,"is.awesome")){
                tmsg(@player,color(red)."Sorry, that player cannot be mind controlled.")
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

            if(import(@player.'mindControlling') && import(@player.'mindControlVictim') == @vic){
                msg(color(RED).'Sorry, you have to choose a different person')
                die()
            }

            if(!import(@player.'mindControlling')){
                include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
                _coolDown('mindControlNear',60,@player)
            }else{
                include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
                _mindControlStop(@player)
            }

            export(@player.'mindControlVictim',@vic)
            
            broadcast("@player is now mindcontrolling @vic")

            export(@player.'mindControlling',true)
            export(@vic.'beingMindControlled',true)
            
            export(@player.'mindControlPlayerOrigLocation',ploc(@player))
            export(@player.'mindControlVicOrigGameMode',pmode(@vic))
            
            set_ploc(@player,ploc(@vic))

            set_pmode(@vic,'SPECTATOR')

            include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
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
            console(@player.'mindControlEntityID',@marker)
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
