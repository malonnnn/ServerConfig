register_command(heroes, 
    array(
        description: 'Lists the Super Heroes available on the Server',
        usage: '/listheroes [page number]',
        permission: 'ch.alias.listheroes',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) > 1) {
                    return(FALSE)
                } else if (array_size(@args) == 1) {
                    @pageNum = @args[0]
                } else {
                    @pageNum = null
                }
        
                if(@pageNum < 1 && @pageNum != null){
                    msg(''.color(RED).color(BOLD).'There is no page Zero');
                    die()
                }
                
                @stdout = ""
                
                if (@pageNum != null){
                    @startSpot = @pageNum * 10 - 9
                    
                    shell_adv('/home/minecraft/paginateHeroes.sh '. @startSpot,
                    array(subshell: true,
                        workingDir: '/home/minecraft/',
                        stdout: closure(@a = @stdout){
                            if(@a != "")
                            {
                                @returnVal = @a
                                array @heroes = split('|',@returnVal)
                                @i = @startSpot
                                foreach(@her in @heroes){
                                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @her . '.ms')
                                    tmsg(player(),"#". @i . ". " . @hero['name'])
                                    @i = @i + 1
                                }
                                msg(color(RED).'Check for more heroes using /heroes '.(@pageNum+1))
                            }
                        }
                    ))
                } else {
                
                    shell_adv('/home/minecraft/paginateHeroes.sh 1',
                    array(subshell: true,
                        workingDir: '/home/minecraft/',
                        stdout: closure(@a = @stdout){
                            if(@a != "")
                            {
                                @returnVal = @a
                                array @heroes = split('|',@returnVal)
                                @i = 1
                                foreach(@her in @heroes){
                                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @her . '.ms')
                                    tmsg(player(),"#". @i . ". " . @hero['name'])
                                    @i = @i + 1
                                }
                                msg(color(RED).'Check for more heroes using /heroes 2')
                            }
                        }
                    ))
                    
                }				
        
        }
    )
)


register_command(characterselect, 
    array(
        description: 'Searches for a character',
        usage: '/characterselect <searchterm>',
        permission: 'command.characterselect',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        aliases: array('charsel', 'findchar','csel'),
        executor: closure(@alias, @sender, @args) {
                @argNum = array_size(@args)
                if (@argNum < 1) {
                    msg(color(RED).'Please add search criteria.')
                    msg('Example:'.color(GREEN).' /characterselect superman')
                    return(FALSE)
                }

                @searchTerm = ''
                foreach(@arg in @args){
                    @searchTerm = @searchTerm.@arg
                }
                @heroes = array()
               # shell_adv('/home/minecraft/findHero.sh '.@searchTerm,
               # array(subshell: true,
               #     workingDir: '/home/minecraft/',
               #     stdout: closure(@a = @stdout){
               #         array_push(@heroes,@a)
               #     }
               # ))
               

                @var = shell('find /home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/ -iname \"*'.@searchTerm.'*\" -exec basename \\{} .ms \\;')
                @heroes = split('\n',@var)
                foreach(@her in @heroes){
                    runas(~console,'/tellraw '.@sender.' {"text":"'.@her.'","clickEvent":{"action":"run_command","value":"/selectchar '.@her.'"}}')
                }
                msg(color(RED).'Click a character to select it.')
       ) }
    )


register_command(selectchar, 
    array(
        description: 'Selects a character',
        usage: '/selectchar <character>',
        permission: 'command.selectchar',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',		
        executor: closure(@alias, @sender, @args) {
                @argNum = array_size(@args)
                if (@argNum != 1) {
                    msg(color(RED).'Error: Incorrect parameters. Try: /selectchar superman')
                    return(FALSE)
                }

                @player = @sender
                @class = @args[0]
                @confirmed = import(@player."confirmed")
                if(@confirmed != TRUE){
                    export(@player."confirmed",TRUE)
                    msg(@class.color(RED).' selected! Please click again in 2 seconds to confirm your choice.')
                    set_timeout(2000,closure(
                        export(@player."confirmed",FALSE)
                    ))
                    die()
                }
                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @class . '.ms')
                @plrs = all_players()
                foreach(@playa in @plrs)
                {
                    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                    @otherPlayerGroup = _getheroclass(@playa)
                    if(@otherPlayerGroup == @hero['class'] && @player != @playa){
                        msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                        msg(color(RED).'Sorry, '.color(WHITE).@playa.color(RED).' is already using '.@hero['name'].color(RED).'.')
                        msg(color(RED).'Try again with:')
                        msg(color(GREEN).'/characterselect')
                        msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                        die()
                    }
                    if(array_index_exists(@hero,'alts')){
                        @alts = @hero['alts']
                        foreach(@alt in @alts){
                            if(@alt == @otherPlayerGroup){
                                @h1 = @hero['name']
                                include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/' . @alt . '.ms')
                                @h2 = @hero['name']
                                msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                                msg(color(RED).'Sorry, '.color(WHITE).@playa.color(RED).' is already using '.@h2.color(RED).'.')
                                msg(color(RED).'Try again with:')
                                msg(color(GREEN).'/characterselect')
                                msg(color(YELLOW).'-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-')
                                die()
                            }
                        } 
                    }
                }
                clear_task(import(@player.'isBurningInSunlight'))
               
                if(@class == 'fanfic'){
                    @uuid = puuid(@player,true)
                    sudo('/pex group '.@class.@uuid.' create commonherotraits')
                    sudo('/pex user '.@player.' group set '.@class.@uuid)
                    sudo('/pex group '.@class.@uuid.' add ch.alias.run0 superherocity')
                    sudo( '/pex group '.@class.@uuid.' add ch.alias.run1 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.run2 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.haste0 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.haste1 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.haste2 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.jump0 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.jump1 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.jump2 superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.fanficlaser superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.fanficname superherocity')
                    sudo('/pex group '.@class.@uuid.' add ch.alias.fanficchatcolor superherocity')
                    broadcast(color(GRAY).color(ITALIC).'A shitty fanfic has entered the game!')
                    sudo("/fly ".@player." off")
                    sudo("/gamemode survival ".@player)
                    sudo("/effect ".@player." clear")
                    sudo("/minecraft:clear" @player)
                    sudo("/god ".@player." off")
                    sudo("/tptoggle ".@player." on")
                    die()
                }

                
                sudo('/pex user '.@player.' group set '.@class)
                sudo("/fly ".@player." off")
                sudo("/gamemode survival ".@player)
                sudo("/effect ".@player." clear")
                sudo("/minecraft:clear" @player)
                sudo("/god ".@player." off")
                sudo("/tptoggle ".@player." on")
                
#                include('/home/minecraft/server/plugins/CommandHelper/includes/changeSkin.ms')
#                _changeSkin(@player,@hero['sig'],@hero['val'],@hero['name'])
#                if(@hero['trail'] != ''){
#                    sudo(@player,"/trailsid ".@hero['trail'])
#                }else{
#                    sudo(@player,"/trailsid none")
#                }
                sudo('/stageselect')
        }
    )
)
