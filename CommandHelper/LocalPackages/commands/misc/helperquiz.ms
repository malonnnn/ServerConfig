register_command('helperquiz',

    array(
        description: 'Start a helper quiz!',
        usage: '/helperquiz',
        permission: 'helper.quiz',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            if(has_value('helperquiz.'.puuid(@player,true))) {
                die(color(RED).'You already took this quiz!');
            }
            if(has_bind(@player.'helperquiz')){
                die(color(RED).'You are already taking this quiz!');
            }
            @answers = array()
            runas(~console,'/pex user '.@player.' add multiverse.access.classroom')
            runas(~console,'/warp class '.@player)
            runas(~console,'/pex user '.@player.' remove multiverse.access.classroom')
            runas(~console,'/pex user '.@player.' add -*')
            set_timeout(3000,closure( 
                include('/home/minecraft/server/plugins/CommandHelper/includes/helperQuestions.ms')
                
                @randomQuestions = array_rand(@questions, 30, false);
                msg(color(YELLOW).color(BOLD).'Helper Quiz:');
                msg(color(YELLOW).'Please answer the following questions in chat. Other players will not see it.');
                msg(color(GREEN).@randomQuestions[0]);
    
                bind(player_command,array('id':@player.'testNoCommands'),array('player': @player), @e){
                    cancel()
                    msg(color(RED).'Sorry, no commands allowed while taking the test!')
                }

                bind(player_death,array('id':@player.'testDeath'),array('player': @player), @e, @randomQuestions, @player, @answers){
                    unbind();
                    unbind(@player.'testNoCommands')
                    unbind(@player.'helperquiz')
                    unbind(@player.'testQuit')
                    @answers[] = array(@randomQuestions[0],'died at this question')
                    store_value('helperquiz.'.puuid(@player,true),@answers);
                    runas(~console,'/warp lab '.@player)
                    runas(~console,'/pex user '.@player.' remove -*')
                }
                bind(player_quit,array('id':@player.'testQuit'),array('player': @player), @e, @randomQuestions, @player, @answers){
                    unbind();
                    unbind(@player.'testNoCommands')
                    unbind(@player.'helperquiz')
                    unbind(@player.'testDeath')
                    @answers[] = array(@randomQuestions[0],'quit at this question')
                    store_value('helperquiz.'.puuid(@player,true),@answers);
                    runas(~console,'/warp lab '.@player)
                    runas(~console,'/pex user '.@player.' remove -*')
                }
                
                bind(player_chat, array('id':@player.'helperquiz'), array('player': @player), @e, @randomQuestions, @player, @answers){
                    cancel();
                    msg(@e['message']);
                    @answers[] = array(@randomQuestions[0], @e['message']);
                    array_remove(@randomQuestions, 0);
                    if(array_size(@randomQuestions) > 0) {
                        msg(color(GREEN).@randomQuestions[0]);
                    } else {
                        unbind();
                        unbind(@player.'testNoCommands')
                        unbind(@player.'testDeath')
                        unbind(@player.'testQuit')
                        store_value('helperquiz.'.puuid(@player,true),@answers);
                        msg('Thank you for taking this quiz! Any chat messages you now send will be broadcasted as per usual.');
                        runas(~console,'/warp lab '.@player)
                        runas(~console,'/pex user '.@player.' remove -*')
                    }
                }
            ))
        }
    )
)

register_command('helperquizread',

    array(
        description: 'Read a helper quiz!',
        usage: '/helperquizread <player>',
        permission: 'helper.quizread',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 1) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            @target = puuid(@args[0],true)

            @answers = get_value('helperquiz.'.@target)

            if(@answers != null){
                msg('> > > '.color(YELLOW).@answers[0][0])
                msg('> > > '.color(GREEN)@answers[0][1])
                msg(color(RED).'Say next to read the next question.')
            }else{
                msg(color(RED).'Sorry, that person did not take a quiz.')
                die()
            }

            bind(player_chat, array('id':@player.'helperquizread'), array('player': @player), @e, @answerss = @answers, @playerr = @player){
                cancel();
                array_remove(@answerss, 0);
                if(array_size(@answerss) > 0) {
                    msg('> > > '.color(YELLOW).@answerss[0][0])
                    msg('> > > '.color(GREEN)@answerss[0][1])
                    msg(color(RED).'Say "next" to read the next question.')
                } else {
                    unbind();
                    msg('No more questions.');
                }
            }
        }
    )
)

register_command('helperquizclear',

    array(
        description: 'Clear a helper quiz!',
        usage: '/helperquizclear <player>',
        permission: 'helper.quizclear',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 1) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            @target = puuid(@args[0],true)

            clear_value('helperquiz.'.@target)

            msg(color(RED).@target.' had their quiz reset.')
        }
    )
)