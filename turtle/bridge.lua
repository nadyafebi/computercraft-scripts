-- bridge <X>
-- Create a 1xX bridge

local args = { ... }

if #args ~= 1 then
    print("Invalid arguments")
    return
end

function makeBridge(length)
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

        if i + 1 < length + 1 then
            turtle.forward()
            i = i + 1
        end
    end

    return i
end

distance, endReason = makeBridge(tonumber(args[1]) or 0)

if endReason ~= nil then
    print(endReason)
end

print("Distance placed: " .. distance)
