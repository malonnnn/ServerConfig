@plr = player()


@hero = associative_array(
            'name': '§7Q§au§7i-§7G§ao§7n §7J§ai§7nn',
            'class': 'quigonjinn',
            'sig': '',
            'val': '',
            'trail': '',
            'op': 'false',
            'speech': "May The Force Be With You.",
            'powers': array(
                "/buff",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-1"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 21 9999 19 true",
                "/give ". @plr ." minecraft:iron_sword 1 20:2 16:100 name:&7Q&au&7i-&7G&ao&7n_&7J&ai&7nn's_&aLightsaber"               
            )
        )
