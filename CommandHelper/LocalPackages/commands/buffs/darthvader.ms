@plr = player()


@hero = associative_array(
            'name': '§8D§0a§8r§0t§8h V§0ade§8r',
            'class': 'darthvader',
            'sig': 'W0OOLQ3k7K3s1xmKqupTESQahbFlkO31KGwReSc9X9mtvsFoDRTTlS4b5OMhuFZ2sVTo0d4+BWH97OHrVsBw5aggZ6VCzbZfcYw7Ymu220baRBRwtSiJzWjRjGctaKxrLRI5rbl/uX8MHenVunzi6wjN7xxdv/XLYWGNO8dxYU3rxXVzudbvZwmFqYw/0vlfiPmkajJzjL4RrGLiiw+vmr55o0SQrY18af6Bv9rTbTpBX45BScnavYiHFUl4w01wB7wssA44GgSYVLOKknAMuy7UIdFROMVOKIHWV6WcFJ/+Urb80++YSXsYyaP1pRaeJ//tanphDCp11ZZxNDVbawH78Pw+RIJURB1CAGhELP/SZHKDcegGJsaA5/6GPULPBOqQoNcsSzWL/wYz9jwNAOg5X19FXZuLUU5FGrtW3DWGUE0xngN10LFBEtBuuH1Wrp0uYx2VHAecIJcqknfrlmuTAHR/kM/+V88ac6kZL5mqZu64gbaqRDeo0x5DhDR07upi0AI2SpwPdvY9dN4rG24Ieec9CXZT5/4WhoY/xnprlAyVZL4vVFAG9eyg5/vRjo/wi71FjoSsqniqV00KsFVXcYQZ+/uoXliPxzevghYxXUonfvJSMe9Y+ioRrwib7uhCsXXBvb0+U+0trmI2yoTx8hc9CsmNa7Cb6/jq8XA=',
            'val': 'eyJ0aW1lc3RhbXAiOjE0NjQ3NjI2OTQwOTIsInByb2ZpbGVJZCI6Ijg3ZmIzYzZjNWZmNjRiZjZiMzI2OTkyYzYxMzdlYTEyIiwicHJvZmlsZU5hbWUiOiJUZWt0cm9uaWMiLCJzaWduYXR1cmVSZXF1aXJlZCI6dHJ1ZSwidGV4dHVyZXMiOnsiU0tJTiI6eyJ1cmwiOiJodHRwOi8vdGV4dHVyZXMubWluZWNyYWZ0Lm5ldC90ZXh0dXJlLzU5OTQyOTQ0OGFiY2FmNzgxNWZiYTcxYmEyZWE5M2NkNTYzMjI5OTg0ZGVlNjdjNWE1MmQwYmJhNjY1MWUifX19',
            'trail': '',
            'op': 'false',
            'speech': "Come to the dark side.",
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
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/give ". @plr ." minecraft:iron_sword 1 20:2 16:100 name:&8D&0a&8r&0t&8h_V&0ade&8r's_&4Lightsaber",
                "/shot give ". @plr ." forcelightning"                
            )
        )