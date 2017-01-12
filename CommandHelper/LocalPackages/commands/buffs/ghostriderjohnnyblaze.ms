@plr = player()



@hero = associative_array(
            'name': '§8Gh§0o§8st R§7i§8der§8(§6J§cB§8)',
            'class': 'ghostriderjohnnyblaze',
            'sig': 'CEutHlZmoSqJOeOUYZCUWov3p+401agiSRc6MyaCkM7XUhPST8MmbNXE+0ug14Bx9/mnnC6d78MFFzJjJlKh8kwn70bWgpXm8jtUenUgQQ+0cqCmoMJebvxGYLmbqgad7VYPcIT8958jr8ycbZ3pmD0D4dVKbnMZ7HQz1gSa6ZAzaV6KvUz10VTOkm/HJqw/Nh3Bhual6dYhBd1/G7Xwc0t+yUJhV4aQDLhRAOS3eta/XH3pbGWdnwR8f2Sj5Pd39vsxxzeVkGlIlUjo8RGk1raBdy5c1gRppsL61nBBk3TubJmIa0VFj7zqP4fM5Y2HYkcRH9xToN++7/Sekt7RbV+9db2Ll8CyGIQvVRFo3/EWG20mwj6xEKqxPDCwmidf2GQJfyCfE4mAdJxe7KCiOZO/yhyFrUBO5iDfbA7N03rRsbc+qsmEK77UH/EWz2drYbui64Z1a5TdIh/+5datklqUfqXK/rdi6zdbdD8Y7YzBlVoFBT9wcopiM0a/M+DLm9+m7IY52DTjJ6vSZPvxBiZM/XFe/blOwTRKxU+EGCvnQqeisRU5NIhINIcftLE24uNMx12IQgihblON9yYAAcZxR5Cjiz4Axw3JN1AfS/2Lr50O/0BhOs8i4nCCmoQSmoLIlguCHjm5eSMTAr3AHWYU4OHMF7wrlGTAx60v6Lw=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzkyMjQ5MDM0OTIsInByb2ZpbGVJZCI6IjdkZmY5MWRkOTZlNjRiNzM5ZGZhMTc5OTJlMDU1Njk0IiwicHJvZmlsZU5hbWUiOiJfVGtreTRFdmVyWVRfIiwic2lnbmF0dXJlUmVxdWlyZWQiOnRydWUsInRleHR1cmVzIjp7IlNLSU4iOnsidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS82MGU0YmY0ZjZhOTA3Y2EwODE3ZTk3ZjkyNGYxMzQ0ZDZhNzg1MWZmMjNlOTIxODY3NmQ1ZjFkOWZmOThjOCJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "LOOK INTO MY EYES...YOU SEE NOTHING.",
            'powers': array(
                "/buff",
                "Can throw fireballs by punching with an empty hand",
                "/run 0-5",
                "/haste 0-5",
                "/flame <playername>"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 10 true",
                "/effect ". @plr ." 10 9999 4 true",
                "/shot give ". @plr ." ghostridershotgun",
                "/shot give ". @plr ." flamethrower",
                "/effect ". @plr ." 12 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true"                
            )
        )
