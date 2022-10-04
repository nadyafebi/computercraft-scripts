local function printUsage()
    print("Do various mining jobs")
    print("Usage:")
    print("mine room <l> <w> <h>")
end

local function mineRoom(l, w, h)
    local turnRight = true
    for i = 1, h do
        for j = 1, w do
            for k = 1, l do
                turtle.dig()
                turtle.forward()
            end

            if j < w then
                if turnRight then
                    turtle.turnRight()
                    turtle.dig()
                    turtle.forward()
                    turtle.turnRight()
                else
                    turtle.turnLeft()
                    turtle.dig()
                    turtle.forward()
                    turtle.turnLeft()
                end
    
                turnRight = not turnRight
            end
        end

        if i < h then
            turtle.digUp()
            turtle.up()
            turtle.turnRight()
            turtle.turnRight()
        end
    end
end

local args = { ... }

if args[1] == "room" and #args == 4 then
    mineRoom(tonumber(args[2]) or 0, tonumber(args[3]) or 0, tonumber(args[4]) or 0)
else
    printUsage()
end
