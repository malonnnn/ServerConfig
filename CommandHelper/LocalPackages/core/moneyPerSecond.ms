set_interval(5000, closure(){
    @plrs = all_players()
    include('/home/minecraft/server/plugins/CommandHelper/includes/isclassop.ms')
    
    foreach(@plr in @plrs)
    {
        if(has_permission(@plr, "rank.mod")){
            die()
        }
        
        if(has_permission(@plr, "hero.op"))
        {
            if(acc_balance(@plr) >= 5){
                acc_subtract(@plr,5)
            }else{
                runas(~console,/pex user @plr group set mortal)
                runas(~console,/pex reload)
                runas(~console,"/sudo ". @plr ." c:/mortal")
                set_timeout(1500, closure(
                    tmsg(@plr, concat(color(dark_red),"You ran out of money! You have been re-set to a mortal!"))
                ))
            }
        }
    }
});