@plr = player()


@hero = associative_array(
            'name': '§0Darth Sidious',
            'class': 'darthsidious',
            'sig': 'k7KDaV9M5Z6tuMdYUBG/+73lGln8mSk4spJwSTTtlGHYPbiY/+tJRvOK0DiduPM8wMDKqiwfc0XOnzIxPA3llCWDRkC1yNl355DCjWHeeR1L94H4jv1A0rkJBILEVMviN6qwpNpJXo7nGMAASuq2gHDbbUjnpfQ8u7347iQFucGWLMaPeRBgs9wGfaN61p1jEtIfFS/jir+SQEiAg5Un079zDN8gB4/9hsK4r/hCW0+9W0SsClC0VtF/+5NF0YzSOyk99wYLCIBlQzkQYPk5Dy4oPw7i16+hQ9+w8crowuq74IsEt4o1aRD6WfvhGLY5FzAi0zV0ReM1+M4HyTQIa3FbrvYOkvkLpljh3yK0MY+EvFdj3iz63AC9v6Ig8ozraXlekOuiFhCIHvsBWOw7zmMCSyDWjrLTtJiKfmh7S5mPrXG8X0fnzodz0LGn9j4j4EpVhoVXQfeJSL11reEXzOWNxCXv5O+OJiRH0F/tx37wHd3ac3LjXyyeijCyuVhQL5Gh/sWwQB3Pv2cXiVRznU/FNU6q69NoYVvJaf7EwbNECevkbFmkUQYD0Nfu56eoLVUOwB7QI3aHv4W6Qkf4WEde6W/KgipWCWGPZCAQfTN/fiV5STCxvz+Cbfs0uwyfno3QFOxU7LDr0MpsO26a6/LQMpeZu9ptxT7Wt8sKFIQ=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI4NTA5NjcsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzkxNTc5MGU3MThmN2VmYjA5YTk1Yzc3ZjNiMTkyYjVlN2ZlMzMxMjFlMjhkMmM3MTJiOWZjYWRiMzc2ZmNhMyJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "Let the hate flow through you.",
            'powers': array(
                "/buff",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-1",
                "/forcepush <playername>",
                "/forcechoke <playername>",
                "When you punch a player empty handed, your victim is struck by lightning (force lightning)"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:iron_sword 1 20:2 16:100 name:&0Darth_Sidious's_&4Lightsaber",
                "/shot give ". @plr ." forcelightning"                
            )
        )