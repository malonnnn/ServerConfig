@plr = player()


@hero = associative_array(
            'name': '§dS§5t§4a§drf§5i§4r§de',
            'class': 'starfire',
            'sig': 'Rod5X3ph7ZfAx4NOQF6QhSqenkC1ZZSX53V31+ZxN/YA6QruyCAmRRE70Upr/NwF4U8OWgXdko8O5JeAjqb11qAo5EDMDumn37+kI98NM+1SBPLPdG23t72iSXPlSbXj8a+Be73kaYh8nNA3S9yfCWNnKopUe11VoL3zxv/ZlMd983QAhvRFC6z52gr9fDPa8XGF5ynCeV2yIzQqgC/vA6x+nBhiFefcIYpKn/bsudS36t4T6rBBjBiDQqT6DGS4+a2TCNVwMjcD0i6hcVELWOPrNLnyuhzKOvy/cPoCg9nEVKcTG8MgpeQPx6haVHYKvPSHsoCdEDF91i6J9o2RfImkY9z/mJjOxVt88POk2khiMv2I1zyvb8/5sM4rFc1rwtJJNwiyGX07qXuuqZnScaWFG1lq2/NQAK5PqNlQ1wVepk712pjtXZe4c05zGeIyj+NISE5MU5tMpqcVUeJYr3H9ZJ9NtLHikCdckANYltMNZ+ifioOY9CgbLnOh3c+8aocEBMlOb2GocMFI4B1m+0egRe9cQO737+hv5ewTuabSnfhOFb6o+3+wKKxlbBrbl5/kVEGz6+x8htvxe5sUG5nJt3bhvgiyQErQFn+1rStJBbEueFBY/wxW/CmEVrL4eza7ClMS99WlXTLDSS1lERvMpdtJqIDpR4XJX7uY/1s=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjQ4MDAxMTEsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJtZXRhZGF0YSI6eyJtb2RlbCI6InNsaW0ifSwidXJsIjoiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS9mOTM2Y2NjM2I3ZDQ2ZDE4YTg2MGY1N2Y2ZmYxZmIzNjFmMzQxMzUyN2Y3YjcxODQ4NTIwNGQ2MWI5ZSJ9fX0=',
            'trail': '',
            'op': 'false',
            'speech': "There will always be people who say mean words because you are different.",
            'powers': array(
                "/buff",
                "/jump 0-3",
                "/run 0-2",
                "/haste 0-3",
                "/fly",
                "Shoots fireballs with bare hand"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 10 true",
                "/effect ". @plr ." 11 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." starbolt"                
            )
        )