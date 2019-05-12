require('queues')
res = require('resources')
packets = require('packets')
config = require('config2')

local self = windower.ffxi.get_player().id
local index = windower.ffxi.get_player().index
local target = nil
local completion = false
local turn = false
local mode = nil
local weaponskill = nil
local assist = nil
local cooldowns = {}
local settings = config.load('libs/rnghelper_settings.xml')
local cooldown = 0
local queue = Q{}
local pending = nil
local enabled = true
local pet = nil
local cancel = false
local timeout = 6.0
local timestamp = os.time()

local action_events = {
    [2] = 'mid /ra',
    [3] = 'mid /ws',
    [4] = 'mid /ma',
    [5] = 'mid /item',
    [6] = 'pre /ja',
    [7] = 'pre /ws',
    [8] = 'pre /ma',
    [9] = 'pre /item',
    [12] = 'pre /ra',
    [13] = 'mid /petws',
    [14] = 'pre /ja',
    [15] = 'pre /ja',
}

local terminal_action_events = {
    [2] = 'mid /ra',
    [3] = 'mid /ws',
    [4] = 'mid /ma',
    [5] = 'mid /item',
    [6] = 'pre /ja',
    [13] = 'mid /petws',
}

local action_interrupted = {
    [78] = 78,
    [84] = 84,
}

local action_message_interrupted = {
    [16] = 16,
    [62] = 62,
}

local action_message_unable = {
    [12] = 12,
    [17] = 17,
    [18] = 18,
    [34] = 34,
    [35] = 35,
    [40] = 40,
    [47] = 47,
    [48] = 48,
    [49] = 49,
    [55] = 55,
    [56] = 56,
    [71] = 71,
    [72] = 72,
    [76] = 76,
    [78] = 78,
    [84] = 84,
    [87] = 87,
    [88] = 88,
    [89] = 89,
    [90] = 90,
    [91] = 91,
    [92] = 92,
    [94] = 94,
    [95] = 95,
    [96] = 96,
    [104] = 104,
    [106] = 106,
    [111] = 111,
    [128] = 128,
    [154] = 154,
    [155] = 155,
    [190] = 190,
    [191] = 191,
    [192] = 192,
    [193] = 193,
    [198] = 198,
    [199] = 199,
    [215] = 215,
    [216] = 216,
    [217] = 217,
    [218] = 218,
    [219] = 219,
    [220] = 220,
    [233] = 233,
    [246] = 246,
    [247] = 247,
    [307] = 307,
    [308] = 308,
    [313] = 313,
    [315] = 315,
    [316] = 316,
    [325] = 325,
    [328] = 328,
    [337] = 337,
    [338] = 338,
    [346] = 346,
    [347] = 347,
    [348] = 348,
    [349] = 349,
    [356] = 356,
    [410] = 410,
    [411] = 411,
    [428] = 428,
    [429] = 429,
    [443] = 443,
    [444] = 444,
    [445] = 445,
    [446] = 446,
    [514] = 514,
    [516] = 516,
    [517] = 517,
    [518] = 518,
    [523] = 523,
    [524] = 524,
    [525] = 525,
    [547] = 547,
    [561] = 561,
    [568] = 568,
    [569] = 569,
    [574] = 574,
    [575] = 575,
    [579] = 579,
    [580] = 580,
    [581] = 581,
    [649] = 649,
    [660] = 660,
    [661] = 661,
    [662] = 662,
    [665] = 665,
    [666] = 666,
    [700] = 700,
    [701] = 701,
    [717] = 717,
}

local function load_profile(name, set_to_default)
    local profile = settings.profiles[name]
    for k, v in pairs(profile.cooldowns) do
        cooldowns["\/%s":format(k)] = v
    end
    weaponskill = profile.weaponskill
    mode = profile.mode
    turn = profile.turn
    if set_to_default then
        settings.default = name
        settings:save('all')
    end
end

local function save_profile(name)
    local profile = {}
    profile.cooldowns = {}
    for k, v in pairs(cooldowns) do
        profile.cooldowns[k:sub(2)] = v
    end
    profile.weaponskill = weaponskill
    profile.mode = mode
    profile.turn = turn
    settings.profiles[name] = profile
    settings.default = name
    settings:save('all')
end

local function heading_difference(h, a)
    if (h > 0 and a > 0) or (h < 0 and a < 0) then
        return math.abs(h - a)
    else
        local d = math.abs(a - h)
        if d > math.pi then
            if h > 0 then
                d = h - a - 2 * math.pi
            else
                d = h - a + 2 * math.pi
            end
        end
        return math.abs(d)
    end
end

