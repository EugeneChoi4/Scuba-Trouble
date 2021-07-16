require 'src/Dependencies'

WINDOW_WIDTH = 1280*2/3
WINDOW_HEIGHT = 720*2/3

MAP_WIDTH = 2430
MAP_HEIGHT = 810

VIRTUAL_WIDTH = 16/9*540
VIRTUAL_HEIGHT = 540

TILE_SIZE = 20

PLAYER_SWIM_SPEED = 110
PLAYER_SWIM_DOWN_SPEED = 100

TOP_OF_WATER = 240

-- fish movement speed
FISH_SPEED = 50

function love.load()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    love.graphics.setFont(gFonts['text'])
    love.window.setTitle('Scuba Trouble')

    math.randomseed(os.time())
    
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['home'] = function() return HomeState() end,
        ['instruction'] = function() return InstructionState() end,
        ['play'] = function() return PlayState() end,
        ['gameover'] = function() return GameOverState() end,
        ['win'] = function() return WinState() end,
        ['winlevel'] = function() return WinLevelState() end,
        ['startlevel'] = function() return StartLevelState() end

    }
    gStateMachine:change('home')

    gSounds['menu']:setLooping(true)
    gSounds['menu']:setVolume(0.5)
    gSounds['menu']:play()

    love.keyboard.keysPressed = {}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end

    love.keyboard.keysPressed[key] = true
end

function love.keyboard.wasPressed(key)
    return love.keyboard.keysPressed[key]
end

function love.update(dt)
    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end