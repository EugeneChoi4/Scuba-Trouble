
--
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/StateMachine'
require 'src/states/BaseState'
require 'src/states/PlayState'
require 'src/states/HomeState'
require 'src/states/GameOverState'
require 'src/states/WinState'
require 'src/states/InstructionState'
require 'src/states/WinLevelState'
require 'src/states/StartLevelState'

require 'src/states/entity/PlayerIdleState'
require 'src/states/entity/PlayerSwimUpState'
require 'src/states/entity/PlayerSwimDownState'
require 'src/states/entity/PlayerHurtState'

require 'src/Entity'
require 'src/GameObject'
require 'src/GameLevel'
require 'src/LevelMaker'
require 'src/Player'
require 'src/Fish'

function GenerateQuads(atlas, tilewidth, tileheight)
    local sheetWidth = atlas:getWidth() / tilewidth
    local sheetHeight = atlas:getHeight() / tileheight

    local sheetCounter = 1
    local spritesheet = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            spritesheet[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, atlas:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return spritesheet
end

gSounds = {
    ['hurt'] = love.audio.newSource('sounds/hurt.wav'),
    ['gameover'] = love.audio.newSource('sounds/gameover.wav'),
    ['gameplay'] = love.audio.newSource('sounds/gameplay.mp3'),
    ['winlevel'] = love.audio.newSource('sounds/winlevel.wav'),
    ['pickup'] = love.audio.newSource('sounds/pickup.wav'),
    ['win'] = love.audio.newSource('sounds/win.wav'),
    ['select'] = love.audio.newSource('sounds/select.wav'),
    ['menu'] = love.audio.newSource('sounds/menu.mp3'),
    ['transform'] = love.audio.newSource('sounds/transform.wav')

}

gTextures = {
    ['background1'] = love.graphics.newImage('graphics/background1.png'),
    ['background2'] = love.graphics.newImage('graphics/background2.png'),
    ['background3'] = love.graphics.newImage('graphics/background3.png'),
    ['background4'] = love.graphics.newImage('graphics/background4.png'),
    ['background5'] = love.graphics.newImage('graphics/background5.png'),
    ['background-home'] = love.graphics.newImage('graphics/background-home.png'),
    ['background-end'] = love.graphics.newImage('graphics/background-end.png'),
    ['instruction'] = love.graphics.newImage('graphics/instruction.jpg'),
    ['death'] = love.graphics.newImage('graphics/death.jpg'),


    ['wasd'] = love.graphics.newImage('graphics/wasd.png'),
    ['j'] = love.graphics.newImage('graphics/j.png'),
    ['arrow'] = love.graphics.newImage('graphics/arrow.png'),
    ['x'] = love.graphics.newImage('graphics/x.png'),

    ['lives'] = love.graphics.newImage('graphics/lives.png'),
    
    ['t-diver-up'] = love.graphics.newImage('graphics/t_diver_up.png'),
    ['t-diver-down'] = love.graphics.newImage('graphics/t_diver_down.png'),
    ['r-diver-up'] = love.graphics.newImage('graphics/r_diver_up.png'),
    ['r-diver-down'] = love.graphics.newImage('graphics/r_diver_down.png'),
    ['r-diver-up-h'] = love.graphics.newImage('graphics/r_diver_up_h.png'),
    ['t-diver-up-h'] = love.graphics.newImage('graphics/t_diver_up_h.png'),

    ['fish1'] = love.graphics.newImage('graphics/fish1.png'),
    ['fish2'] = love.graphics.newImage('graphics/fish2.png'),
    ['fish3'] = love.graphics.newImage('graphics/fish3.png'),
    ['fish4'] = love.graphics.newImage('graphics/fish4.png'),
    ['fish5'] = love.graphics.newImage('graphics/fish5.png'),
    ['fish6'] = love.graphics.newImage('graphics/fish6.png'),


    ['bag'] = love.graphics.newImage('graphics/bag.png'),
    ['coffee'] = love.graphics.newImage('graphics/coffee.png'),
    ['chips'] = love.graphics.newImage('graphics/chips.png'),

    ['can'] = love.graphics.newImage('graphics/can.png'),
    ['egg'] = love.graphics.newImage('graphics/egg.png'),
    ['milk'] = love.graphics.newImage('graphics/milk.png'),
    ['water'] = love.graphics.newImage('graphics/water.png'),

}

gLives = GenerateQuads(gTextures['lives'], 114, 40)

gTrash = {
    ['bag'] = 1,
    ['coffee'] = 1,
    ['chips'] = 1
}

gFonts = {
    ['text'] = love.graphics.newFont('fonts/KOMTXT__.ttf', 22),
    ['subtitle'] = love.graphics.newFont('fonts/KOMTXT__.ttf', 40),
    ['title'] = love.graphics.newFont('fonts/KomikaTitle.ttf', 60),
    ['death'] = love.graphics.newFont('fonts/KomikaTitle.ttf', 100)

}

