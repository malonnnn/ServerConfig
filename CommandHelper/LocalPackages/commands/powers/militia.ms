register_command(militia, 
    array(
        description: 'create illusion of given player',
        permission: 'powers.militia',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@alias, @sender, @args) {
        
            if (array_size(@args) != 0) {
                return(false)
            }
            
            @player = player()

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('lastUsedMilita',60,@player)

            if(!is_null(import(@player."militia"))){
                @oldMobs = import(@player."militia")
                foreach(@uuid in @oldMobs){
                    try(entity_remove(@uuid),
                    continue())
                }
            }
            @milID = 1
            @militiaUUIDs = spawn_mob("wolf:tamed",6)
            export(@player."militia",@militiaUUIDs)
            set_timeout(1000,closure(
                @named = false
                foreach(@uuid in @militiaUUIDs)
                {
                    set_entity_spec(@uuid,array(angry:true,color:'RED',sitting:false))
                    tame_mob(@player,@uuid)
                    @sig = 'REuxdxwVNAqzAwFbLFyXKqoUP77nEjwzkM916eydKnQi9chZjBQajj79xM9SllD2lY7XLpa37dOEqPs0oadbjZdOSTplNxCPwtY9Vlq3CNKYNkKRYt5HG4vK6HSx82cSwATdBE9j0GaXKw8FFS3+N5hzs3D8AUftUNTSUit+FWJsce0FhP7A/C3wcP0ARKBjyg4YHv2lIO2LTeDAUX25IGh10eS1cOYr7zNLFgNmhVmq1hULoEoeejYOapkGpKmEp8OB4DGB3tF2gWsoVDa4VH9Bf5YUPY7/2L178GuSMhvF/AhKamX/ZjrP/rc5vB+MS8UFAgyzzg3Y8eATnh3Oto1kIiuWnmTDwiafFrYYTUEEvIFuk9RjPe3SiRI4C/G0aoBoFkw4iVE1jD1b564iWrS2NdUxm2zAq3SQ3IWFLhJ/hkfvXDMR5wbitmjxiKsmhpkuikmPI0N9S7OKXPMYWaqfYgWAXC4AQC3CdiDjrECt8itUHnu7qbcblaefyKY8URIVxwoa1DoDp2uGw4sHIl8MokDx0pjrCF7oMtta3EXn4cQgntJFli83uAzHYfOUxdbAZkYPQtRFww0rCRigdFIcUrIAAwc0zFEhFEfCJJu5ADQnP0M9oTcd+/23E7kasLp08BBkawKf5bmdujZHcHWY2byM7lSi2tjWaj3tKYQ='
                    @val = 'eyJ0aW1lc3RhbXAiOjE1MDg2MjM3ODgxNjEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJKaXJlbl9UaGVfR3JleSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7Im1ldGFkYXRhIjp7Im1vZGVsIjoic2xpbSJ9LCJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzJiMzQyMmQzMjQ0MWVjYTJiNTgxMzZkOGE4ZTQxNjlkOWU5YzI1NGM3MzcyOWNkMGZkZTM4NmM1NGJmMjk4In19fQ=='
                    @rest = 'setskin {"id":"87fb3c6c5ff64bf6b326992c6137ea12","name":"tektronic","properties":[{"signature":"'.@sig.'","name":"textures","value":"'.@val.'"}]}' 
                    runas(~console,'/disguiseplayer '.@uuid.' player AKMilitia_#'.@milID.' '.@rest)
                    @milID++
                    set_mob_effect(@uuid, 5, 1, 9999, false, true)
                    set_mob_effect(@uuid, 1, 1, 9999, false, true)
                    set_mob_equipment(@uuid,array(WEAPON: array(type: 261)))
                }
            )) 
            
        }
    )
)
