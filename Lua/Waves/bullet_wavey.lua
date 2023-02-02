spawntimer = 0 --A simple spawn timer thingy.
bullets = {} --An array storing our bullets.
bulletspawn = 7.5 --The time it takes before spawning bullets.

bulletspeed = -3.4 --Set the bullet speed to -3.2 (Moving down at the speed of fast)

randomNumber = math.random(100) --This is a random number out of 100, used as basically a "use this or this?" kinda deal. I made it a number up to 100 so if you want you can have a variety of random effects applied to these bullets.

Arena.resize(115, 115) --Resizes arena to a decent size for a vertical attack.

function Update() --If-you-don't-know-what-this-does-then-please-look-at-the-documentation-for-christ-sake
    spawntimer = spawntimer + 1 --Counts up by 1 every frame.
    if spawntimer%bulletspawn == 0 then --If the remainder of spawntimer divided by bulletspawn is 0, continue.
		local bulletsprite = "bullet" --Sets the sprite the bullet'll use.
		if randomNumber >= 50 then --But if the randomNumber variable is bigger than or equal to 50... 
			bulletsprite = "bullet" --Set it to this sprite instead!
		end
        local posx = math.random(-10,10) --Get a random xPosition between -10 and 10. This seems small but the motion of the bullets makes up for it.
        local posy = ((Arena.height/2) + math.random(3,15))*2 --The tl;dr is it spawns just above the top of the arena.
        local bullet = CreateProjectile(bulletsprite,posx,posy) --Make a bullet with the sprite and x and y positions we just set.
		bullet.SetVar('vely', bulletspeed) --Set the y velocity to what we set earlier.
		if randomNumber >= 50 then --Oh look, it's that thing from earlier!
			bullet.SetVar('velx', math.sin(spawntimer*2)) --All bullets with the sprite "bullet3" will adhere to a sin wave for motion...
		else
			bullet.SetVar('velx', math.cos(spawntimer*2)) --And all with sprite "bullet2" will adhere to a cosin.
		end
        table.insert(bullets,bullet) --Insert our bullet into the table.
    end

	for i=1,#bullets do --For every single bullet in our table array thing.
		local bullet = bullets[i] --Get the bullet from the table with id [i]
        local velx = bullet.GetVar('velx') --Get the x velocity we set it...
        local vely = bullet.GetVar('vely') --And the y velocity we set it.
        local newposx = bullet.x + velx --Apply motion to the xposition based on the x velocity.
        local newposy = bullet.y + vely --Same but for the y axis...
        bullet.MoveTo(newposx, newposy) --Move the bullet to our new position!
	end
end