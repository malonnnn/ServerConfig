register_command(grow, 
    array(
        description: 'Turn into a giant',
        permission: 'ch.alias.grow',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
            sudo('/disguise giant') 
        }
    )
)

register_command(shrink, 
    array(
        description: 'Shrink',
        permission: 'ch.alias.shrink',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
            sudo("/disguise creeper setinvisible")
        }
    )
)
register_command(normalsize, 
    array(
        description: 'Shrink',
        permission: 'ch.alias.normalsize',
        noPermMsg: 'Sorry you don\'t have permission to use this command.',
        executor: closure() {
           sudo('/fixskin') 
        }
    )
)
