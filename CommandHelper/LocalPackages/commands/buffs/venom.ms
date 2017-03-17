@plr = player()



@hero = associative_array(
            'name': '§0V§8e§fn§8o§0m',
            'class': 'venom',
            'sig': 'ikmnWlkn5MyXF7FFQlWR9iREAbIrC6MTWb/pcPzDpC0NQ348Kr9sCk/5Y5UuCC2DGBE+ocvq+6JZvUXwUxiXp5Q4PhVBis6O+jZdUv8S+hE+x6Vnp9oaCY8gh+SsCqdqwa78qwJsiXiSwOMCE3qF26W9QFRvBV9tXV3NrQ88Jpgp8AOk9ygoZXMlM1jEzUA/pS8m3WNwW99dUVRrI7FdLAbdpA8McqwhCdMhyVk6hw5Nmd2J5HWWRol0cDh85v8VoyMKQpTChgTmQlroqUNTuaf1bdEYpCpJrHaehUIorRn16qCkizOaZdAhzo2usmTPwIBKG7Qnbps4uzUX17sLD0Z7TIALMHDWp8atwMqepN68LwmCqhK6mGLBiLcTNhg5lRJiFsViVesalZeN87BMzsSkpzEfMrBPfWbpgeOiB/MIAnknYCixbPjXuZA7NDQe5eKeLMlf6zUsL4vrSbC6Mi3Qo2zPOU1j7H/io4JK2RwxYF9u/qv0ZHPc/IOTa/uODZOyseou6tEHo8uar3NnS7OI41RcDhzCrx5NyM8fqsUacioWKSJ1sFk/+cdipkWu0iq6WacX0Cu4W5wrHvH0turCCx9bEKT3TwYyB1n7mZufwH9ShqXx1K2KoJFTNR4VMG8HUyh71xcnykh8f5jCAPZdwtUwy7NelI0sdzzokpA=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzQ3NDU5ODM4NjMsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzk2YzMxNDQzOGM1NTIzZjVmYzM3MjgxNGJkOGUyZGViYzJkM2I2MThlZmQ3Yjk0YWIzMWQ0NDg5NTQyNiJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "I am Venom!",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-7",
                "/run 0-5",
                "/haste 0-4",
                "/web",
                "/websling"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 6 true",
                "/effect ". @plr ." 10 9999 2 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:web 64",
                "/shot give". @plr." webshot"
            )
        )
