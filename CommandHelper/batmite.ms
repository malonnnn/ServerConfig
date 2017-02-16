@plr = player()



@hero = associative_array(
            'name': '§bB§9a§bt§9mi§bte'
            'class': 'batmite',
            'sig': 'villager',
            'val': 'baby',
            'trail': '',
            'op': 'true',
            'speech': "I've come to your world to join your team!"
            'powers': array(
                "/buff",
                "/jump 0-4",
                "/run 0-6",
                "/haste 0-3",
                "/fly",
                "/disguise",
                "/gmc",
                "/gms",
                "/undisguise",
                "/disguiseviewself",
                "/back",
                "/tppos <x> <y> <z>",
                "/tp",
                "Access to all warps"
           ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 11 9999 4 true",
                "/effect ". @plr ." 13 9999 1 true"
            )
        )
