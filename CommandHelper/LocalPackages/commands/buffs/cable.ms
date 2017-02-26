@plr = player()


@hero = associative_array(
            'name': '§7C§6a§7ble',
            'class': 'cable',
            'sig': 'XEIo12lbLAU1Ip6ErY/RRzyP+NRzZnX5i77on0NdpumgbLHEPKnIg3g/7nm0gXh5j1H2P94g0Ij83V0CUb/W3PNDvq/K7jZQ/zPgj14oZKkbz2d8bdryQvKVDsEt6wg/qHuc+seWOtn8bxjWqoOUO7puvgLPHjZGlLoHaL6G8sp0jCbpYVPm/sf3ApkQYoYj0LxlYIxoMzdZCQDGvLKtYFODyWHgly/UjWp/lw6qJCm0wNZS8b7sjsMuV8v2PiWwk9RVsUuCk15CaV9g8KH8LtVtQz/JjORC7sJ/AsSvLXX4g8YvtOXjtscPHC3Wl1Ytcea7jSh9NgC4LLUwjSEiHpnyadgvL7Cu0pxWMk+GISAts9NUo1aHe6Fs12+pPD6/jT/uS6zIPlePQ6wCZxe/O1OhfjpK6Kv2fLz+XvydI18KLTAdvEyH7a/SiW0vrHfr4tWMvgPHfJoFlhCDqhSEQX0OwdbttooQiPun8S/XsNKQOUMzVtI5HgrgYZ4Ri7DLe8HHnHBVQ3XWgwTYcfh3YQ4kWPqfvNVh/wUqSIpf+4zdkpJnAo4CR8FF8mP9yZxD87RAxgZlOERonwfWzEqiPnDMZhXfCIvysN74J0WN05b1+u1QrcdmJKSx/aRm5I17rIVj6YZc5IUNw/WrRxtM1UNzztIj8TIF6Q37E/3uDMI=',            
            'val': 'eyJ0aW1lc3RhbXAiOjE0ODc5NzMyMzQ2MDksInByb2ZpbGVJZCI6IjQ3NDcwN2Y3ZjhiNDQzZWE4OTc4OWNhZTE3OTE3ZTgyIiwicHJvZmlsZU5hbWUiOiJNckNyYWZ0ODg4Iiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9kZDk1YThlZWUzMzEyZTgzZmIzM2YxNjA3YWNjN2Q0ODZhMmUzZDMzZmFlZGJkNDc4MDQzMmJjN2RhYzJkYWIzIn19fQ==',          
            'trail': '',
            'op': 'false',
            'speech': "We are NOT retreating! It's victory or death!",
            'powers': array(
                "/buff",
                "/jump 0-3",
                "/run 0-3",
                "/carryplayer",
                "/dismountplayer",
                "/haste 0-3",            
                "/tppos",
                "/bodyslide"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 8 true",
                "/effect ". @plr ." 11 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." energybeam"                
            )
        )
