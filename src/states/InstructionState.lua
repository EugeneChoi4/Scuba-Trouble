InstructionState = Class{__includes = BaseState}

function InstructionState:init()

end

function InstructionState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateMachine:change('startlevel', {level=1})
        gSounds['select']:play()
        gSounds['menu']:stop()
    end
end

function InstructionState:render()
    love.graphics.draw(gTextures['instruction'], 0, -50, 0, 1.15, 1.1)

    love.graphics.draw(gTextures['wasd'], 70, 120, 0, .6, .6)

    love.graphics.draw(gTextures['j'], VIRTUAL_WIDTH/2+80, 120,0, .6, .6)
    love.graphics.draw(gTextures['t-diver-up'], VIRTUAL_WIDTH/2-5, 180,0, .8, .8)
    love.graphics.draw(gTextures['arrow'], VIRTUAL_WIDTH/2+70, 160,0, .3, .3)
    love.graphics.draw(gTextures['r-diver-up'], VIRTUAL_WIDTH/2+135, 180,0, .8, .8)

    love.graphics.draw(gTextures['t-diver-up'], 80, 290,0, .8, .8)
    love.graphics.draw(gTextures['bag'], 170, 290,0, .9, .9)
    love.graphics.draw(gTextures['r-diver-up'], 80, 360,0, .8, .8)
    love.graphics.draw(gTextures['bag'], 170, 360,0, .9, .9)
    love.graphics.draw(gTextures['x'], 75, 340,0, 1.4, 1.2)

    love.graphics.draw(gTextures['r-diver-up-h'], VIRTUAL_WIDTH/2+70, 310,0, .8, .8)
    love.graphics.draw(gTextures['lives'], gLives[3], VIRTUAL_WIDTH/2+70, 370,0, .7, .7)

    love.graphics.setFont(gFonts['title'])
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('INSTRUCTIONS', 1, 6, VIRTUAL_WIDTH, 'center')
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf('INSTRUCTIONS', 0, 5, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['text'])
    love.graphics.printf('Use the WASD keys to move the character.', 250, 120, VIRTUAL_WIDTH/5)
    love.graphics.printf('Press the J key to switch between the two forms.', VIRTUAL_WIDTH/2+240, 120, VIRTUAL_WIDTH/5)
    love.graphics.printf('In your gray form, you may only pick up non-recyclable garbage. In your green form, you may only pick up recyclable objects.', 250, 260, VIRTUAL_WIDTH/4)
    love.graphics.printf("If you pick up an object while not in the corret form, you will lose one out of your 4 lives. At 0 lives, it's game over!", VIRTUAL_WIDTH/2+200, 280, VIRTUAL_WIDTH/4)

    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.printf('You have 2 minutes to pick up all the trash for level 1. Press SPACE to begin.', 0, 480, VIRTUAL_WIDTH, 'center')
end