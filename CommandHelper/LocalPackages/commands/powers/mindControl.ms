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
            
            @player = @sender
    
            @vic = @args[0]
            @vic = player(@vic)

            export(@player.'mindControlVictim',@vic)

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

            @mindControlTimer = set_timeout(30000,closure(
                include('/home/minecraft/server/plugins/CommandHelper/includes/mindControlStop.ms')
                _mindControlStop(@player)
            ))

            export(@player.'mindControlTimer',@mindControlTimer)
            
            bind(player_chat,associative_array('id': @player.'mindControlChatForward'),associative_array('player': @player),@event, @playerr = @player, @vicc = @vic){
                cancel()
                console('chat forwarded from '.@playerr. ' to '.@vicc)
                chatas(@vicc,@event['message'])
                foreach (@player in @players){
                    if (has_permission(@player, 'is.officer')){
                        tmsg(@player, color(GRAY).color(ITALIC).'*Player MindControlled*: '.@plrSpeaking)
                    }
                }
                try{
                    unbind(@vicc.'mindControlForward')
                }catch(Exception @e){
                    
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

            
            
        }
    )
)
