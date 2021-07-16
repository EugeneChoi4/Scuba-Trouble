PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.camX = 0
    self.camY = 0
    
    self.backgroundX = 0
    self.backgroundY = 0
    self.quality = 1
    self.time = 121

    gSounds['gameplay']:setLooping(true)
    gSounds['gameplay']:setVolume(0.5)
    gSounds['gameplay']:play()


end

function PlayState:enter(params)
    self.levelnum = params.level
    self.level = params.map
    self.totalTrash = #self.level.objects
    self.scoreincr = math.floor(self.totalTrash/4)
    self.buoyancyAmount = -30

    self.player = Player({
        x = 0, y = TOP_OF_WATER,
        texture = 't-diver-up',
        width = gTextures['t-diver-up']:getWidth(), 
        height = gTextures['t-diver-up']:getHeight(),
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player, self.buoyancyAmount) end,
            ['swim-up'] = function() return PlayerSwimUpState(self.player, self.buoyancyAmount) end,
            ['swim-down'] = function() return PlayerSwimDownState(self.player, self.buoyancyAmount) end,
            ['hurt'] = function() return PlayerHurtState(self.player, self.buoyancyAmount) end,
        },
        level = self.level,
        direction = 'right',
        lives = 4

    })

    self:spawnFish()
    self.player:changeState('idle')

end

function PlayState:update(dt)

    if #self.level.objects <= 0 then
        if self.levelnum >= 3 then
            gStateMachine:change('win')
        else
            gStateMachine:change('winlevel', {level=self.levelnum})
        end
    end 

    self.time = self.time-dt
    if self.time <0 then
        gStateMachine:change('gameover')
    end

    self.level:clear()

    self.player:update(dt)
    self.level:update(dt)

    -- constrain player X no matter which state
    if self.player.x <= 0 then
        self.player.x = 0
    elseif self.player.x > MAP_WIDTH then
        self.player.x = MAP_WIDTH
    end

    self:updateCamera()

    if self.totalTrash - #self.level.objects >= self.scoreincr*self.quality then
        self.quality = self.quality + 1
        self:spawnFish()
    end

end

function PlayState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['background' .. tostring(self.quality)], math.floor(-self.backgroundX), math.floor(-self.backgroundY))
    love.graphics.draw(gTextures['background' .. tostring(self.quality)], MAP_HEIGHT+math.floor(-self.backgroundX), math.floor(-self.backgroundY))
    love.graphics.draw(gTextures['background' .. tostring(self.quality)], MAP_HEIGHT*2+math.floor(-self.backgroundX), math.floor(-self.backgroundY))

    -- translate the entire view of the scene to emulate camera
    love.graphics.translate(-math.floor(self.camX), -math.floor(self.camY))
    
    self.level:render()

    self.player:render()
    love.graphics.pop() 
    
    -- render score
    love.graphics.setFont(gFonts['subtitle'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print("Trash Remaining: ", 10, 5)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Trash Remaining: ", 9, 4)

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(tostring(#self.level.objects), 305, 5)
    love.graphics.setColor(252, 186, 3, 255)
    love.graphics.print(tostring(#self.level.objects), 304, 4)

    --render time
    local tmin = tostring(math.floor(self.time/60))
    local tsec = tostring(math.floor(self.time%60))
    if #tsec == 1 then
        tsec = "0"..tsec
    end

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print("Time: ", 10, 70)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.print("Time: ", 9, 69)

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(tmin..":"..tsec, 110, 70)
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.print(tmin..":"..tsec, 109, 69)
    love.graphics.setColor(255, 255, 255, 255)

    self:renderLives(self.player.lives)
end

function PlayState:updateCamera()
    -- clamp movement of the camera's X between 0 and the map bounds - virtual width,
    -- setting it half the screen to the left of the player so they are in the center
    self.camX = math.max(0,
        math.min(MAP_WIDTH - VIRTUAL_WIDTH,
        self.player.x+self.player.width - (VIRTUAL_WIDTH / 2)))
    
    self.camY = math.max(0,
        math.min(MAP_HEIGHT - VIRTUAL_HEIGHT,
        self.player.y+self.player.height - (VIRTUAL_HEIGHT / 2)))

    self.backgroundY = (self.camY) % MAP_HEIGHT
    self.backgroundX = (self.camX / 2) % MAP_HEIGHT

end

function PlayState:spawnFish()

    
    for x_i = 1, MAP_WIDTH, TILE_SIZE do

        for y_i = TOP_OF_WATER+50, MAP_HEIGHT-100, TILE_SIZE do

            if math.random(100) == 1 then

                local type = 'fish' .. tostring(math.random(1,6))
                local dir = math.random(2)
                local fish
                fish = Fish {
                    texture = type,
                    x = x_i,
                    y = y_i,
                    width = gTextures[type]:getWidth(),
                    height = gTextures[type]:getHeight(),
                    direction = dir == 1 and 'left' or 'right'
                }
                table.insert(self.level.entities, fish)
                fish:render()
            end
        end
    end 
end

function PlayState:renderLives(lives)
    local livesX = VIRTUAL_WIDTH - 140
    
    love.graphics.draw(gTextures['lives'], gLives[lives], livesX, 20)
    
end