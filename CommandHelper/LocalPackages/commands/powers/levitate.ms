register_command(levitate, 

    array(
    
        description: 'Power',
        
        permission: 'ch.alias.levitate',
        
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
    
        executor: closure() {        
            
            @player = player()
    
            if(import(@player."levitateStatus",'') == ''){
                export(@player."levitateStatus",false)
            }

            @levitateStatus = import(@player."levitateStatus")

            if(@levitateStatus){
                runas(~console,"/speed fly 1 ".@player)
                runas(~console,"/fly ".@player." off")
                export(@player."levitateStatus",false)
            }else{
                runas(~console,"/speed fly 0 ".@player)
                runas(~console,"/fly ".@player." on")
                export(@player."levitateStatus",true)
            }
                
        }
    )
)
