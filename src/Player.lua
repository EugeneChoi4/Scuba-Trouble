Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.score = 0
    self.state = 1 --1 == trash, 2 == recycle
    self.lives = def.lives
end

function Player:update(dt)

    if love.keyboard.wasPressed('j') then
        gSounds['transform']:play()
        if self.state == 1 then
            self.state = 2
        else
            self.state = 1
        end
    end
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
end


function Player:checkObjectCollisions()
    local collidedObjects = {}

    for k, object in pairs(self.level.objects) do
        if object:collides(self) then
            if object.consumable then
                object.onConsume(self)
                table.remove(self.level.objects, k)
            end
        end
    end

    return collidedObjects
end