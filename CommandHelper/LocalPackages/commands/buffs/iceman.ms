@plr = player() 
 
 
 
 
 @hero = associative_array( 
             'name': '§bIce§1man', 
             'class': 'iceman', 
             'sig': 'fdyVJG+ms9b9Ukvk8C9aVXGIEVAbcx5PiMgK35vTGYCi8oZP7OzdAdR2yN74Mujtuq4N1kmtRnz5YOiudVhE11QxqhqPGVqN38Gpwa6mcPOT4VydWdet7/YrLcT4+/vuFJ9MiC0fMVzyeySCm0SnhPSBUiAjZAgC5gJTtw7MZ4Z/eHL5108/zGgbdTM9xXlUIgoGX5oB7R5A6cq5t8ZdtiVPedvwWiUfHb+8CwVUgQ9PnJa5XkFxZN6UjUY+wuuj9t1y44ra9YlZmMor+NBuP2YEbW4juSN3jv3gpeVfTu9ObUJUQg31lp1tcmC+P1bJdCaIDrr3ilS4PkxSse2gv6NgYLZbJOf69F074Q65pRmiZXfr9YQ1qSyJvzcfNr70mDgr/vXUiNjUk/51vyzS2wRWBjSHJlpAMCKoVrnMg7FwK/V0uCNK0OrR43wy196kNa3V60QgRIQdKFbOpE00xiwa2RKrNSBlvMgRjw2a4apoWo7XkyerZmavVVg/X7lCiyV3VYXOqtt1oCXf+MM43tgLxR29SqZMUrX9Hb1lDqnG5iTRIDCagPVvWEyKn63oeTMigy6i1Z+Wu5Um3ngbQSA83jQB6Z9c2VQHgaBbBKJ6Ef4W5s/5gJ7SGQyWdpaHRYDpwINXGwhFFXGX5h/ew2D8VzMDg67N3sKrYfMluVc=', 
             'val': 'eyJ0aW1lc3RhbXAiOjE0OTExNDU3OTMzMTUsInByb2ZpbGVJZCI6ImY2MjE1ODZlOGVmODQ0OGQ5MjY0ODZiNjEzNzUwNTJlIiwicHJvZmlsZU5hbWUiOiJteXRoZ3V5MTIyNiIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvM2IyYWMwM2JkNzhlMmQ4MGZkNWVlY2MzY2Q0MzJkOTg4YmYzM2M3NTgxOGRjZjA1YTU5NDJiZDRkZGFlY2U0In19fQ==', 
             'trail': '', 
             'op': 'false', 
             'speech': "Chill out!", 
             'powers': array( 
                 "/buff",  
                 "/run 0-2" 
             ), 
             'buffs': array( 
                 "/effect ". @plr ." 5 9999 2 true", 
                 "/effect ". @plr ." 21 9999 9 true",  
                 "/shot give ". @plr ." icespike",
                 "/give ". @plr ." minecraft:elytra 1 70:1 34:3 name:&bIce_Glide"
             ) 
         ) 
