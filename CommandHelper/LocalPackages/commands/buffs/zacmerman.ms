@plr = player()


@hero = associative_array(
            'name': '§7Z§ba§7c§8(§9m§1m§8)',
            'class': 'zacmerman',
            'sig': 'FtUlbW7FanqnsJL0L2wcrjcDghtEYRNWYjCOfnOj54eIJgNUAKgowLxds35OSPxUSd0KJa/6+oAT5/gCdXSoP/OQnH7OQXIatTSdwhkYYwzgMmgM2rI5B++b+znxhiwUzoL7FH6G/i5TG/ID3e+ayTcmqw9NjahxoKW4/igFvQwUUICHEVYOdgDkJb79Xq3WlagO5TQjyLign5CS1YR5ehGUYqKYKp8XUTNmIZ2NavaMDmlJmCjqg3jbR00MPDgsr+9uZIu2Br2JWy6i749CyjqFmfp/vivJcNesGqY7wvfLIoaeMYlJ3ksbPf1rhtlO3T5QmHCJqy6ntaXj6/q5tWOhB+zNRlX6qcR4LBES1Uk9N17xWh48UqIGYyUnhRZy4q1ubOkdkMknIuDqUVH5BlkDq5hCbdEsjkKphps2Un9/qf5eg6CxRDQFMdzHwoSvFDC7/vQr6tpgKKBzJDxlyA2WOlc1ruCFeOEWqRAXPOtDDbCmB8AnFNmwFjQNi+qBYin1tcSJfX7YXfJO/4wzQDSaFUY/3wQnjb4h7JPqqcScECkYK1HF1k4u3iTBrtm0sAPgkArPYr/sHoWKKHnDJnzUOW11GwhfcNrJhqpWPLdFwkPpvEMqAIH2KNysmm7FkP4hjdZbWzM9WX5SuaMAlaguoujv+K/1rY+LKB0AN5Y=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MTE1NTY5MjU1NzcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJKaXJlbl9UaGVfR3JleSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvNWFiMzRhZWE5NmFjOWViNzZlZWI4MDFiNmY4NzNiY2JiYjJkNDY1N2ZkM2Q2YmU0YTRjMjlmZDBiMDZhOTg1OSJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "Time to save the world once again!",
            'powers': array(
                "/buff",
                "/cast bubble",
                "/cast stream",
                "/cast waterscooter",
                "/cast waterspear",
                "/freezewater",
                "/haste <0-2>"
            ),
            'buffs': array(
                "/effect ". @plr ." 13 9999 1 true",
                "/shot give ". @plr ." watershot",
                "/minecraft:give ".@plr." minecraft:iron_boots 1 0 {AttributeModifiers:[{AttributeName:\"generic.movementSpeed\",Name:\"generic.movementSpeed\",Amount:0.5,Operation:0,UUIDLeast:341641,UUIDMost:949552,Slot:\"feet\"}],display:{Name:\"§bMerman Tail\"},ench:[{id:8,lvl:30}]}"
            )
        )
