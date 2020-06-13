scoreboard players enable @a toggleAFK
# 0: not AFK, handled
# 1: just toggled on AFK
# -3: AFK, handled
# -2: just toggled off AFK
execute as @a[scores={toggleAFK=1}] run function afk_tracker:trigger/enable_afk
execute as @a[scores={toggleAFK=-2}] run function afk_tracker:trigger/disable_afk
