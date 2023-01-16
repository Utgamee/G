-- A basic monster script skeleton you can copy and modify for your own creations.
comments = {"Wind is howling.", "Gladin is preparing his attack.",}
commands = {"Reason", "Taunt", "Search"}
randomdialogue = {"..."}

sprite = "poseur" --Always PNG. Extension is added automatically.
name = "Gladin"
hp = 200
atk = 1
def = 1
gold = 100
xp = 100
check = "His eyes are focused on you."
dialogbubble = "rightlarge" -- See documentation for what bubbles you have available.
canspare = false
cancheck = true

Reasoncounter = 0
Tauntcounter = 0
Searchcounter = 0

-- Happens after the slash animation but before 
function HandleAttack(attackstatus)
    if attackstatus == -1 then
        -- player pressed fight but didn't press Z afterwards
    else
        -- player did actually attack
    end
end
 
-- This handles the commands; all-caps versions of the commands list you have above.
function HandleCustomCommand(command)
    if command == "REASON" then
        if Reasoncounter == 0 then
            currentdialogue =({"Huh?"})
            BattleDialog({"You told Gladin that there is no reason to fight."})
        elseif Reasoncounter == 1 then 
        canspare = true
        currentdialogue = ({"Ugh, fine you can go i guess."})
        BattleDialog({"You asked Gladin if you can go."})
        else
            currentdialogue = ({"Just go."})
            BattleDialog({"You tried to reason with Gladin again..."})
        end
        Reasoncounter = Reasoncounter + 1
    elseif command == "TAUNT" then
        if Tauntcounter == 0 then
        currentdialogue = ({"Excuse me?"})
        atk = 10
        BattleDialog({"You insulted Glaidn's way of fight","He's ATK rose."})
        elseif Tauntcounter == 1 then
            currentdialogue = ({"Ugh..."})
            atk = 25
        BattleDialog({"You made fun of Gladin's look.","He's ATK rose."})
        else 
            currentdialogue = ({"..."})
            BattleDialog({"Seems you ran out of taunting options."})
        end
        Tauntcounter = Tauntcounter + 1
    elseif command == "SEARCH" then
        if Searchcounter == 0 then
            currentdialogue =({"..."})
            BattleDialog({"You looked around battlefield...","Found nothing."})
        elseif Searchcounter == 1 then 
        currentdialogue = ({"..."})
        BattleDialog({"You looked around battlefield again...","You found bandage!"})
    else 
        currentdialogue = ({"..."})
        BattleDialog({"You looked around battlefield again...","Seems there is nothing left..."})
    end
    Searchcounter = Searchcounter + 1

    end
end