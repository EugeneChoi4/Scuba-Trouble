LevelMaker = Class{}

function LevelMaker.generate(width, height, levelnum)
    local entities = {}
    local objects = {}
    local names = {
        ['bag'] =1,
        ['coffee'] = 1,
        ['chips']=1,

        ['water'] =1,
        ['can'] = 1,
        ['egg']= 1,
        ['milk'] = 1
    }
    local pos = {}
    for obj, num in pairs(names) do 
        for i = 1, math.random(2,4)+ levelnum do
            local randx = math.random(113)
            while pos[randx] ~=nil do
                randx = math.random(113)
            end
            pos[randx] = obj
        end
    end

    for x, obj in pairs(pos) do 
        table.insert(objects,
        GameObject {
            texture = obj,
            x = 100+x*20,
            y = math.random(TOP_OF_WATER, MAP_HEIGHT-60),
            width = gTextures[obj]:getWidth(),
            height = gTextures[obj]:getHeight(),

            collidable = true,
            consumable = true,
            solid = false,
                
            onCollide = function(object, player)
                if player.state == 1 and isTrash(obj) or player.state == 2 and not isTrash(obj) then
                    gSounds['pickup']:play()
                    player.score = player.score + 100
                else
                    player.lives = player.lives - 1
                    if player.lives <= 0 then 
                        gStateMachine:change('gameover')
                    end
                    player:changeState('hurt')
                    gSounds['hurt']:play()
                end
            end,

            onConsume = function(player, object)
            end
        }
        )
    end

    return GameLevel(entities, objects)
end

function isTrash(key)
    return gTrash[key] ~= nil
end