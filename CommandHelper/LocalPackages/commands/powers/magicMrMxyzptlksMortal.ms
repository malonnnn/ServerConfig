register_command(magicmrmxyzptlksmortal, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.magicmrmxyzptlksmortal',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        tabcompleter: closure(@alias, @sender, @args) {
            try{
                if(array_size(@args) == 0) {
                    return(all_players());
                }
                @search = @args[array_size(@args) - 1];
                    return(array_filter(all_players(), closure(@index, @player) {
                    return(equals_ic(@search, substr(@player, 0, length(@search))));
                }));
            } catch (RangeException @ErrorInfo) {
                # Ignore
            }
        },
    
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 1) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /magicmrmxyzptlksmortal <player>');
                die(); # No need to go further					
            
            }
            @plr = player()
            @player = @args[0]
            @player = player(@player)
            if(ponline(@player)){
                if(has_permission(@player,'is.criminal')){
                    msg(color(RED).'Sorry, that player is a criminal right now, you please try again later.')
                    die()
                }

                if(!has_permission(@player,'is.incity') && !has_permission(@player,'in.survival')){
                    msg(color(RED).'You cannot mortal that player, they are busy in a minigame or some other protected area')
                    die()
                }
                if(!has_permission(@player,'is.op')){
                    msg(color(RED).'You cannot mortal that player, they are way better than you,')
                    die()
                }
                // @bal = acc_balance(@plr)
                // if(@bal < 1000 && !has_permission(@plr,'is.op')){
                //     msg(color(RED).'Sorry, you need $1000 to use this command')
                //     die()
                // }
                // acc_subtract(@plr,1000)
                include('/home/minecraft/server/plugins/CommandHelper/includes/mortal.ms')
                _mortal(@player)
                set_timeout(3000,closure(
                    tmsg(@player, 'Mr. Mxyzptlk has stripped you of your powers!');
                ))
            }
            
        }
    )
)
