proc(_changeSkin, @plr, @sig, @val, 

    if(length(@val) >= 3 && substr(@val,0,3) == 'eyJ'){
        
        runas(~console,"/disguiseplayer " . @plr . " player " . @plr . ' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
        console("/disguiseplayer " . @plr . " player " . @plr . ' setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}')
    } else {
        runas(~console,/disguiseplayer @plr @sig @val)
    }
    
)

