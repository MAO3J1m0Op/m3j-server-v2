execute as @a[scores={IsSlimeChunk=1}] run function slime_chunk_finder:in_slime_chunk
execute as @a[scores={IsSlimeChunk=1}] if score @s in_slime_chunk matches 1 run title @s actionbar {"text":"You are in a slime chunk.","color":"green","bold":true}
execute as @a[scores={IsSlimeChunk=1}] if score @s in_slime_chunk matches 0 run title @s actionbar {"text":"You are in not a slime chunk.","color":"dark_red","bold":true} 

# Resets trigger
execute as @a[scores={IsSlimeChunk=1}] run scoreboard players set @s IsSlimeChunk 0