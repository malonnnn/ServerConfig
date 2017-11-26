@plr = player()


@hero = associative_array(
            'name': '§2Gr§8e§2en Lant§8e§2rn§8(S)',
            'class': 'greenlanternsinestro',
            'sig': 'vswkh55KoKiO6LQpjwflzUfQ/IOojqxoupClSGW5BF35otJzYbOjGOi+xpNFEoyPLeReAdNK6I3xuUUNRaNQSnLVDc0b1ei+8fAax04faK1qYRV9It4CdDVFh6VsjvRB4OEh7Hcobn1p+0Ba0zEGOZutp4dy8+D0T7FdwLyspZCOTW8l9WPNG2hUTjeaH1QIEhXS24eTrUuMlvnScPDKlY7OTyGOugMhGNRhGvIQJHmclRw4Fkfb2SzYnugrVvutQsBT942D+FbzyBdV+7wMjekErOVNSoBALpiw4CIRJYMq9u6lPvdtUV/Eo4enhmCzMhuWiwaC7+tzA/zNlP1J6GVrKi9j5/byWcxwJibrt0BLFa9ZJBR/U58iumBp7jtJvvbwVX6WaTZxh4+rVzxALYGA2JLwszczuoiO6M5hRuq57u0j3cUqiZRJlrrAqoBX+WPBBLBiFvwDs8sWoZ0RhaxN4UxVm/HXjhpRsrQk1UsADrzhgiDD+nPYaeHLlQygGO4LUWSypa6yhb3tUHxjhDmh9RVFh46dbqPc6g07WY+EBhO5EqKD2I8jrwm8cfjpkLqq7Xs+MHEy72vu2OAw8KUZz1gmcIA1kcbjfdu4WwNEB5UJeIRUA9WSWZNzDXqKLqMQALMqji/nHREmrXsKrrtUQR1tHeAObSBve1XATdo=',
            'val': 'eyJ0aW1lc3RhbXAiOjE1MTE2NzY0NjY1MjEsInByb2ZpbGVJZCI6IjgzNTRlZDBkMDljYjQ2ODJiZjYyNWRmM2YwZTJiNDEyIiwicHJvZmlsZU5hbWUiOiJfVmlnaWxhbmNlXyIsInNpZ25hdHVyZVJlcXVpcmVkIjp0cnVlLCJ0ZXh0dXJlcyI6eyJTS0lOIjp7InVybCI6Imh0dHA6Ly90ZXh0dXJlcy5taW5lY3JhZnQubmV0L3RleHR1cmUvMmMyODI4MmJhNDEzNGVkMjE1NWYwYzhiOWNhNjVkZGM4Y2M2NjE1ODk2ZTcwZjVlY2IyMzMzZmVmNDg5In19fQ==',
            'trail': '',
            'op': 'false',
            'speech': "In the brightest day, in the blackest night, no evil shall escape my sight.",
            'powers': array(
                "/buff",
                "/carryplayer",
                "/dismountplayer",
                "/jump 0-3",
                "/run 0-3",
                "/haste 0-4",
                "/flyspeed <number>",
                "/fly"
            ),
            'buffs': array(
                "/effect ". @plr ." 5 9999 15 true",
                "/effect ". @plr ." 10 9999 1 true",
                "/effect ". @plr ." 21 9999 9 true",
                "/shot give ". @plr ." greenenergybeam",
                "/give ". @plr ." 95:5 64",
                "/give ". @plr ." minecraft:emerald 1 20:2 16:155 name:&2Gr&8e&2en_Lant&8e&2rn_Ring"                
            )
        )
