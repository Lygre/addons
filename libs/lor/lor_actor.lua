--[[
    Packet parsing functions used in multiple addons
    
    Author: Ragnarok.Lorand
--]]

local lor_actor = {}
lor_actor._author = 'Ragnarok.Lorand'
lor_actor._version = '2016.10.02.0'

require('lor/lor_utils')
_libs.lor.actor = lor_actor
_libs.lor.req('position')

local Pos = _libs.lor.position
local messages_initiating = _libs.lor.packets.messages_initiating
local messages_completing = _libs.lor.packets.messages_completing

local default_delays = {on_action = 0.6, post_action = 2.75, idle = 0.1}
local lag_timeout = 8

--Single Actor =========================================================================================================

local Actor = {}

function Actor.new(id)
    local now = os.clock()
    local self = {
        id = id,
        actionStart = now,
        actionEnd = now + 0.1,
        last_pos = Pos.new(),
        pos_arrival = now,
        action_delay = default_delays.post_action,
        last_action = now,
        last_acting_state = true
    }
    return setmetatable(self, {__index = Actor})
end


function Actor:send_cmd(cmd)
    windower.send_command(cmd)
    self.action_delay = default_delays.on_action
end


function Actor:action_delay_passed()
    return (os.clock() - self.last_action) > self.action_delay
end


function Actor:is_acting()
    local now = os.clock()
    if (now - self.actionStart) > lag_timeout then
        --Precaution in case an action completion isn't registered for a long time
        self.actionEnd = now
    end
    local acting = self.actionEnd < self.actionStart
    if self.last_acting_state ~= acting then                --If the current acting state is different from the last one
        if self.last_acting_state then                      --If an action was being performed
            self.action_delay = default_delays.post_action  --Set a longer delay
            self.last_action = now                          --The delay will be from this time
        else                                            --If no action was being performed
            self.action_delay = default_delays.idle         --Set a short delay
        end
        self.last_acting_state = acting                     --Refresh the last acting state
    end
    return acting
end


function Actor:pos()
    return Pos.current_position()
end


function Actor:time_at_pos()
    local current_pos = Pos.current_position()
    if (current_pos == nil) then
        return nil
    end
    return math.floor((os.clock() - self.pos_arrival)*10)/10
end


function Actor:is_moving()
    local current_pos = Pos.current_position()
    if (current_pos == nil) then
        return true
    end
    
    local moving = true
    if (self.last_pos:equals(current_pos)) then
        moving = (self:time_at_pos() < 0.5)
    else
        self.last_pos = current_pos
        self.pos_arrival = os.clock()
    end
    return moving
end


--[[
    Update this actor's status based on the received parsed packet
--]]
function Actor:update(id, parsed_action)
    if parsed_action.actor_id == self.id then
        if id == 0x28 then
            for _,targ in pairs(parsed_action.targets) do
                for _,tact in pairs(targ.actions) do
                    if messages_initiating:contains(tact.message_id) then
                        self.actionStart = os.clock()
                        return
                    elseif messages_completing:contains(tact.message_id) then
                        self.actionEnd = os.clock()
                        return
                    end
                end
            end
        elseif id == 0x29 then
            if messages_initiating:contains(parsed_action.message_id) then
                self.actionStart = os.clock()
            elseif messages_completing:contains(parsed_action.message_id) then
                self.actionEnd = os.clock()
            end
        end
    end
end


--Actor Group ==========================================================================================================

local ActorGroup = {}

function ActorGroup.new()
    local self = {actors = {}}
    return setmetatable(self, {__index = ActorGroup})
end

function ActorGroup:add(actor)
    self.actors[actor.id] = actor
end

function ActorGroup:remove(id)
    self.actors[id] = nil
end

function ActorGroup:update(id, parsed_action)
    local actor = self.actors[parsed_action.actor_id]
    if actor ~= nil then
        actor:update(id, parsed_action)
    end
end


lor_actor.Actor = Actor
lor_actor.ActorGroup = ActorGroup

return lor_actor

-----------------------------------------------------------------------------------------------------------
--[[
Copyright © 2016, Ragnarok.Lorand
All rights reserved.
Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
    * Neither the name of libs/lor nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Lorand BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--]]
-----------------------------------------------------------------------------------------------------------