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
            @sigs = array(
                'REuxdxwVNAqzAwFbLFyXKqoUP77nEjwzkM916eydKnQi9chZjBQajj79xM9SllD2lY7XLpa37dOEqPs0oadbjZdOSTplNxCPwtY9Vlq3CNKYNkKRYt5HG4vK6HSx82cSwATdBE9j0GaXKw8FFS3+N5hzs3D8AUftUNTSUit+FWJsce0FhP7A/C3wcP0ARKBjyg4YHv2lIO2LTeDAUX25IGh10eS1cOYr7zNLFgNmhVmq1hULoEoeejYOapkGpKmEp8OB4DGB3tF2gWsoVDa4VH9Bf5YUPY7/2L178GuSMhvF/AhKamX/ZjrP/rc5vB+MS8UFAgyzzg3Y8eATnh3Oto1kIiuWnmTDwiafFrYYTUEEvIFuk9RjPe3SiRI4C/G0aoBoFkw4iVE1jD1b564iWrS2NdUxm2zAq3SQ3IWFLhJ/hkfvXDMR5wbitmjxiKsmhpkuikmPI0N9S7OKXPMYWaqfYgWAXC4AQC3CdiDjrECt8itUHnu7qbcblaefyKY8URIVxwoa1DoDp2uGw4sHIl8MokDx0pjrCF7oMtta3EXn4cQgntJFli83uAzHYfOUxdbAZkYPQtRFww0rCRigdFIcUrIAAwc0zFEhFEfCJJu5ADQnP0M9oTcd+/23E7kasLp08BBkawKf5bmdujZHcHWY2byM7lSi2tjWaj3tKYQ=',
                'TSjzMpuVuSmOP4d0iHijnkCiASW0JnRqiFj1lfiCFV5dUByzm+o4Q/hI6TKYvsQ3vTun19Nvl7fkcPcKk2dUnqlI2d6JEkMu/e92ifSGLnHjI7C43QR3WHG5LrQv3IoASyBL0oaI+OrH2XizIiY/FEXhd+4TAy0Fn0xaULgM/Sieth1sKo0zkM23hmmpYIVRz9wWrScx3jd0v4jPIKkWMWs5nHNr9hDg46RMfj0T40FyQt7Dvm7BIXopdoM4m2v8xdhWTK94a+HJpSqVQGFSlvjYo9pZee6ehgI2xMC7KKEpQAM3QnAwFeBFCqQkDfh7ys6fq8oTr0+eU0717yflZnpqIHCS/4ue9Xj8RkvZRBa3B2bPr7pmGFZ1otYeWzxGrTNBf8yeT/60rOUb8vtjzp3wd6bUsesmTa/z4DNn3JRa0OvhCZMC4pCeaOa6uZ09C5nSsBTF65kkJ4cMxA+AD/Gvm5OiIWrh7V378WBZt2RGJb/2t9jPOyQdbJkTSj1z6VvYqSjbFpNL4xYbAten0+Zb59Y/rI/Z8NrFWJ4FGZzPiPONPxDZfKwHymySex4XVQu+zUo68tXuUv/YHhEy+1OPuHeDJ694gpGMkzcmtFHDLrx9wfXsTPfUJXG5yrG5ypreu7xy1UVA/dQCVmJykKyzi4rY/VRLcc9Mb/hmGDU=',
                'hiVzOme9+u9wV7q+N6wr4hsZ0TLY/rp3Ezfe0+hRXa9WaYB8+4OPoyazVboqEvnIxCmGfhR/i0qtTy+LnN+SvXr77uSU5Crc1qWqh4oCio4rtWhKD4SChefBqpc0Ltzyxl5hd6trL7tci2BF11kHDayN8F7yzVq7VLHD1hAw3fYEt6bLv+jNnhcMBQrHkkKY/3coxg+0keIGf2DmJXTwtVzxNmXFU+/gUxHvHh4Axadjzxlzy9FG149kPaocRO1b23RoO9iTgeqoBDOGmbelFI06IJlTxHmf2AfWaluoEkYUEj7WxqN8gIJl5kWqPRG1s088/+iP4HsyewL3L2yevaYRIPFigOGMYn0sAzTQlkZRqBPaq4x9dgftAbUFvUy+khaftw1csZLb+tS56O7TjHM2Lwbjm1Q/70rqzSrSXtqvuRpViQZ1vaxN4vGPTIs0GS56nza+3ERdkWD0ZMTPG4ecIXeQInxue8uXakfnaC7e5+8FHwcSKJCxy/lDyVPxq0SwaJVBQFcTZ42egOa+RQzXDhRe+T1FRsmYOFOML8Ypt3rLcgeDZWdzVrnpoVdWToFOwr4CtQYtOLGEoIz5XgLuK228kRsi5J6JBdnTTLqETcPGBZH2GtJWiuiDexCdpF19fVTcoaA8HQwSSP0KUusirHSYXiHcTSsyvh0yXr8='
            )
            @vals = array(
                'eyJ0aW1lc3RhbXAiOjE1MDg2MjM3ODgxNjEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJKaXJlbl9UaGVfR3JleSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7Im1ldGFkYXRhIjp7Im1vZGVsIjoic2xpbSJ9LCJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzJiMzQyMmQzMjQ0MWVjYTJiNTgxMzZkOGE4ZTQxNjlkOWU5YzI1NGM3MzcyOWNkMGZkZTM4NmM1NGJmMjk4In19fQ==',
                'eyJ0aW1lc3RhbXAiOjE1MDk0MDkzMDk4NDYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJKaXJlbl9UaGVfR3JleSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7Im1ldGFkYXRhIjp7Im1vZGVsIjoic2xpbSJ9LCJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzQxNmQ5YzU0NmVjZjkwYTM3ZmE4NzZkMzlmMTZjZjNlY2NhNDg3ZTM1OTNmYzNjZjFjNmJlMjM4OWRjNjlkMjYifX19',
                'eyJ0aW1lc3RhbXAiOjE1MDk0MDk0NTc3NjYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJKaXJlbl9UaGVfR3JleSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7Im1ldGFkYXRhIjp7Im1vZGVsIjoic2xpbSJ9LCJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlL2Q4M2MxYTc2ZDAzMmUyODQ0MTFkMWJmYTVhMjAyZWVmNzNhODlhOWYxZWM2YzMzODYyZjViZjE5NjZjYiJ9fX0='
            )
            set_timeout(1000,closure(
                @named = false
                foreach(@uuid in @militiaUUIDs)
                {
                    set_entity_spec(@uuid,array(angry:true,color:'RED',sitting:false))
                    tame_mob(@player,@uuid)

                    @num = rand(0,3)

                    @sig = @sigs[@num]
                    @val = @vals[@num]

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
