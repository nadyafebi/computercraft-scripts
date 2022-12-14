local function printUsage()
    print("Do various mining jobs")
    print("Usage:")
    print("mine room <w> <l> <h>")
end

local function mineRoom(w, l, h)
    local turnRight = true
    for i = 1, h do
        for j = 1, l do
            for k = 1, w do
                turtle.dig()

                if k < w then
                    turtle.forward()
                end
            end

            if j < l then
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
