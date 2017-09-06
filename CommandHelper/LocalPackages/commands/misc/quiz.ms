register_command('staffquiz', 

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
            @questions = array('1','2','3','4','5','6','7','8','9','0')
            @numQuestions = array_size(@questions)
        }
    )
)
