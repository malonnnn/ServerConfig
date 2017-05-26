register_command('imasinglelady', 

    array(
        description: 'Tell the server you are a single waifu!',
        usage: '/imasinglelady',
        permission: 'waifu.single',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
            if (array_size(@args) != 0) {
            
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /iamasinglelady');
                die(); # No need to go further					
            }
            @plr = player()
            @puuid = puuid(@plr,true)
            @spouse = import(@puuid.'spouseUUID')

            if(@spouse != null && @spouse != ''){
                msg('Sorry, you are already taken!')
                die()
            }

            export(@puuid.'gender','g')
            broadcast(@plr.color(RED).' is letting everyone know she\'s a single and ready to ____!'.color(WHITE).' /claimwaifu '.@plr)
        
        }
    )
)

register_command('claimwaifu', 

    array(
        description: 'Marry a waifu!',
        usage: '/claimwaifu <player>',
        permission: 'waifu.claim',
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
                msg(''.color(RED).'Usage: /claimwaifu <player>');
                die(); # No need to go further					
            }
                
            @plrName = player()
            @waifuName = @args[0]

            try{
                @waifuName = player(@waifuName)
            }catch(PlayerOfflineException @e){
                msg(color(RED).'Are you sure that player is online?')
                die()
            }

            @plrUUID = puuid(@plrName,true)
            @waifuUUID = puuid(@waifuName,true)
            @husbandoUUID = import(@waifuUUID.'spouseUUID')
            @husbandoName = import(@waifuUUID.'spouseName')
            @waifuGender = import(@waifuUUID.'gender')
            @plrGender = import(@plrUUID.'gender')

            if(@husbandoUUID != null && @husbandoUUID != ''){
                msg(color(RED).'Sorry, '.color(WHITE).@waifuName.color(RED).'is already claimed by '.color(WHITE).@husbandoName.color(RED).' Please do '.color(WHITE).'/waifuchallenge '.@husbandoName.color(RED).'to challenge '.color(WHITE).@husbandoName.color(RED).' for the ownership of '.color(WHITE).@waifuName.color(RED).'!')
                die()
            }

            if(@waifuGender != 'g'){
                msg(color(RED).'Sorry, that player is not a girl D: They must first do '.color(WHITE).'/iamasinglelady '.color(RED).'before they can be taken!')
                die()
            }

            if(@plrGender == 'g'){
                msg(color(RED).'Sorry, you are registered as a girl!')
                die()
            }
            if(import(@plrUUID.@waifuUUID.'isMarried')){
                msg(color(RED).'Sorry, you already are married to her!')
                die()
            }
            export(@plrUUID.@waifuUUID.'isMarried',true)
            export(@waifuUUID.'spouseUUID',@plrUUID)
            export(@waifuUUID.'spouseName',@plrName)
            broadcast(@plrName.color(RED).' has just claimed '.color(WHITE).@waifuName.color(RED).' as his waifu!')
        
        }
    )
)

