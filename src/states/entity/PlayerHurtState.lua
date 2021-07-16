
PlayerHurtState = Class{__includes = BaseState}

function PlayerHurtState:init(player, buoyancy)
    self.player = player
    self.buoyancy = buoyancy

    self.texture = "t-diver-up"
    self.player.texture= "t-diver-up-h"
    if self.player.state == 2 then
        self.player.texture = "r-diver-up-h"
        self.texture = "r-diver-up"
    end

    self.player.width = gTextures['t-diver-up']:getWidth()
    self.player.height = gTextures['t-diver-up']:getHeight()

    self.timer = 0

end

function PlayerHurtState:update(dt)

    self.timer = self.timer + dt
    self.player.y = self.player.y + (self.buoyancy * dt)
    if self.timer > .25 then
        self.player.texture = self.texture
    end

    if self.timer > .50 then
        self.player.texture = self.texture .. "-h"
    end
    if self.timer > .75 then
        self.player.texture = self.texture 
    end
    if self.timer > 1 then
        self.player.texture = self.texture .. "-h"
    end
    if self.timer > 1.25 then
        self.player:changeState('idle')
    end

    

end