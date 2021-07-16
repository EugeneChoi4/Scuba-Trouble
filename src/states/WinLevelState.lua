WinLevelState = Class{__includes = BaseState}

function WinLevelState:init()
    gSounds['gameplay']:stop()
    gSounds['winlevel']:play()
end

function WinLevelState:enter(params)
    self.level = params.level
end

function WinLevelState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('startlevel', {level=self.level+1})
        gSounds['select']:play()
    end
end

function WinLevelState:render()
    love.graphics.draw(gTextures['background-end'], 0, 0)
    love.graphics.draw(gTextures['background-end'], VIRTUAL_HEIGHT, 0)


    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('YOU BEAT LEVEL '..tostring(self.level)..'!', 1, VIRTUAL_HEIGHT / 2 - 50 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('YOU BEAT LEVEL '..tostring(self.level)..'!', 0, VIRTUAL_HEIGHT / 2 - 50, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['subtitle'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press SPACE To Go To Level '..tostring(self.level+1), 1, VIRTUAL_HEIGHT / 2 + 31, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press SPACE To Go To Level '..tostring(self.level+1), 0, VIRTUAL_HEIGHT / 2 + 30, VIRTUAL_WIDTH, 'center')
end