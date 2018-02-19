register_command(speakall, 
    array(
        description: 'Power',
        permission: 'command.rest',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {

            @msg = ''
            foreach(@word in @args){
                @msg = @msg.''.@word.' '
            }

            @plrs = all_players()

            @numPlrs = array_size(@plrs)

            @plrs2 = array_rand(@plrs,@numPlrs,false)

            foreach(@plr in @plrs2){
                chatas(@plr,@msg)
            }
        }
    )
)

