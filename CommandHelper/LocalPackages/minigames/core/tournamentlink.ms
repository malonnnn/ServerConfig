register_command('tournamentlink', 

    array(
    
        description: 'Generates a clickable tournament link in chat',
        usage: '/tournamentlink <tournamentName>',
        permission: 'tournament.link',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            @plr = player()
            if (array_size(@args) != 1) {
                msg(''.color(RED).color(BOLD).'Improper Usage!');
                msg(''.color(RED).'Usage: /tournamentlink <tournamentName>');
                die(); # No need to go further					
            }

            @tournamentName = to_lower(@args[0])
            @tournamentURL = @tournamentName.'_omnivs'

            msg(color(RED).'https://challonge.com/'.@tournamentURL)

        }
    )
)
