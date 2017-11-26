if(@plr == null){@plr = player()}


@hero = associative_array(
            'name': '§8A§4r§ck§8h§ba§8m §8K§7n§bi§8g§4h§7t',
            'class': 'arkhamknight',
            'sig': 'fl0+JNz2nnS4qj2XXMPOkWannCQUyWVlsJcdqVQM/uZsI67fKncbzBOVijRTvCi2SmgsPjWVLS77JUTmV1vHagdQYUpj0GP3Twp7ihUy8TYHPrqFiIblQThUXonncJxKtxWip2EsFU5ia0yJGQzy/EZxIQiWv+FT80QuGJOAof6T2nOojiV+1SMmG++EaeQLr/vMUvfhrcLBNqbVnTnjTm7UxDMgcMiowe4KDBDKWufvXH3wFvVdpK/aYQK683teQ9mqy2aSgWCRBUzECByehkahGZpxOCJcHKo5HlFAq+kO1kLnXuzIpYe207G4wiKWdTgGpJ7wUld7wzObGSFIhfVH/IKwVMYhDv+893PDypATlEV2rNqRoRNfePVxiYNFGC9WAgmy99lYol4tMCdG+kLbB6kChh8Zwmq3r7D/IPsv7MDqo3fZrYDS9j2XEgXgm5TWJ+YJJ2kPI/Y6y4kvPIo9nmWRb+MhJlQ/K6Nx6l2kAe4vqBZIPFD51phgOqoxMdP3No57cnAa8Jzv2jiRGjfyc9C2sBxsswwIP9TpAqxRGDomja5HvUdGc+G4LXIhzywW+QSZxo0EL9H49J/HT87mWv8ddjPEktDbzY9N3FskFePrbHaQQcJeXsy2H46QQUVlwIDaH2nLBP/mkKBynKTPcLtdCYE327z5TKjh5mw=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MDg1MTI4Mjc3NTksInByb2ZpbGVJZCI6ImY2MjE1ODZlOGVmODQ0OGQ5MjY0ODZiNjEzNzUwNTJlIiwicHJvZmlsZU5hbWUiOiJQcmVzaWRlbnRfTXl0aCIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvYTRlYjJhOTE2MzIwN2M1MzFmMzU0YjNlOTU5M2M4YWI3ODEyYTY1YmQxNmVmYjQ2OThmZmRlNTM1ZDhlODAifX19',
            'trail': '',
            'op': 'false',
            'speech': "You always told me Bruce... focus on what I want to achieve... and it'll happen. Well you wanna know what I want now, huh? I want you dead!",
            'powers': array(
                "/buff",
                "/grapplinghook",
                "/shadowhide (Allows you to become invisible in dark areas)",
                "/cast stungrenade",
                "/run <0-2>",
                "/jump <0-2>",
                "/haste <0-2>"
            ),
            'buffs': array(
                "/effect ". @plr ." 21 9999 4 true",
                "/shot give ". @plr ." pistol",
                "/shot give ". @plr ." pistol",
                "/shot give ". @plr ." hunting",   
                "/shot give ". @plr ." bazooka"
            )
)
