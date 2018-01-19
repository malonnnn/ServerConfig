@plr = player()



    
@hero = associative_array(
            'name': '§8Q§7u§8a§7k§8e',
            'class': 'quake',
            'sig': 'fFhGYUPkIgMzGyarjAVLCCw3YGfPyMCoINhdkOAdP84aJMo+XfEUhsiyGUP0IgPkucJNr/kL1xu/dt+mhOHXKqSpV5tryC6eHHnwQxLN7ykMox0CzZMk69zOHiDmUe+UCtowN4ZHCa5OQwPO/i3bImTNHBUDXE5+m18G1SE/p9lL0QSyl/NAU1ODutvcsVdmxVsluL63B1CQGG2jx9Lvwn1L119re9glEQ73KqfBwEEZ+95RRx+GP4lz1I/F3y/fCdDM9O7ZIvaiU2d+6bDTUJpWvZRKAflX5Vto6mIpdCkXO2MU0MPC53L/n8CKbqx7y2hHvHPiCfrC4xXXFKp+vBRdSQfE8idJSXqc5pBPPwhk4JkQwjaZ8Tc8EYH40uaqYSIznJkR7ItpsK+aKeeh63cZUmsCSXuj3wB0qaniS7keuf0S1eALlek3FUyPCRFqGRk48KTZH7+6sq2dFBSuXzMCiRSxEOGZvrfLPs5WuSR7COGgI6VAXo5U/NrEVC6KVLjyuo9kHIcacOYNt1u1JWSAlZJ1r6LXapXb5kEDA2QKZZh1gyBWFyOMga1yFwR7blrCpD3T2pQMeF2/JJ+JWAksXvaiKvW2Yn5WJQC/G0M1rTyBByEXeZwMM9cbaklrQ0xk2r+g2zC3A5avD2+wVk4lf/4KL6YCiZqtlP5Lrlo=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MTM2Mzc1OTI0MTEsInByb2ZpbGVJZCI6ImE4ZTE1OWVhZGVlYjRmNzNhMjQ2NTkxYjU4OWFkY2Y0IiwicHJvZmlsZU5hbWUiOiJNckZsYW1lWVQiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS83MTk3OWNmZGQzNzI3M2NjNzdhYWZkNDU5MGQ1NTA3MGM0ZGY1ZjQ2NWU3MjhiYTU5NWM2ZmZmZjc2ZGQifX19',
            'trail': '',
            'op': 'false',
            'speech': "My name is Daisy Johnson AKA QUAKE!.",
            'powers': array(
                "/buff",
                "/jump 0-9",
                "/run 0-2",
                "/haste 0-2",
                "/push <player>"
            ),
            'buffs': array(
                "/effect ". @plr ." 21 9999 4 true",
                "/shot give ". @plr ." pistol",
                "/shot give ". @plr ." quake"
            )
        )
