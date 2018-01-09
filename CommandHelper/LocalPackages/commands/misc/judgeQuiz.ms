register_command('judgequiz',

    array(
        description: 'Start a judge quiz!',
        usage: '/judgequiz',
        permission: 'judge.quiz',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            if(has_value('judgequiz.'.puuid(@player,true))) {
                die(color(RED).'You already took this quiz!');
            }
            if(has_bind(@player.'judgequiz')){
                die(color(RED).'You are already taking this quiz!');
            }
            broadcast(color(RED).@player.' is now taking the judge quiz '.color(WHITE).'/judgequiz')
            @answers = array()
            sudo('/ch leave global')
            runas(~console,'/pex user '.@player.' add multiverse.access.classroom')
            runas(~console,'/warp class '.@player)
            runas(~console,'/pex user '.@player.' remove multiverse.access.classroom')
            runas(~console,'/pex user '.@player.' add -*')
            set_timeout(3000,closure( 
                include('/home/minecraft/server/plugins/CommandHelper/includes/judgeQuestions.ms')
                
                @randomQuestions = @questions;
                // @randomQuestions = array_rand(@questions, 30, false);
                msg(color(YELLOW).color(BOLD).'judge Quiz:');
                msg(color(YELLOW).'Please answer the following questions in chat. Other players will not see it.');
                msg(color(GREEN).@randomQuestions[0]);
    
                bind(player_command,array('id':@player.'testNoCommands'),array('player': @player), @e){
                    cancel()
                    msg(color(RED).'Sorry, no commands allowed while taking the test!')
                }

                bind(player_death,array('id':@player.'testDeath'),array('player': @player), @e, @randomQuestions, @player, @answers){
                    broadcast(color(RED).@player.' is now finished with the judge quiz')
                    unbind();
                    unbind(@player.'testNoCommands')
                    unbind(@player.'judgequiz')
                    unbind(@player.'testQuit')
                    @answers[] = array(@randomQuestions[0],'died at this question')
                    store_value('judgequiz.'.puuid(@player,true),@answers);
                    runas(~console,'/pex user '.@player.' remove -*')
                    runas(~console,'/ch set '.@player.' global')
                    runas(~console,'/warp arcade '.@player)
                }
                bind(player_quit,array('id':@player.'testQuit'),array('player': @player), @e, @randomQuestions, @player, @answers){
                    broadcast(color(RED).@player.' is now finished with the judge quiz')
                    unbind();
                    unbind(@player.'testNoCommands')
                    unbind(@player.'judgequiz')
                    unbind(@player.'testDeath')
                    @answers[] = array(@randomQuestions[0],'quit at this question')
                    store_value('judgequiz.'.puuid(@player,true),@answers);
                    runas(~console,'/pex user '.@player.' remove -*')
                    runas(~console,'/ch set '.@player.' global')
                    runas(~console,'/warp arcade '.@player)
                }
                
                bind(player_chat, array('id':@player.'judgequiz'), array('player': @player), @e, @randomQuestions, @player, @answers){
                    cancel();
                    msg(@e['message']);
                    @answers[] = array(@randomQuestions[0], @e['message']);
                    array_remove(@randomQuestions, 0);
                    if(array_size(@randomQuestions) > 0) {
                        msg(color(GREEN).@randomQuestions[0]);
                    } else {
                        broadcast(color(RED).@player.' is now finished with the judge quiz')
                        unbind();
                        unbind(@player.'testNoCommands')
                        unbind(@player.'testDeath')
                        unbind(@player.'testQuit')
                        store_value('judgequiz.'.puuid(@player,true),@answers);
                        msg('Thank you for taking this quiz! Any chat messages you now send will be broadcasted as per usual.');
                        runas(~console,'/pex user '.@player.' remove -*')
                        runas(~console,'/ch set '.@player.' global')
                        runas(~console,'/warp arcade '.@player)
                    }
                }
            ))
        }
    )
)

register_command('judgequizread',

    array(
        description: 'Read a judge quiz!',
        usage: '/judgequizread <player>',
        permission: 'judge.quizread',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 1) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            @target = puuid(@args[0],true)

            @answers = get_value('judgequiz.'.@target)

            if(@answers != null){
                msg('> > > '.color(YELLOW).@answers[0][0])
                msg('> > > '.color(GREEN)@answers[0][1])
                msg(color(RED).'Say next to read the next question.')
            }else{
                msg(color(RED).'Sorry, that person did not take a quiz.')
                die()
            }

            bind(player_chat, array('id':@player.'judgequizread'), array('player': @player), @e, @answers, @player){
                cancel();
                array_remove(@answers, 0);
                if(array_size(@answers) > 0) {
                    msg('> > > '.color(YELLOW).@answers[0][0])
                    msg('> > > '.color(GREEN)@answers[0][1])
                    msg(color(RED).'Say "next" to read the next question.')
                } else {
                    unbind();
                    msg('No more questions.');
                }
            }
        }
    )
)

register_command('judgequizclear',

    array(
        description: 'Clear a judge quiz!',
        usage: '/judgequizclear <player>',
        permission: 'judge.quizclear',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',

        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 1) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            @player = player()
            @target = puuid(@args[0],true)

            clear_value('judgequiz.'.@target)

            msg(color(RED).@target.' had their quiz reset.')
        }
    )
)
