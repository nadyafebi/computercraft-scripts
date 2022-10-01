local function printUsage()
    print("Place down a bridge from the turtle position")
    print("Usage:")
    print("bridge <length>")
end

local function makeBridge(length)
    local selectedSlot = 1
    turtle.select(selectedSlot)

    local i = 1
    while i < length + 1 do
        while not turtle.detectDown() do
            turtle.placeDown()

            -- Cycle through the turtle's item slots
            if turtle.getItemCount() == 0 then
                selectedSlot = selectedSlot + 1
                if selectedSlot > 16 then
                    return i, "No items left in turtle"
                end
                turtle.select(selectedSlot)
            end
        end

        if turtle.detect() then
            return i, "Turtle obstructed"
        end

        if i == length then
            break
        end
        
        turtle.forward()
        i = i + 1
    end

    return i
end

local args = { ... }
if #args ~= 1 then
    printUsage()
    return
end

distance, endReason = makeBridge(tonumber(args[1]) or 0)

if endReason ~= nil then
    print(endReason)
end

print("Distance placed: " .. distance)
