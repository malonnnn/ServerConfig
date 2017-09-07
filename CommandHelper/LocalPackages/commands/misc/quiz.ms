register_command('staffquiz',

    array(
        description: 'Start a staff quiz!',
        usage: '/staffquiz',
        permission: 'staff.quiz',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            if(has_value('staffquiz', @player)) {
                die(color(RED).'You already took this quiz!');
            }
            if(has_bind(@player.'staffquiz')){
                die(color(RED).'You are already taking this quiz!');
            }
            
            include('/home/minecraft/server/plugins/CommandHelper/includes/questions.ms')
            
            @randomQuestions = array_rand(@questions, 5, false);
            msg(color(YELLOW).color(BOLD).'Staff Quiz:');
            msg(color(YELLOW).'Please answer the following questions in chat. Other players will not see it.');
            msg(color(GREEN).@randomQuestions[0]);
            
            bind(player_chat, array('id':@player.'staffquiz'), array('player': @player), @e, @randomQuestions, @answers = array(),@playerr = @player){
                cancel();
                msg(@e['message']);
                @answers[] = array(@randomQuestions[0], @e['message']);
                array_remove(@randomQuestions, 0);
                if(array_size(@randomQuestions) > 0) {
                    msg(color(GREEN).@randomQuestions[0]);
                } else {
                    unbind();
                    store_value('staffquiz.'.@playerr,@answers);
                    msg('Thank you for taking this quiz! Any chat messages you now send will be broadcasted as per usual.');
                }
            }
        }
    )
)
