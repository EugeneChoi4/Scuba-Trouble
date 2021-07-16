PlayerSwimUpState = Class{__includes = BaseState}

function PlayerSwimUpState:init(player, buoyancy)
    self.player = player
    self.buoyancy = buoyancy

    self.player.texture= "t-diver-up"
    if self.player.state == 2 then
        self.player.texture = "r-diver-up"
    end
    
    self.player.width = gTextures['t-diver-up']:getWidth()
    self.player.height = gTextures['t-diver-up']:getHeight()
end

function PlayerSwimUpState:update(dt)
    if self.player.state == 2 then
        self.player.texture = "r-diver-up"
    else
        self.player.texture = "t-diver-up"
    end
    
    
    self.player.dy = self.buoyancy
    if love.keyboard.isDown('w') then
        self.player.dy = self.buoyancy - PLAYER_SWIM_SPEED
    end
    if self.player.y <= TOP_OF_WATER then
        self.player.dy = self.player.dy + (TOP_OF_WATER-self.player.y)*5
    end
    self.player.y = self.player.y + (self.player.dy * dt)


    if love.keyboard.isDown('s') then
        self.player:changeState('swim-down')
    elseif not (love.keyboard.isDown('d') or love.keyboard.isDown('a') or love.keyboard.isDown('w')) then
        self.player:changeState('idle')
    end

    self.player.y = self.player.y + (self.player.dy * dt)

    if love.keyboard.isDown('a') then
        self.player.direction = 'left'
        self.player.x = self.player.x - PLAYER_SWIM_SPEED * dt
    elseif love.keyboard.isDown('d') then
        self.player.direction = 'right'
        self.player.x = self.player.x + PLAYER_SWIM_SPEED * dt
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