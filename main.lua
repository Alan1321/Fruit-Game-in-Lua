local statusBar = display.setStatusBar( display.HiddenStatusBar ) --hides status bar

local balls = {}
local fruitTable = {}
local fruitindex = 1;

local opt =
{
	frames = {
		{ x = 0, y = 0, width = 52, height = 60}, -- 1. apple
		{ x = 63, y = 0, width = 57, height = 60}, -- 2. cherry
		{ x = 123, y = 0, width = 62, height = 60}, -- 3. mango
		{ x = 192, y = 0, width = 52, height = 60}, -- 4. orange
		{ x = 257, y = 0, width = 52, height = 60}, -- 5. peach
		{ x = 320, y = 0, width = 54, height = 60}, -- 6. pear
			
	}
}
local sheet = graphics.newImageSheet( "ac.png", opt);

local function findIndex(obj)
    for i, v in ipairs(balls) do
      if v == obj then
      return i
      end
    end
end

local function findIndex2(obj)
    for i, v in pairs(fruitTable) do
      if i == obj then
      return i
      end
    end
end

local correct = 0
local incorrect = 0

local text1 = display.newText('Name: ' .. 'Alan Subedi', display.contentWidth/3 - 150, 60 , native.systemFont, 50)
local text2 = display.newText('C: ' .. tostring(correct), display.contentWidth/3 * 2 -50, 60, native.systemFont, 50)
local text3 = display.newText('I: ' .. tostring(incorrect), display.contentWidth - 80, 60, native.systemFont, 50)

local function removeFruit(event)
  
    local isapple = false
    
    for k, v in ipairs(fruitTable) do
        if(v[1] == event.target) then
            print(v[2])
            if(v[2] == 1) then
                isapple = true 
            end
        end
    end

    if(isapple == true) then
        correct = correct + 1
    elseif isapple == false then
        incorrect = incorrect + 1
    end

    text2.text = 'C: ' .. tostring(correct)
    text3.text = 'R: ' .. tostring(incorrect)

    table.remove(balls, findIndex(event.target)) 
    display.remove(event.target)
    return true
end

Runtime:addEventListener("tap", removeFruit)

local function generateFruit()
    local ranx = (math.random() * 570) + 30
    local y = -20
    local randomfruit = math.floor(math.random() * 6) + 1
    local fruit = display.newImage(sheet, randomfruit)
    fruit.x = ranx
    fruit.y = -20
    fruit.stopped = false
    fruitTable.fruit = randomfruit
    table.insert(fruitTable, {fruit, randomfruit})
    table.insert(balls, fruit)
    fruit:addEventListener("tap", removeFruit)
end

local function update()
    for _,ball in ipairs(balls) do
        local randomY = math.random() * 100 + 20 -- random falling 
        ball.y = ball.y + randomY --ball is going down
        local randomR = math.random() * 100 + 20 -- random rotation
        ball.rotation = ball.rotation + randomR --rotates fruit
        if ball.y > 1140 then
            ball:removeSelf() 
            table.remove(balls, findIndex(ball)) 
        end
    end

    -- text2.text = 'C: ' .. tostring(cCount)
    -- text3.text = 'R: ' .. tostring(rCount)
end


timer.performWithDelay(300, generateFruit, 0)
timer.performWithDelay(600, update, 0)