@plr = player()



@hero = associative_array(
            'name': '§eF§4i§ere§8f§el§8y',
            'class': 'firefly',
            'sig': 'SM2Q5IOsbqmCyFFRxQhvunamjqco4+N766gY9AqMi5pTtcpupwfKGUqwwp+5+FrBlKiwBFUetN4RUDFvodSqQyncRfaHe4oKZEucMVOZc8DHQbcPrOQY7o9jQd2mWx5rkwkhCiFstfqhyn/oOgDWrZdWSIqpSy8Qh2DYmk3Wgd8DvZ89EpDxeeW8mv1zyCbhFYfc3nMgCuLA9zXmxBEn0pD1L3nACVaFrqSBTf7g69GsYaeHoCpAr1fLTbOjrCjV60tn1uXr2RdABGmhV9wqSbvwDiv++N9a3JMMOaGT6IBmCxs27gMe4j0nmU29iTv5LFOdNXu0cN83TKt/LdghJ+Oks5DA78QELETMxiculnVEBJXkK9LwqgElf/LSE+So/2LBAbAz5sDeJuRsDBzXS2LnwPDAaNmMgWOsYEZlLktrTXYMUFI4uYyI84yR0mW3jPbb1XVGSfsJkSsqqJMk6N0/e61PjfJqiO9Z8gp85KlrHnqsJKLh18ytatKGnbYsgca+IZp+kvVHUajcdaDx+BOvFZVUrOmb7WMaE4YvjXkiYJSaMasca9PNSVEjCqx6wCODxE2Yugt1cmbeGZQXWbPjOaqBObG5gxariSeBsVn3e+hGpNWBYQ+s0p+KUtJ0fx/ibdjmxo6PrIMSJwRMR/C/E2TJ2HsmgXbZUIGAa5s=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzI0Mjk2MDAyMjQsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzMzMmZiNGFjZTkxY2I5NzEyYTQ0MzYyMGEzNjgyN2I5YmM3NWQyNTdlYmJlMDNkMjg5OWFiMzQxNGRkMjM0YSJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "I am Firefly!",
            'powers': array(
                "/buff",
                "/jump 0-3",
                "/run 0-2",
                "/haste 0-2"
            ),
            'buffs': array(
                "/effect ". @plr ." 12 9999 4 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." flamethrower",
                "/give ". @plr ." minecraft:elytra 1 70:1 34:3 name:&eF&4i&ere&8f&el&8y's_&8Glide_Wings"                
            )
        )