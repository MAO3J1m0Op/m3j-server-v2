# 0: not AFK, handled
# 1: just toggled on AFK
# -3: AFK, handled
# -2: just toggled off AFK
tellraw @a [{"selector":"@s","color":"dark_purple"},{"text":" is now AFK","color":"dark_purple"}]
scoreboard players set @s toggleAFK -3
team join AFK @s
