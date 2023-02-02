bigspawntimer = 0 --A simple spawn timer thingy.
bigbulletspawn = 35 --The time it takes before spawning the big bullets.

bigbulletsplitmin = 70 --Min time (In frames I think???) that large bullets can take before splitting
bigbulletsplitmax = 130 --And the max time that large bullets will take to split

bigbulletfall = -2 --Speed of large bullets
smallbulletcount = 8 --How many bullets the large ones will split into.
smallbulletsplodespeed = 2.5 --Speed of small bullets

Arena.resize(180, 180) --Make the arena big because a small one with this attack is stupid and if you even consider it please reconsider.

bigbullets = {} --Big bullet array
bullets = {} --Small bullet array

function Update() --If-you-don't-know-what-this-does-then-please-look-at-the-documentation-for-christ-sake
	bigspawntimer = bigspawntimer + 1 --Counts up by 1 every frame.
	if bigspawntimer%bigbulletspawn == 0 then --If the remainder of bigspawntimer divided by bigbulletspawn is 0, continue.
		local posx = math.random(-Arena.width/2,Arena.width/2) --Randomly selects a position from the left of the arena alllll the way to the right.
		local posy = Arena.height/2 + math.random(30,80) --Gets a position 30 - 80 pixels above the top of the arena.
		local bullet = CreateProjectile("bullet",posx,posy) --Refer to comment on line 16
		bullet.SetVar('vely', bigbulletfall) --Set's a variable for the y velocity
		bullet.SetVar('velx',0) --We don't need x velocity in this example but you could technically make [SPOILER]'s Star Blazing attack with this.
		bullet.SetVar('livetime', 0) --A little variable to see how long the thing has been alive
		bullet.SetVar('splittime', math.random(bigbulletsplitmin, bigbulletsplitmax)) --Max alive time before splitting
		table.insert(bigbullets,bullet) --Refer to comment on line 16
	end
	
	for i=1, #bigbullets do --For every single bullet in the bigbullets array, execute this code.
		local bullet = bigbullets[i] --Gets the bullet from the bigbullets array with the id of [i]
		local livetime = bullet.GetVar('livetime')+1 --Lifetime counter.
        local velx = bullet.GetVar('velx') --Gets the x velocity we set.
        local vely = bullet.GetVar('vely') --Gets the y velocity we set.
		
        local newposx = bullet.x + velx --The new x position of the bullet will be the current x position + the x velocity. Useless because velx = 0 but you could use it if you want.
        local newposy = bullet.y + vely --Same but for the y value lol.
		
		bullet.SetVar('livetime', livetime) --Set the current lifetime to what we made it above, so we can get it again later. This is useful for making every bullet not explode at once.
		if livetime == bullet.GetVar('splittime') then --This is for when the bullet's reached the max lifetime it was set.
			for i = 1, smallbulletcount do --All credit to EmeliaK for this code.
				local bullet = CreateProjectile('bullet',bullet.x, bullet.y) --Create a bullet at the position of the big bullet.
				local angle = ((2*math.pi)/smallbulletcount) * i  --Some radian stuff or w/e I dunno ask EmeliaK.
				bullet.SetVar('velx', smallbulletsplodespeed*math.cos(angle)) --Set the x velocity of the small bullet based on the angle and how many bullets we're spawning.
				bullet.SetVar('vely', smallbulletsplodespeed*math.sin(angle)) --Same but for the y velocity.
				table.insert(bullets,bullet) --Handle the bullets in a seperate list, or we'll have them infinitely exploding, which is dumb.
			end
			newposx = 650 --Kills the bullet.
		end
		
		bullet.MoveTo(newposx, newposy) --Move the bullet to the new positions we set above. Will also kill the bullet if needed since bullets despawn when they go off screen.
	end
	
	for i=1, #bullets do --If you don't understand this code below please stop.
		local bullet = bullets[i]
        local velx = bullet.GetVar('velx')
        local vely = bullet.GetVar('vely')
        local newposx = bullet.x + velx
        local newposy = bullet.y + vely
        bullet.MoveTo(newposx, newposy)
	end
end