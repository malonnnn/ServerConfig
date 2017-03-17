proc(_getVial, @plr, @class
    
    include('/home/minecraft/server/plugins/CommandHelper/includes/getHeroInfo.ms')
    @vialName = _getHeroInfo(@class)." &e&lD&a&lN&4&lA"
    
    # Replace spaces with underscores in name in prep for item spawn
    @vialName = replace(@vialName,' ','_')
    
    runas(~console,/give @plr "minecraft:potion 1 0 effect:nausea power:1 duration:1200 effect:poison power:1 duration:1200 name:@vialName lore:@class")
)