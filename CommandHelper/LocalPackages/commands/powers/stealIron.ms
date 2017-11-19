register_command(stealiron, 
    array(
        description: 'Eat the world',
        permission: 'powers.stealiron',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {

            @player = player()
            @plrs = players_in_radius(ploc(@player),100)

            foreach(@plr in @plrs){
                @inv = pinv(@plr)
                foreach(@slot: @item in @inv){
                    if(@player != @plr && @item != null){
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
                                pgive_item(@player,@item['type'],@item['qty'],@item['meta'])
                                ptake_item(@plr,@item['type'],@item['qty'])
                                console(@slot)
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
                tmsg(@plr,color(RED).'Magneto stole the iron from your inventory!')
            }
        }
    )
)
