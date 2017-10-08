register_command('policelesson',

    array(
        description: 'Start a police lesson!',
        usage: '/policelesson',
        permission: 'police.lesson',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        
        executor: closure(@alias, @sender, @args) {
            if(array_size(@args) != 0) {
                return(false); // this sends the player the usage text you specify in the register_command array
            }
            if(has_bind(@player.'policelesson')){
                die(color(RED).'You are already learning this lesson!');
            }
            broadcast(color(GREEN).@player.' is now learning Lesson: Police! '.(color(WHITE).'/policelesson')
            sudo('/ch leave global')
            runas(~console,'/pex user '.@player.' add multiverse.access.classroom')
            runas(~console,'/warp class '.@player)
            runas(~console,'/pex user '.@player.' remove multiverse.access.classroom')
            runas(~console,'/pex user '.@player.' add -*')
            set_timeout(3000,closure( 
                include('/home/minecraft/server/plugins/CommandHelper/includes/policeLesson.ms')
                
                             @randomQuestions = @questions;
                // @randomQuestions = array_rand(@questions, 30, false);
                msg(color(YELLOW).color(BOLD).'Police Lesson:');
                msg(color(GREEN).@randomQuestions[0]);
    
                bind(player_command,array('id':@player.'testNoCommands'),array('player': @player), @e){
                    cancel()
                    msg(color(RED).'Sorry, no commands allowed while taking the test!')
                }

                bind(player_death,array('id':@player.'testDeath'),array('player': @player), @e, @randomQuestions, @player, @answers){
                    broadcast(color(RED).@player.' is now finished with the police lesson')
                    unbind();
                    unbind(@player.'testNoCommands')
                    unbind(@player.'policelesson')
                    unbind(@player.'testQuit')
                    runas(~console,'/pex user '.@player.' remove -*')
                    runas(~console,'/ch set '.@player.' global')
                    runas(~console,'/warp lab '.@player)
                }
                bind(player_quit,array('id':@player.'testQuit'),array('player': @player), @e, @randomQuestions, @player, @answers){
                    broadcast(color(RED).@player.' is now finished with the police lesson')
                    unbind();
                    unbind(@player.'testNoCommands')
                    unbind(@player.'policelesson')
                    unbind(@player.'testDeath')
                    runas(~console,'/pex user '.@player.' remove -*')
                    runas(~console,'/warp lab '.@player)
                }
                
                bind(player_chat, array('id':@player.'policequiz'), array('player': @player), @e, @randomQuestions, @player, @answers){
                    cancel();
                    msg(@e['message']);
                    array_remove(@randomQuestions, 0);
                    if(array_size(@randomQuestions) > 0) {
                        msg(color(GREEN).@randomQuestions[0]);
                    } else {
                        broadcast(color(RED).@player.' is now finished with the police lesson')
                        unbind();
                        unbind(@player.'testNoCommands')
                        unbind(@player.'testDeath')
                        unbind(@player.'testQuit')
                        msg('Thank You For Learning This Lesson, Good Luck On The Quiz! Do /policequiz when ready!');
                        runas(~console,'/pex user '.@player.' remove -*')
                        runas(~console,'/ch set '.@player.' global')
                        runas(~console,'/warp lab '.@player)
                    }
                }
            ))
        }
    )
)
            
            
            
