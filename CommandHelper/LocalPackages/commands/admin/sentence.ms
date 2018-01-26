register_command(enabletag, 

    array(
        description: 'Hire\'s a Player as a OP',
        usage: '/enabletag <tag>',
        permission: 'enable.tag',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure(@alias, @sender, @args) {
        
                if (array_size(@args) < 3) {
                    msg(color(RED).'Usage: /sentence <loserOfTrial> <numberOfSentences> <summaryOfTrial>')
                    return(false) 
                }

                @loser = @args[0]
                @loser = player(@loser)

                @numTrials = @args[1]
                if(!is_number(@numTrials)){
                    msg(color(RED).'Sorry, param 2 should be a number.')
                    return(false)
                }

                @numWords = array_size(@args) - 2

                for(@i = 2, @i < @numWords, @i++){
                    
                }
                
                                
        }
    )
)

