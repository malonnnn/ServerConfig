@plr = player()


@hero = associative_array(
            'name': '§2Y§6a§m§6c§2ha',
            'class': 'yamcha',
            'sig': 'eyJ0aW1lc3RhbXAiOjE1MTgxMzMwNDQ4ODgsInByb2ZpbGVJZCI6IjA4ODBlY2NjZmVlZDRhMmY5ZTIyZDhmNzIxZjM5MTNlIiwicHJvZmlsZU5hbWUiOiJaZUVuZm9yY2VyIiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9mMWY2Y2ZiNDM2Njg2NGU1YmE1ODdmZTI1ZTRiNTE3ZTY3ODM3MTJkYWFmNWE2ZWVkYWE2OTMyOWYyNGE1ODAifX19
            'val': 'eyJ0aW1lc3RhbXAiOjE1MTYxNDI3Mzc0MjMsInByb2ZpbGVJZCI6ImYzMDc3ZTY3OWNmODRiNDhiNDg4NGE1ZmQ4OTlkNjk3IiwicHJvZmlsZU5hbWUiOiJLYXJtYTAwMDEiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzMyNWFiNzBlNGExOGFjNGZhM2FlMzhmODdkMDg3YTliNjQ3NzY2YzNhNDZjYmQ1NDQ2MmUzMWJiZDgxM2FkYyJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "No WAY!!",
            'powers': array(
                "/buff",
                "/jump 0-4",
                "/run 0-4",
                "/haste 0-4",
                "/flyspeed <number>",
                "/fly",
                "/carryplayer <player>",
                "/dismountplayer"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 7 true",
                "/effect ". @plr ." 11 9999 2 true",
                "/effect ". @plr ." 12 9999 1 true",
                "/effect ". @plr ." 13 9999 1 true",
                "/effect ". @plr ." 21 9999 3 true",
                "/shot give ". @plr ." kamehameha",
                "/shot give ". @plr ." kiblast"
            ),
            'alts': array(
                'yamcha',
            )
        )