register_command('waifuchallenge', 

    array(
    
        description: 'Challenges another player for ownership of their waifu!',
        usage: '/waifuchallenge <husbandoName> [waifuName]',
        permission: 'waifu.challenge',
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
            @arraySize = array_size(@args)
            if (@arraySize > 2 || @arraySize == 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /waifuchallenge [[husbandoName] [waifuName]]');
                die(); # No need to go further					
            }

            if(@arraySize == 2){
                @waifuName = @args[1]
            }else{
                @waifuName = player()
                @waifuUUID = puuid(@waifuName,true)
                @husbandoUUID = import(@waifuUUID.'spouseUUID')
                @husbandoName = ''

                @plrs = all_players()
                foreach(@plr in @plrs){
                    if(@husbandoUUID == puuid(@plr,true)){
                        @husbandoName = @plr
                        break()
                    }
                }
                if(@husbandoName == ''){
                    msg(color(RED).'Your husbando must be online!')
                    die()
                }
                if(pworld(@waifuName) != pworld(@husbandoName)){
                    msg(color(RED).'Sorry, you must be in the same world as the husbando to do that!')
                    die()
                }

                if(import(@waifuUUID.'gender') != 'g'){
                    msg('Sorry, you must be a girl to use this command!')
                    die()
                }

                if(import(@husbandoUUID.'gender') == 'g'){
                    msg('Sorry, your husbando must be a boy to use this command!')
                    die()
                }

                @time = import(@waifuUUID.'lastChallengeTime')
                if(@time != null && (time() - @time) < 86400000){
                    msg(color(RED).'Sorry, it hasn\'t been 24 hours since you last tried to escape!')
                    die()
                }

                if(import(@waifuName.'inActiveChallenge')){
                    msg(color(RED).'You are already in a waifu challenge!')
                    die()
                }
                if(import(@husbandoName.'inActiveChallenge')){
                    msg(color(RED).'They are already in a waifu challenge!')
                    die()
                }

                export(@waifuName.'inActiveChallenge',true)
                export(@husbandoName.'inActiveChallenge',true)

                runas(~console,'/warp husbando1 '.@husbandoName)
                runas(~console,'/warp husbando2 '.@plrName)

                bind(player_death,array(id: @husbandoName.'waifuChallengeDeath'),associative_array('player':@husbandoName),@e,@winner = @waifuName, @loser = @husbandoName, @waifu = @waifuName){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                    unbind()
                    unbind(@loser.'waifuChallengeDeath')
                    unbind(@winner.'waifuChallengeWorldChanged')
                    unbind(@loser.'waifuChallengeWorldChanged')
                    unbind(@winner.'waifuChallengeDisconnect')
                    unbind(@loser.'waifuChallengeDisconnect')
                    _waifuWinner(@winner,@loser, @waifu, itrue, true)
                }
                bind(player_death,array(id: @waifuName.'waifuChallengeDeath'),associative_array('player':@waifuName),@e,@loser = @waifuName, @winner = @husbandoName, @waifu = @waifuName){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                    unbind(@winner.'waifuChallengeDeath')
                    unbind()
                    unbind(@winner.'waifuChallengeWorldChanged')
                    unbind(@loser.'waifuChallengeWorldChanged')
                    unbind(@winner.'waifuChallengeDisconnect')
                    unbind(@loser.'waifuChallengeDisconnect')
                    _waifuWinner(@winner,@loser, @waifu, false, true)
                }
                bind(world_changed,array(id: @husbandoName.'waifuChallengeWorldChanged'),associative_array('player':@husbandoName),@e,@winner = @waifuName, @loser = @husbandoName, @waifu = @waifuName){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                    unbind(@winner.'waifuChallengeDeath')
                    unbind(@loser.'waifuChallengeDeath')
                    unbind()
                    unbind(@loser.'waifuChallengeWorldChanged')
                    unbind(@winner.'waifuChallengeDisconnect')
                    unbind(@loser.'waifuChallengeDisconnect')
                    _waifuWinner(@winner,@loser, @waifu, true, true)
                }
                bind(world_changed,array(id: @waifuName.'waifuChallengeWorldChanged'),associative_array('player':@waifuName),@e,@loser = @waifuName, @winner = @husbandoName, @waifu = @waifuName){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                    unbind(@winner.'waifuChallengeDeath')
                    unbind(@loser.'waifuChallengeDeath')
                    unbind(@winner.'waifuChallengeWorldChanged')
                    unbind()
                    unbind(@winner.'waifuChallengeDisconnect')
                    unbind(@loser.'waifuChallengeDisconnect')
                    _waifuWinner(@winner,@loser, @waifu, false, true)
                }
                bind(player_quit,array(id: @husbandoName.'waifuChallengeDisconnect'),associative_array('player':@husbandoName),@e,@winner = @waifuName, @loser = @husbandoName, @waifu = @waifuName){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                    unbind(@winner.'waifuChallengeDeath')
                    unbind(@loser.'waifuChallengeDeath')
                    unbind(@winner.'waifuChallengeWorldChanged')
                    unbind(@loser.'waifuChallengeWorldChanged')
                    unbind()
                    unbind(@loser.'waifuChallengeDisconnect')
                    _waifuWinner(@winner,@loser, @waifu, true, true)
                }
                bind(player_quit,array(id: @waifuName.'waifuChallengeDisconnect'),associative_array('player':@waifuName),@e,@loser = @waifuName, @winner = @husbandoName, @waifu = @waifuName){
                    include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                    unbind(@winner.'waifuChallengeDeath')
                    unbind(@loser.'waifuChallengeDeath')
                    unbind(@winner.'waifuChallengeWorldChanged')
                    unbind(@loser.'waifuChallengeWorldChanged')
                    unbind(@winner.'waifuChallengeDisconnect')
                    unbind()
                    _waifuWinner(@winner,@loser, @waifu, false, true)
                }
                broadcast(@waifuName.color(RED).' is challenging '.color(WHITE).@husbandoName.color(RED).' to escape as a single lady! The first person to die, disconnect, or change worlds loses!')
                
            }

            @plrName = player()
            @husbandoName = @args[0]
            @waifuName = @args[1]
            try{
                @husbandoName = player(@husbandoName)
            }catch(PlayerOfflineException @e){
                msg(color(RED).'Are you sure that husbando is online?')
                die()
            }
            try{
                @waifuName = player(@waifuName)
            }catch(PlayerOfflineException @e){
                msg(color(RED).'Are you sure that waifu is online?')
                die()
            }

            if(pworld(@husbandoName) != pworld(@plrName)){
                msg(color(RED).'Sorry, you must be in the same world as the husbando to do that!')
                die()
            }

            @plrUUID = puuid(@plrName,true)
            @waifuUUID = puuid(@waifuName,true)
            @husbandoUUID = puuid(@husbandoName,true)

            @plrGender = import(@plrUUID.'gender')
            @waifuGender = import(@waifuUUID.'gender')
            @husbandoGender = import(@husbandoUUID.'gender')

            if(@plrGender == 'g'){
                msg(color(RED).'Sorry, you are a girl! You cannot claim waifus!')
                die()
            }
            if(@waifuGender != 'g'){
                msg(color(RED).'Sorry, your waifu must be a girl!')
                die()
            }
            if(@husbandoGender == 'g'){
                msg(color(RED).'Sorry, that is not a husbando!')
                die()
            }

            @time = import(@plrUUID.@waifuUUID.'lastChallengeTime')
            if(@time != null && (time() - @time) < 86400000){
                msg(color(RED).'Sorry, it hasn\'t been 24 hours since you last challenged them!')
                die()
            }
            if(import(@plrName.'inActiveChallenge')){
                msg(color(RED).'You are already in a waifu challenge!')
                die()
            }
            if(import(@husbandoName.'inActiveChallenge')){
                msg(color(RED).'They are already in a waifu challenge!')
                die()
            }

            if(import(@husbandoUUID.@waifuUUID.'isMarried') != true){
                msg(import(@husbandoUUID.@waifuUUID.'isMarried'))
                msg(color(RED).'Sorry, he is not married to her!')
                die()
            }
            export(@plrName.'inActiveChallenge',true)
            export(@husbandoName.'inActiveChallenge',true)
            runas(~console,'/warp husbando1 '.@husbandoName)
            runas(~console,'/warp husbando2 '.@plrName)
            bind(player_death,array(id: @husbandoName.'waifuChallengeDeath'),associative_array('player':@husbandoName),@e,@winner = @plrName, @loser = @husbandoName, @waifu = @waifuName){
                include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                unbind()
                unbind(@loser.'waifuChallengeDeath')
                unbind(@winner.'waifuChallengeWorldChanged')
                unbind(@loser.'waifuChallengeWorldChanged')
                unbind(@winner.'waifuChallengeDisconnect')
                unbind(@loser.'waifuChallengeDisconnect')
                _waifuWinner(@winner,@loser, @waifu, true, false)
            }
            bind(player_death,array(id: @plrName.'waifuChallengeDeath'),associative_array('player':@plrName),@e,@loser = @plrName, @winner = @husbandoName, @waifu = @waifuName){
                include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                unbind(@winner.'waifuChallengeDeath')
                unbind()
                unbind(@winner.'waifuChallengeWorldChanged')
                unbind(@loser.'waifuChallengeWorldChanged')
                unbind(@winner.'waifuChallengeDisconnect')
                unbind(@loser.'waifuChallengeDisconnect')
                _waifuWinner(@winner,@loser, @waifu, false, false)
            }
            bind(world_changed,array(id: @husbandoName.'waifuChallengeWorldChanged'),associative_array('player':@husbandoName),@e,@winner = @plrName, @loser = @husbandoName, @waifu = @waifuName){
                include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                unbind(@winner.'waifuChallengeDeath')
                unbind(@loser.'waifuChallengeDeath')
                unbind()
                unbind(@loser.'waifuChallengeWorldChanged')
                unbind(@winner.'waifuChallengeDisconnect')
                unbind(@loser.'waifuChallengeDisconnect')
                _waifuWinner(@winner,@loser, @waifu, true, false)
            }
            bind(world_changed,array(id: @plrName.'waifuChallengeWorldChanged'),associative_array('player':@plrName),@e,@loser = @plrName, @winner = @husbandoName, @waifu = @waifuName){
                include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                unbind(@winner.'waifuChallengeDeath')
                unbind(@loser.'waifuChallengeDeath')
                unbind(@winner.'waifuChallengeWorldChanged')
                unbind()
                unbind(@winner.'waifuChallengeDisconnect')
                unbind(@loser.'waifuChallengeDisconnect')
                _waifuWinner(@winner,@loser, @waifu, false, false)
            }
            bind(player_quit,array(id: @husbandoName.'waifuChallengeDisconnect'),associative_array('player':@husbandoName),@e,@winner = @plrName, @loser = @husbandoName, @waifu = @waifuName){
                include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                unbind(@winner.'waifuChallengeDeath')
                unbind(@loser.'waifuChallengeDeath')
                unbind(@winner.'waifuChallengeWorldChanged')
                unbind(@loser.'waifuChallengeWorldChanged')
                unbind()
                unbind(@loser.'waifuChallengeDisconnect')
                _waifuWinner(@winner,@loser, @waifu, true, false)
            }
            bind(player_quit,array(id: @plrName.'waifuChallengeDisconnect'),associative_array('player':@plrName),@e,@loser = @plrName, @winner = @husbandoName, @waifu = @waifuName){
                include('/home/minecraft/server/plugins/CommandHelper/includes/waifuWinner.ms')
                unbind(@winner.'waifuChallengeDeath')
                unbind(@loser.'waifuChallengeDeath')
                unbind(@winner.'waifuChallengeWorldChanged')
                unbind(@loser.'waifuChallengeWorldChanged')
                unbind(@winner.'waifuChallengeDisconnect')
                unbind()
                _waifuWinner(@winner,@loser, @waifu, false, false)
            }

            broadcast(@plrName.color(RED).' is challenging '.color(WHITE).@husbandoName.color(RED).' for '.color(WHITE)@waifuName.color(RED).' as his waifu! The first person to die, disconnect, or change worlds loses!')
        }
    )
)
