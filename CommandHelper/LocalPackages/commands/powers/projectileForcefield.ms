register_command(projectilefield, 
    array(
        description: 'Makes you invincible to lasers and projetiles',
        usage: '/projectilefield',
        permission: 'powers.projectilefield',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure(@aliases, @sender, @args) {

            include('/home/minecraft/server/plugins/CommandHelper/includes/coolDown.ms')
            _coolDown('projectileField',30,@sender)
            export(@sender.'projectileField', true)
            msg(color(RED).'Projectile Force Field Active!')
            set_timeout(30000,closure(
                export(@sender.'projectileField', false)
                msg(color(RED).'Projectile Force Field Deactivated!')
            ))

        }
    )
)
