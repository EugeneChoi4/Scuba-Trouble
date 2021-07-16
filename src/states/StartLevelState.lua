StartLevelState = Class{__includes = BaseState}

function StartLevelState:init()
    self.transitionAlpha = 255
    self.levelLabelY = -80
end

function StartLevelState:enter(params)

    self.level = params.level
    self.map = LevelMaker.generate(MAP_WIDTH, MAP_HEIGHT, self.level)

    Timer.tween(1, {
        [self] = {transitionAlpha = 0}
    })
    :finish(function()
        Timer.tween(0.25, {
            [self] = {levelLabelY = VIRTUAL_HEIGHT / 2 - 8}
        })
        
        :finish(function()
            Timer.after(1, function()
                    Timer.tween(0.25, {
                    [self] = {levelLabelY = VIRTUAL_HEIGHT + 30}
                })
                :finish(function()
                    gStateMachine:change('play', {level = self.level, map = self.map})
                end)
            end)
        end)
    end)
end

function StartLevelState:update(dt)
    Timer.update(dt)
end

function StartLevelState:render()
    love.graphics.push()
    love.graphics.draw(gTextures['background1'], 0,0)
    love.graphics.draw(gTextures['background1'], MAP_HEIGHT, 0)
    
    self.map:render()

    love.graphics.pop() 

    love.graphics.setColor(245, 155, 66, 200)
    love.graphics.rectangle('fill', 0, self.levelLabelY - 30, VIRTUAL_WIDTH, 100)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.setFont(gFonts['title'])
    love.graphics.printf('Level ' .. tostring(self.level),
        0, self.levelLabelY-30, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(255, 255, 255, self.transitionAlpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
end