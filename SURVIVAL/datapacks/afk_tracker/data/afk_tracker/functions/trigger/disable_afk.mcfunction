# 0: not AFK, handled
# 1: just toggled on AFK
# -3: AFK, handled
# -2: just toggled off AFK
tellraw @a [{"selector":"@s","color":"dark_purple"},{"text":" is no longer AFK","color":"dark_purple"}]
scoreboard players set @s toggleAFK 0
team leave @s
