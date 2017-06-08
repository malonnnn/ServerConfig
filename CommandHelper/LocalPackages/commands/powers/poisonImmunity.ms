register_command('poisonimmunity', 

    array(
        description: 'Makes you invincible to poison!',
        usage: '/poisonimmunity',
        permission: 'powers.immunity.poison',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 0) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /poisonimmunity');
                die(); # No need to go further					
            }
            @plr = player()
            @puuid = puuid(@plr)
            bind(entity_damage, array(id: @plr.'poisonImmune'), array('id': @puuid, 'cause': 'POISON'), @e, @player = @plr) {
                set_peffect(@player, 19, 1, 0)
                cancel()
            }
        }
    )
)
