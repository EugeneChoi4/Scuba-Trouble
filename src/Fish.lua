
Fish = Class{__includes = Entity}

function Fish:init(def)
    Entity.init(self, def)

    self.movingDuration = math.random(10, 15)
    self.direction = math.random(2) == 1 and 'left' or 'right'
    self.movingTimer = 0
end

function Fish:update(dt)
    self.movingTimer = self.movingTimer + dt

    -- reset movement direction and timer if timer is above duration
    if self.movingTimer > self.movingDuration then

        self.direction = math.random(2) == 1 and 'left' or 'right'
        self.movingDuration = math.random(10, 15)
        self.movingTimer = 0

    elseif self.direction == 'left' then
        self.x = self.x - FISH_SPEED * dt
        
        if self.x <= -50 then
            self.x = self.x + FISH_SPEED * dt

            self.direction = 'right'
            self.movingDuration = math.random(10, 15)
            self.movingTimer = 0
        end
    else
        self.direction = 'right'
        self.x = self.x + FISH_SPEED * dt

        if self.x >= MAP_WIDTH + 50 then
            self.x = self.x - FISH_SPEED * dt

            self.direction = 'left'
            self.movingDuration = math.random(10, 15)
            self.movingTimer = 0
        end
    end
end


function Fish:render()
    love.graphics.draw(gTextures[self.texture],
        math.floor(self.x) + 8, math.floor(self.y) + 8, 0, self.direction == 'right' and 1 or -1, 1, 8, 10)
end