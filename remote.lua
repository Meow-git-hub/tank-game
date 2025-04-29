-- Remote contrtolling handler related to Pixel Tank.
-- Requires: tank.lua

local w_prev -- Prev specifies whether this key is being pressed in previous tick.
    s_prev
    a_prev
    d_prev
    space_prev
    up_prev
    down_prev
    left_prev
    right_prev
    e_prev
    = false false false false false false false false false false

local pers = peripheral.getNames()
local redrouters = {}
local redrouter1
local redrouter2

for i = 1, #pers do
    local current = pers[i]
    if peripheral.getType(current) == "redrouter" then
        table.insert(redrouters, current)
    end
end

if #redrouters == 1 then redrouter1 = peripheral.wrap(redrouters[1])
elseif #redrouters > 1 then redrouter1, redrouter2 = peripheral.wrap(redrouters[1]), peripheral.wrap(redrouters[2])
end

local running = true -- Program exits when this signal turns into false.

local function quit_event_handler ()
    os.pullEvent("remote_quit")
end

local function remote_event_handler ()
    while running do
        if redrouter1 then
            if w_prev == not redrouter1.getInput('top') then -- Button status on W has been changed.
                if w_prev then -- If W is in pressed then switch it.
                    w_prev = false
                    os.queueEvent("key_up", 87)
                else
                    w_prev = true
                    os.queueEvent("key", 87)
                end
            elseif s_prev == not redrouter1.getInput('bottom') then
                if s_prev then
                    s_prev = false
                    os.queueEvent("key_up", 83)
                else
                    s_prev = true
                    os.queueEvent("key", 83)
                end
            elseif a_prev == not redrouter1.getInput('right') then
                if a_prev then
                    a_prev = false
                    os.queueEvent("key_up", 65)
                else
                    a_prev = true
                    os.queueEvent("key", 65)
                end
            elseif d_prev == not redrouter1.getInput('left') then
                if d_prev then
                    d_prev = false
                    os.queueEvent("key_up", 68)
                else
                    d_prev = true
                    os.queueEvent("key", 68)
                end
            elseif space_prev == not redrouter1.getInput('front') then
                if space_prev then
                    space_prev = false
                    os.queueEvent("key_up", 32)
                else
                    space_prev = true
                    os.queueEvent("key", 32)
                end
            end
        end

        if redrouter2 then
            if up_prev == not redrouter2.getInput('top') then
                if up_prev then
                    up_prev = false
                    os.queueEvent("key_up", 265)
                else
                    up_prev = true
                    os.queueEvent("key", 265)
                end
            elseif down_prev == not redrouter2.getInput('bottom') then
                if down_prev then
                    down_prev = false
                    os.queueEvent("key_up", 264)
                else
                    down_prev = true
                    os.queueEvent("key", 264)
                end
            elseif left_prev == not redrouter2.getInput('right') then
                if left_prev then
                    left_prev = false
                    os.queueEvent("key_up", 263)
                else
                    left_prev = true
                    os.queueEvent("key", 263)
                end
            elseif right_prev == not redrouter2.getInput('left') then
                if right_prev then
                    right_prev = false
                    os.queueEvent("key_up", 262)
                else
                    right_prev = true
                    os.queueEvent("key", 262)
                end
            elseif e_prev == not redrouter2.getInput('front') then
                if e_prev then
                    e_prev = false
                    os.queueEvent("key_up", 69)
                else
                    e_prev = true
                    os.queueEvent("key", 69)
                end
            end
        end

        os.sleep(0.05)
    end
end

parallel.waitForAny(remote_event_handler, quit_event_handler)

shell.exit()