local function turn_away(player, mob)
    local dx = player.x - mob.x
    local dy = player.y - mob.y
    local away = math.atan(-dy/dx)
    if (dx >= 0) then
        windower.ffxi.turn(away)
    else
        if away >= 0 then
            away = away - math.pi
        else
            away = away + math.pi
        end
        windower.ffxi.turn(away)
    end
    local p = packets.parse('outgoing', windower.packets.last_outgoing(0x15))
    local h = p['Rotation'] * 2 * math.pi/255
    if h > math.pi then
        h = h - 2 * math.pi
    end
    return heading_difference(h, away) >= 0.785398 
end

local function able_to_use_action()
    if pending.action_type == 'Ability' then
        return windower.ffxi.get_ability_recasts()[res.job_abilities[pending.id].recast_id] == 0
    elseif pending.action_type == 'Magic' then
        return windower.ffxi.get_spell_recasts()[res.spells[pending.id].recast_id] == 0
    end
    return true
end

local function able_to_use_weaponskill()
    return windower.ffxi.get_player().vitals.tp >= 1000
end

local function execute_pending_action()
    cooldown = cooldowns[pending.prefix]
    if pending.prefix == '/range' then
        windower.chat.input("%s %d":format(pending.prefix, pending.target))
    else
        windower.chat.input("%s \"%s\" %d":format(pending.prefix, pending.english, pending.target))
    end
end

local function process_pending_action()
    if turn and (pending.prefix == '/range' or pending.prefix == '/weaponskill') then
        local player = windower.ffxi.get_mob_by_id(self)
        local mob = windower.ffxi.get_mob_by_id(pending.target)
        cancel = turn_away(mob, player)
    end
    if pending.prefix == '/weaponskill' then
        if not able_to_use_weaponskill() then
            queue:insert(1, pending)
            pending = {
                ['prefix'] = '/range',
                ['english'] = 'Ranged',
                ['target'] = pending.target,
            }
        end
        execute_pending_action()
    elseif not able_to_use_action() then
        windower.add_to_chat(200, "Rnghelper : Aborting %s - Ability not ready.":format(pending.english))
        completion = true   
        process_queue()
    else
        execute_pending_action()
    end
end

function process_queue()
    if completion then
        pending = nil
        completion = false
    end
    if pending then
    elseif not queue:empty() then
        pending = queue:pop()
    elseif target then
        if weaponskill and able_to_use_weaponskill() then
            pending = {
                ['prefix'] = '/weaponskill',
                ['english'] = weaponskill,
                ['target'] = target,
                ['action_type'] = 'Ability',
            }
        else
            pending = {
                ['prefix'] = '/range',
                ['english'] = 'Ranged',
                ['target'] = target,
                ['action_type'] = 'Ranged Attack',
            }
        end
    end
    if pending then
        process_pending_action()
    end
end

local function handle_interrupt()
    completion = true
    windower.send_command('@wait %f;gs rh process':format(cooldown))
end

local function add_spell_to_queue(spell)
    queue:push({
        ['prefix'] = spell.prefix,
        ['english'] = spell.english,
        ['target'] = spell.target.id,
        ['id'] = spell.id,
        ['action_type'] = spell.action_type,
    })
end

local function check_timeout()
    local current_time = os.time()
    if pending and (current_time - timestamp) >= timeout then
        timestamp = current_time
        if pending.english then
            windower.add_to_chat(167, "Timed out attempting to %s - Retrying":format(pending.english))
        end
        process_queue()
    end
end

function filter_precast(spell, spellMap, eventArgs)
    if (pending and 
        pending.prefix == spell.prefix and
        pending.english == spell.english and
        pending.target == spell.target.id) or (not enabled) then
        if enabled and turn and cancel then
            eventArgs.cancel = true
            cancel_spell()
            windower.send_command('@wait 0.1;gs rh process')
        else
            timestamp = os.time()
            coroutine.schedule(check_timeout, timeout)
        end
    else
        eventArgs.cancel = true
        cancel_spell()
        if pending then
            if spell.english == 'Ranged' then
                target = spell.target.id
                completion = true
                process_queue()
            else
                add_spell_to_queue(spell)
            end
        else
            add_spell_to_queue(spell)
            process_queue()
        end
    end
end

local function monitor_target(id, data, modified, injected, blocked)
    if (id == 0xe) and target then
        local p = packets.parse('incoming', data)
        if (p.NPC == target) and ((p.Mask % 8) > 3) then
            if not (p['HP %'] > 0) then
                target = nil
                pending = nil
                completion = false
                queue:clear()
            end
        end
    end
end

