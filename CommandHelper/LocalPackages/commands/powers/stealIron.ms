register_command(stealiron, 
    array(
        description: 'Eat the world',
        permission: 'powers.stealiron',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {

            @vics = players_in_radius(ploc(@sender),100)

            foreach(@vic in @vics){
                if(@vic != @sender){
                    @inv = pinv(@vic)
                    foreach(@slot: @item in @inv){
                        if(@item != null){
                            switch(@item['type']){
                                case '417':
                                case '306':
                                case '307':
                                case '308':
                                case '309':
                                case '15':
                                case '42':
                                case '101':
                                case '167':
                                case '256':
                                case '257':
                                case '258':
                                case '265':
                                case '267':
                                case '292':
                                case '330':
                                case '452':
                                    pgive_item(@sender,@item['type'],@item['qty'],@item['meta'])
                                    ptake_item(@vic,@item['type'],@item['qty'])
                                    switch(@slot){
                                        case '100':
                                        case '101':
                                        case '102':
                                        case '103':
                                            @inv[@slot] = null
                                            set_pinv(@plr,@inv)
                                    }
                            }
                        }
                    }
                    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroClass.ms')
                    @class = _getheroclass(@sender)
                    include('/home/minecraft/server/plugins/CommandHelper/LocalPackages/commands/buffs/'.@class.'.ms')
                    
                    tmsg(@vic,@hero['name'].color(RED).' stole the iron from your inventory!')
                }
            }
        }
    )
)
