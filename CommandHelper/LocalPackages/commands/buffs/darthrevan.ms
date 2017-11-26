@plr = player()




@hero = associative_array(
            'name': '§8D§4a§8rth §4R§8ev§4a§8n',
            'class': 'darthrevan',
            'sig': 'PSsKgrLMcuMvOxMCVlLsUxL2DTinT9O0d6Yu3mczIjHzsvzVo+m5wiq44vqJbQc5DojLfbip+DrtdnLl99JKcStE68+02/tb7LFeY04+YawHD7PUr+FHkqAfrDW52zbnQ5GkctCo0hc+OzDwzlz1/0kuxVmBy52gbjAZRvbaUpsu/eaBfWmWyutggX9xb1ypwmwqQIofiSfEx8GIHH+KO/otfwNxU9ianaKfFqJZGgynh32GmavrJTfkJBNHsJkB3MBaXPx5MZFaNSLNqssbIFbDV8W9L9ISbGo8CadtS35ZqrqWy6RlmdVcfsPldfHWHATNo5OFIXu8+pRikQqRWHWTXLrJiIqg0FA1Ini2fdBaevXm0lpay6JA6MgWB47Q09Ujh7k5P9tfeJAi9imtmIINRVuI5lfiR7nosJKnZA+SGLe9XHMLwpZiaSyxw2ipTCGTfA97PWVZ3enG2I5Tv8WBLnuYOEBv4n7+KmUqL4XTj3D3+dssezp09pRRa0yDI7pNKsve1dmEKe+OiOE2EAI4b7Fm+Lstojb4f1OeujGOTav5ZHxprhOl3TimjXzKX8AhfTSWTe4Dokw6QAw4HfcXHdzIXKsp2gZLOtaOYmV5im3ROCO+aJ8gCO/G+w4H9yM0rtxTOcHL2xx21icRRdDEZySilmYRPjcUCEL0kZM=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NzY2NDE4NjYxMDYsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzcyY2Q1NzU0MGMxMzMyZjNhYzNjOGM2ZmNmOTdkYzlmOWM2ZDQ3NWFhOTIyMTliOWZjMGRjZTdkZGI4ZDFiIn19fQ==',
            'trail': '',
            'op': 'false',
            'speech': "I will be reborn!",
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
                "/effect ". @plr ." 5 9999 5 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:iron_sword 1 20:2 16:100 name:&8D&4a&8rth_&4R&8ev&4a&8n's_&4Lightsaber",
                "/shot give ". @plr ." forcelightning"                
            )
        )