
PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player, buoyancy)
    self.player = player
    self.buoyancy = buoyancy

    self.player.texture= "t-diver-up"
    if self.player.state == 2 then
        self.player.texture = "r-diver-up"
    end

    self.player.width = gTextures['t-diver-up']:getWidth()
    self.player.height = gTextures['t-diver-up']:getHeight()

end

function PlayerIdleState:update(dt)

    if self.player.state == 2 then
        self.player.texture = "r-diver-up"
    else
        self.player.texture = "t-diver-up"
    end    

    if self.player.y <= TOP_OF_WATER then
        self.player.dy = self.buoyancy + (TOP_OF_WATER-self.player.y)*5
    else
        self.player.dy = self.buoyancy
    end
    self.player.y = self.player.y + (self.player.dy * dt)

    if love.keyboard.isDown('s') then
        self.player:changeState('swim-down')
    end

    if love.keyboard.isDown('a') or love.keyboard.isDown('d') or love.keyboard.isDown('w') then
        self.player:changeState('swim-up')
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