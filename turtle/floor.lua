local function printUsage()
    print("Place floor in a room")
    print("Usage:")
    print("floor <w> <l>")
end

local args = { ... }
if #args ~= 2 then
    printUsage()
    return
end

local w, l = tonumber(args[1]) or nil, tonumber(args[2]) or nil

local selectedSlot = 1
turtle.select(selectedSlot)

local turnRight = true

for i = 1, w do
    for j = 1, l do
        if turtle.getItemCount() == 0 then
            selectedSlot = selectedSlot + 1
            if selectedSlot > 16 then
                return i, "No items left in turtle"
            end
            turtle.select(selectedSlot)
        end
        
        turtle.digDown()
        turtle.placeDown()

        if j < l then
            if turtle.detect() then
                error("Turtle obstructed")
            end
            turtle.forward()
        end
    end

    if i < w then
        if turnRight then
            turtle.turnRight()
            if turtle.detect() then
                error("Turtle obstructed")
            end
            turtle.forward()
            turtle.turnRight()
        else
            turtle.turnLeft()
            if turtle.detect() then
                error("Turtle obstructed")
            end
            turtle.forward()
            turtle.turnLeft()
        end

        turnRight = not turnRight
    end
end
