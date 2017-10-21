proc(_changeSkin, @plr, @sig, @val, @heroName,

    if(substr(@val,0,3) == 'eyJ'){
        
        @heroName = replace(@heroName,'§','&')
        @heroName = replace(@heroName,' ','_')
        runas(~console,"/disguiseplayer " . @plr . ' player ' . @heroName . ' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
    } else {
        runas(~console,/disguiseplayer @plr @sig @val)
    }
    
)

proc(_changeSkinMindControl, @plr, @sig, @val, @vic, 

    if(substr(@val,0,3) == 'eyJ'){
        
        runas(~console,"/disguiseplayer " . @plr . " player " . @vic . ' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
    } else {
        runas(~console,/disguiseplayer @plr @sig @val)
    }
    
)