local function handle_incoming_action_packet(id, data, modified, injected, blocked)
    if id == 0x28 and enabled then
        local p = packets.parse('incoming', data)
        if ((p.Actor == self) or (p.Actor == pet)) and action_events[p.Category] then
            if action_interrupted[p['Target 1 Action 1 Message']] then
                handle_interrupt()
            elseif p.Param == 28787 then
            elseif terminal_action_events[p.Category] then
                if pending and pending.prefix == '/pet' and not (res.job_abilities[p.Param].type == 'PetCommand') then
                    if p.Actor == pet then
                        handle_interrupt()
                    end
                else
                    handle_interrupt()
                end
            end
        elseif assist and (not target) and (p.Category == 2) then
            local player = windower.ffxi.get_mob_by_id(p.Actor)
            if player.name == assist then
                local empty = queue:empty()
                queue:push({
                    ['prefix'] = '/range',
                    ['english'] = 'Ranged',
                    ['target'] = p['Target 1 ID'],
                    ['action_type'] = 'Ranged Attack',
                })
                if empty then
                    process_queue()
                end
            end
        end
    end
end

local function handle_incoming_action_message_packet(id, data, modified, injected, blocked)
    if id == 0x29 and enabled then
        local p = packets.parse('incoming', data)
        if (p.Actor == self) then
            if action_message_interrupted[p.Message] then
                handle_interrupt()
            elseif action_message_unable[p.Message] then
                windower.send_command('@wait 0;gs rh process')
            end
        end
    end
end

local function handle_outgoing_action_packet(id, data, modified, injected, blocked)
    if id == 0x1a and enabled then
        local p = packets.parse('outgoing', data)
        if p.Category == 16 then
            target = p.Target
            cooldown = cooldowns['/range']
        end
    end
end

local function acquire_pet(id, data)
    if id == 0x68 then
        local p = packets.parse('incoming', data)
        if p['Owner ID'] == self then
            pet = p['Target ID']
        end
    end
end

local function clear()
    target = nil
    pending = nil
    completion = false
    queue:clear()
end

register_unhandled_command(function (...)
    local commands = {...}
    if commands[1] and commands[1]:lower() == 'rh' then
        if commands[2] and commands[2]:lower() == 'process' then
            process_queue()
        elseif commands[2] and commands[2]:lower() == 'set' then
            if commands[3] then
                windower.add_to_chat(200, "Rnghelper : Setting weaponskill to %s":format(commands[3]))
                weaponskill = commands[3]
            else
                windower.add_to_chat(200, "Rnghelper : Clearing weaponskill.")
                weaponskill = nil
            end
        elseif commands[2] and commands[2]:lower() == 'assist' then
            if commands[3] then
                windower.add_to_chat(200, "Rnghelper : Assisting %s":format(commands[3]))
                assist = commands[3]
            else
                windower.add_to_chat(200, "Rnghelper : Clearing assist.")
                assist = nil
            end
        elseif commands[2] and commands[2]:lower() == 'turn' then
            if turn then
                windower.add_to_chat(200, "Rnghelper : Disabling auto turn")
                turn = false
                cancel = false
            else
                windower.add_to_chat(200, "Rnghelper : Enabling auto turn")
            end
        elseif commands[2] and commands[2]:lower() == 'print' then
            if pending then
                windower.add_to_chat(200, pending.prefix .. pending.english .. pending.target)
            end
            for k, v in pairs(queue.data) do
                windower.add_to_chat(200, k .. v.prefix .. v.english .. v.target)
            end
        elseif commands[2] and commands[2]:lower() == 'save' then
            save_profile(commands[3])
        elseif commands[2] and commands[2]:lower() == 'load' then
            load_profile(commands[3], true)
        elseif commands[2] and commands[2]:lower() == 'clear' then
            windower.add_to_chat(200, "Rnghelper : Clearing queue")
            clear()
        elseif commands[2] and commands[2]:lower() == 'enable' then
            if enabled then
                windower.add_to_chat(200, "Rnghelper : Already enabled")
            else
                windower.add_to_chat(200, "Rnghelper : Enabling")
                enabled = true
            end
        elseif commands[2] and commands[2]:lower() == 'disable' then
            if not enabled then
                windower.add_to_chat(200, "Rnghelper : Already disabled")
            else
                windower.add_to_chat(200, "Rnghelper : Disabling")
                clear()
                enabled = false
            end
        end
        return true
    end
    return false
end)

load_profile(settings.default)
windower.raw_register_event('incoming chunk', handle_incoming_action_packet)
windower.raw_register_event('incoming chunk', handle_incoming_action_message_packet)
windower.raw_register_event('outgoing chunk', handle_outgoing_action_packet)
windower.raw_register_event('incoming chunk', monitor_target)
windower.raw_register_event('incoming chunk', acquire_pet)