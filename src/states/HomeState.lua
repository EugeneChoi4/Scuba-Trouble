HomeState = Class{__includes = BaseState}

function HomeState:init()

end

function HomeState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('instruction')
        gSounds['select']:play()
    end
end

function HomeState:render()
    love.graphics.draw(gTextures['background-home'], 0, 0)
    love.graphics.draw(gTextures['background-home'], VIRTUAL_HEIGHT, 0)

    --love.graphics.setColor(252, 179, 101, 200)
    --love.graphics.rectangle("fill", VIRTUAL_WIDTH/2-250, VIRTUAL_HEIGHT/2-100, 500, 250)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.draw(gTextures['t-diver-up'], VIRTUAL_WIDTH/2-gTextures['t-diver-up']:getWidth(), 350,0, .8, .8)
    love.graphics.draw(gTextures['r-diver-up'], VIRTUAL_WIDTH/2+gTextures['t-diver-up']:getWidth(), 350,0, -.8, .8)

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Scuba Trouble', 1, VIRTUAL_HEIGHT / 2 - 80 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Scuba Trouble', 0, VIRTUAL_HEIGHT / 2 - 80, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['subtitle'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('Press SPACE To Start', 1, VIRTUAL_HEIGHT / 2 + 1, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('Press SPACE To Start', 0, VIRTUAL_HEIGHT / 2, VIRTUAL_WIDTH, 'center')

    
end