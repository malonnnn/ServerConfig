register_command(buff, 
    array(
        description: 'Gives Player their Superhero Powers',
        usage: '/buff',
        permission: 'ch.alias.buff',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
        
                include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                @plr = player()
                @class = _getheroclass(@plr)
                
                try {
                    @contents = read('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/chars/'.@class.'.yml')
                    @hero = yml_decode(@contents)
                    
                } catch (IOException @ErrorInfo) {
                    tmsg(@plr, 'There\'s no buffs\'s associated with your current Character Class')
                    die()
                }
                foreach(@power in @hero['buffs']){
                    @power = replace(@power,'<plr>',@plr)
                    queue_push(closure(runas(~console,@power)),'herochargeup')
                }
                queue_push(closure(set_phealth(@plr,get_max_health(puuid(@plr)))),'herochargeup')
                queue_push(closure(set_phunger(@plr,17)),'herochargeup')
                tmsg(@plr,@hero['speech'])
        }
    )
)
