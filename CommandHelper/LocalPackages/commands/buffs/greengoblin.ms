@plr = player()


@hero = associative_array(
            'name': '§2Gr§5ee§2n G§5o§2blin',
            'class': 'greengoblin',
            'sig': 'b1IGHPwu2yNI2CL5lCagC4pz60tc8tqqIm3Z/AS+YcDf7dSXMWfklUvWR9Vl4FyvWGmgnIXZ5y+C94NwP8xn6EuPMsYbskbMBwkuLw8+1wOEmgkwYVqv5HNgvlUmb8PNhZaKsaWUbYkxqgEtENbeoB/DkDHSJxGOUe+/d66EC0XPdFTjYsKWAYnmxKL8UuYf31yL4StSILm5DmG9tXkd4ER49N2ZG9IAjnyPsFG5RyCZgmNCUQneqfkIgJzq0yGb9/0bEjRulxt/o8d0DDnGcSYvwpd/DJ9OFMp/MuD98pT9mRgoYl6XQxWaKcHpcQnAVCqCvLzN+PDDrnJaAyeHgZV9vWPTz9W+dS3c+BqUQbuX0uh+r9uB3NnKhYiD+2b/5kMIr8bRNVY6MjK8bwe+Cb991EBr39UeXsDdt4hzFotITRqKeCZuEPtxlUUA3fyvKO8BRF8n3nyp+fD73CcPiquU3lUHWqgbmUlGBAAHhR4mRg/QBqJkwrVFKnRwng4PvH/zOE+Y3/YH0zwwgvJ+2Bhj6q9k+cxsya2iT7mzsIQ9CA+V2hWhKEgqEn7d3D90HwTPgXfzGu6HUozMzP0am1ky1s2h8xD9P5b3+37RgqaqaTNx4yrnrnXWtYN8jSJ8pssGqd6fEVGjTygFLEto/s7fWucg8h5gl0z6Fp2P1XA=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjkxMzQ3ODU0MTEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzUxZjY4OWJmNDM0NTk4NDRlYThjNzFiZDA1NDQxZWRjM2ZlOTQ4OWQ2MWNmZDc5MGU3OWJkMzhjZmJlNzUifX19',
            'trail': '',
            'op': 'false',
            'speech': "Itsy Bitsy Spidey, climb up on the web, the goblin came and cut of his web.",
            'powers': array(
                "/buff",
                "/flyspeed <number>",
                "/fly (simulates his hoverboard, he can't really fly)"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." pumpkinbomb"                
            )
        )
