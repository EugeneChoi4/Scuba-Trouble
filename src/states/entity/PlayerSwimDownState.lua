PlayerSwimDownState = Class{__includes = BaseState}

function PlayerSwimDownState:init(player, buoyancy)
    self.buoyancy = buoyancy
    self.player = player
    self.player.texture= "t-diver-down"
    if self.player.state == 2 then
        self.player.texture = "r-diver-down"
    end
    
    self.player.width = gTextures['t-diver-down']:getWidth()
    self.player.height = gTextures['t-diver-down']:getHeight()
end

function PlayerSwimDownState:update(dt)

    if self.player.state == 2 then
        self.player.texture = "r-diver-down"
    else
        self.player.texture = "t-diver-down"
    end    

    if self.player.y >= MAP_HEIGHT-self.player.height then
        self.player.y = MAP_HEIGHT-self.player.height
    else
        self.player.dy = self.buoyancy + PLAYER_SWIM_DOWN_SPEED
        self.player.y = self.player.y + (self.player.dy * dt)
    end

    if not love.keyboard.isDown('s') then
        if love.keyboard.isDown('a') or love.keyboard.isDown('d') or love.keyboard.isDown('w') then
            self.player:changeState('swim-up')
        else
            self.player:changeState('idle')
        end
    else
        if love.keyboard.isDown('a') then
            self.player.x = self.player.x - PLAYER_SWIM_SPEED * dt
            self.player.direction = 'left'
        elseif love.keyboard.isDown('d') then
            self.player.x = self.player.x + PLAYER_SWIM_SPEED * dt
            self.player.direction = 'right'
        end
    end

    for k, object in pairs(self.player.level.objects) do
        if object:collides(self.player) then
            object.onCollide(object, self.player)
            if object.solid then
                self.player.y = object.y + object.height
                self.player.dy = 0
            elseif object.consumable then
                object.onConsume(self.player, object)
                table.remove(self.player.level.objects, k)
            end
        end
    end

end