-- A basic encounter script skeleton you can copy and modify for your own creations.

-- music = "shine_on_you_crazy_diamond" --Either OGG or WAV. Extension is added automatically. Uncomment for custom music.
encountertext = "In my way. =)" --Modify as necessary. It will only be read out in the action select screen.
nextwaves = {"bullettest_chaserorb"}
wavetimer = 4.0
arenasize = {155, 130}
autolinebreak = true

enemies = {
"poseur"
}

enemypositions = {
{0, 0}
}

-- A custom list with attacks to choose from. Actual selection happens in EnemyDialogueEnding(). Put here in case you want to use it.
possible_attacks = {"attack1"}

function EncounterStarting()
    -- If you want to change the game state immediately, this is the place.
    Inventory.AddCustomItems({"Bandage","Butterscotch Pie","Cinnamon Bunny","Glamburger"},{0,0,0,0})
    Inventory.SetInventory({"Butterscotch Pie","Cinnamon Bunny","Cinnamon Bunny","Cinnamon Bunny","Glamburger","Glamburger","Glamburger","Bandage"})
end

function EnemyDialogueStarting()
    -- Good location for setting monster dialogue depending on how the battle is going.
end

function EnemyDialogueEnding()
    -- Good location to fill the 'nextwaves' table with the attacks you want to have simultaneously.
    nextwaves = { possible_attacks[math.random(#possible_attacks)] }
end

function DefenseEnding() --This built-in function fires after the defense round ends.
    encountertext = RandomEncounterText() --This built-in function gets a random encounter text from a random enemy.
end

function HandleSpare()
    State("ENEMYDIALOGUE")
end

function HandleItem(ItemID)
   if ItemID == "BANDAGE" then
    Player.Heal(10)
    BattleDialog({"You applied [color:ffff00]Dirty Bandage[color:ffffff].","You restored[color:ffff00] 10 HP[color:ffffff]."})
   elseif ItemID == "BUTTERSCOTCH PIE" then
    Player.Heal(10)
    BattleDialog({"You ate [color:ffff00]Butterscotch Pie[color:ffffff].","[color:ffffff]Your[color:ffff00] Hp[color:ffffff] has been fully restored."})
    elseif ItemID == "CINNAMON BUNNY" then
        Player.Heal(22)
        BattleDialog({"You ate [color:ffff00]Cinnamon Bunny[color:ffffff].","You restored[color:ffff00] 22 HP[color:ffffff]."})
    elseif ItemID == "GLAMBURGER" then
        Player.Heal(27)
        BattleDialog({"You ate [color:ffff00]Glamburger[color:ffffff].","You restored[color:ffff00] 27 HP[color:ffffff]."})

   end
end