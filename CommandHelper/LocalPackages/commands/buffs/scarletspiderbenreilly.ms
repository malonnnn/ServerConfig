@plr = player()



@hero = associative_array(
            'name': '§4Sc§1ar§4l§0e§4t §4Sp§0i§4d§1e§4r§f(BR)',
            'class': 'scarletspiderbenreilly',
            'sig': 'fBsfUzbUZiJyk18UADDNVI3rVNYcZblAqRSsXQJYgMwqQEOSL3Pumgaf35bRiO2Cfb7Y+adfqgkjUdJ+JwseTKFE7NPN1MHVc3/kUekPR2eEN/6QgUa/nHcy9HlzlvW/eU+XNHh1PKn4OpHP6zHzWMMfEjBOi2x6mCo0ucnU7L3rKXZNvbViCkHSSMmT0GZjV1dxQ3bhTaSjKT92oOitTCjgOrhTNs1IW38tjqlSIBij/Jm48yzOGal+KJAlZ/aYr5+YzgK99dzVpZALTKBwUHiKDSEvpPMXEohzV8BpljKoS/8MZueaC2rBOyFL810NIigeVSYeDtwcAweMi8wciJtBrnBJ3n3evB7rr8OU58Vg7SNncxxw7L7J5lluMCsjySxDuMO9uH6jK4CjoFRr0AqhhJrXM+4j1/7E9DE4jxWS1+aZtY5QUlwVh7o1YwFpTEsJQIMKtYf9wjH7ea0Gs8CMCxJXlAIOkiqk+7EIGZGrutBqY9Sf+zOayvV3+egeThDQzaQrXxXRc86kr8i66xvoBZqY7GgTU/8viY9MXmai4jEvGQe6/2iT5SoqEqOZqaikLAsooD3/0fa6NLPDX/23bSxWuzhxqLqjB0ZpAx2qOYZlrNTrqIRMdhbPVBjiFzANYIIbGS/hTdA2PqiEFw6VDC3yiHTT7mt8gZTjLtY=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0ODcyODc3NDAxMjEsInByb2ZpbGVJZCI6IjBlNDJlNDc0MTM0ODRmYTg5N2M2Y2IzOWE5YzA5ODhmIiwicHJvZmlsZU5hbWUiOiJjYXJkaGFkeSIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvZDUzN2M5MjcxMmYyNzBjMjQ3MmMyMTIxNDRiMThmNzM5YTU0NzEzOGY0OGVmMTcyZWQ1MjZmMTkxN2IzZDYifX19',
            'trail': '',
            'op': 'false',
            'speech': "I'm not just a clone.",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-7",
                "/run 0-4",
                "/haste 0-3",
                "/web",
                "/websling"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:web 64",
                "/shot give ". @plr ." webshot"
            )
        )
