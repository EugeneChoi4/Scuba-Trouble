GameOverState = Class{__includes = BaseState}

function GameOverState:init()
    gSounds['gameplay']:stop()
    gSounds['gameover']:play()
    self.time = 0
    self.style = 'r-diver-up'
end

function GameOverState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('startlevel', {level=1})
        gSounds['select']:play()
    end
    self.time = self.time + dt
    if self.time > .50 then
        self.time = 0
        self.style = self.style=='r-diver-up' and 'r-diver-up-h' or 'r-diver-up'
    end
end

function GameOverState:render()
    love.graphics.draw(gTextures['death'], 0, 0, 0, 1.6, 1.5)
    love.graphics.draw(gTextures[self.style], VIRTUAL_WIDTH/2-gTextures[self.style]:getWidth()*1.2/2, 400, 0, 1.2,1.2)
    

    love.graphics.setFont(gFonts['death'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('GAME OVER', 1, VIRTUAL_HEIGHT / 2 - 120 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('GAME OVER', 0, VIRTUAL_HEIGHT / 2 - 120, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['subtitle'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press SPACE To Restart', 1, VIRTUAL_HEIGHT / 2 + 31, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press SPACE To Restart', 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
end