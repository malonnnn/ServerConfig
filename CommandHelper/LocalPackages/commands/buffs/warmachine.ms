@plr = player()


@hero = associative_array(
            'name': '§7§lW§4§la§7§lr M§4§la§7§lch§9§li§7§lne',
            'class': 'warmachine',
            'sig': 'lNxvpGKhNTc7K/7O71pVvLzRNrFS4qxd/v5zpY23Rezn+a3BcuIuZ/yKT7UPHbsAKzetcvgq9WUXDzyjiQZpkiv1ibH531a6njuJuRj5t1Iq2z+N3PjKmbAefhSeECxXEgzA5DRlWMyAUWGcqfSkjW1nFteMoeQXK/xLSq3AysWlptcLB74rWllddv+dVcoES05SPHcwQbyKVE/IMCm2SGyKJ+JLGgnQkzEL/uHgcDw3eLdZOOi1h7YuCjd3mr6EvWIUuXmhCxkpjyLzUu8Z0u0IqXh2JLT1aaaJjUgNahwqXCWBmrZ4F6MtFMrTTHeazLE5Lf/vqR0tEEqkph6sP99+fBXvBzvHi2vom0Zrvp+uPQOzpQwTczbnnsYxgHVX/WmUut+hFZkGW5ahFxjtojBzPnCyneyrHIUteIO1ntvnj+ErtaMQ6sVqn7s0Uq5Ei5SB6U54jB0/MwSV4+tU/Xo/FkkVMMlej/0ae8lvV0u2h/E8rX4ynSiq3ZQ0Vlb8Z47t/v3llFzM83l5k5h3XotXoLQ5BBahIiQDq0NG3DVyH01em6Kemw6N8H7xG36nENpOpnqMIE7fAjuEIuY8pmdUgCwwrIGHzRrmZHI/zkQY/YT+jOT/GTGRpfuecBJXKDNemp8pkc135ng0MpSjMhl7JN4d3rTK0pRiytgPfzw=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjM0MDc1MDUsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzUwMTM0ZGNmZjJiODM3NmFiMmI1ZGFjNTdlMzM1MDkxMmRhN2ZkZWRlZmEyYmU4MzEyMjMyZDFjZDA4N2Y4NWQifX19',
            'trail': '',
            'op': 'false',
            'speech': "The name is...War Machine.",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-2",
                "/run 0-3",
                "/haste 0-5",
                "/flyspeed <number>",
                "/fly"
            ),
            'buffs': array(
                "/shot give ". @plr ." warmachinesmachinegun",
                "/shot give ". @plr ." warmachinescannon",
                "/effect ". @plr ." 5 9999 6 true",
                "/effect ". @plr ." 11 9999 2 true",
                "/effect ". @plr ." 16 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." destructionlaser"                
            )
        )
