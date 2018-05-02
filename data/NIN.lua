-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    -- Load and initialize the include file.
    include('Sel-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()

    state.Buff.Migawari = buffactive.migawari or false
    state.Buff.Yonin = buffactive.Yonin or false
    state.Buff.Innin = buffactive.Innin or false
    state.Buff.Futae = buffactive.Futae or false

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Blade: Hi', 'Blade: Ten'}
	
	autows = "Blade: Shun"
	autofood = 'Soy Ramen'
	
    determine_haste_group()
	
	init_job_states({"Capacity","AutoTrustMode","AutoWSMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode"},{"OffenseMode","WeaponskillMode","IdleMode","ElementalMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.action_type == 'Ranged Attack' and (player.equipment.ammo == 'Togakushi Shuriken' or player.equipment.ammo == 'Happo Shuriken') then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t throw your good ammo!')
    elseif spell.name == 'Sange' and (player.equipment.ammo == 'Togakushi Shuriken' or player.equipment.ammo == 'Happo Shuriken') then
		cancel_spell()
		add_to_chat(123,'Abort: Don\'t throw your good ammo!')
    end
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then
		local WSset = get_precast_set(spell, spellMap)
		if WSset.left_ear then WSset.ear1 = WSset.left_ear end
		if WSset.right_ear then WSset.ear2 = WSset.right_ear end
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp > 2950 and (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			if state.WeaponskillMode.Current:contains('Acc') and sets.precast.AccMaxTP then
				if (sets.precast.AccMaxTP.ear1:startswith("Lugra Earring") or sets.precast.AccMaxTP.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayMaxTPWSEars then
					equip(sets.AccDayMaxTPWSEars)
				else
					equip(sets.precast.AccMaxTP)
				end
			elseif sets.precast.MaxTP then
				if (sets.precast.MaxTP.ear1:startswith("Lugra Earring") or sets.precast.MaxTP.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayMaxTPWSEars then
					equip(sets.DayMaxTPWSEars)
				else
					equip(sets.precast.MaxTP)
				end
			else
			end
		else
			if state.WeaponskillMode.Current:contains('Acc') and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
				equip(sets.AccDayWSEars)
			elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
				equip(sets.DayWSEars)
			end
		end
	end
	
end

-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    if spellMap == 'ElementalNinjutsu' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Normal' or state.CastingMode.value == 'Fodder' then
				if item_available('Twilight Cape') and not state.Capacity.value then
					sets.TwilightCape = {back="Twilight Cape"}
					equip(sets.TwilightCape)
				end
				if spell.element == world.day_element then
					if item_available('Zodiac Ring') then
						sets.ZodiacRing = {ring2="Zodiac Ring"}
						equip(sets.ZodiacRing)
					end
				end
			end
		end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, spellMap, eventArgs)
    
	if spell.interrupted then return
	elseif spell.english == "Migawari: Ichi" then
        state.Buff.Migawari = true
	elseif spellMap == 'ElementalNinjutsu' and state.MagicBurstMode.value == 'Single' then
            state.MagicBurstMode:reset()
			if state.DisplayMode.value then update_job_states()	end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- If we gain or lose any haste buffs, adjust which gear set we target.
    if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
        determine_haste_group()
    end
end

function job_status_change(new_status, old_status)

end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == "Ninjutsu" then
        if not default_spell_map then
            if spell.target.type == 'SELF' then
                return 'NinjutsuBuff'
            else
                return 'NinjutsuDebuff'
            end
        end
    end
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if state.Buff.Migawari then
        idleSet = set_combine(idleSet, sets.buff.Migawari)
    end

	if player.status == 'Idle' and moving and state.DefenseMode.value == 'None' and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') then
		if classes.DuskToDawn and sets.DuskKiting then
		idleSet = set_combine(idleSet, sets.DuskKiting)
		end
	end
	
    return idleSet
end


-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
	if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end
	if state.Buff.Migawari then
        meleeSet = set_combine(meleeSet, sets.buff.Migawari)
    end
	if state.Buff.Yonin and (state.DefenseMode.value == 'None' or state.DefenseMode.value == 'Evasion') then
		meleeSet = set_combine(meleeSet, sets.buff.Yonin)
    end
	if state.Buff.Innin and (state.OffenseMode.value == 'Normal' or state.OffenseMode.value == 'Fodder') and state.DefenseMode.value == 'None' then
		meleeSet = set_combine(meleeSet, sets.buff.Innin)
    end

    return meleeSet
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
    determine_haste_group()
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
    -- We have three groups of DW in gear: Hachiya body/legs, Iga head + Patentia Sash, and DW earrings
    
    -- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

    -- For high haste, we want to be able to drop one of the 10% groups.
    -- Basic gear hits capped delay (roughly) with:
    -- 1 March + Haste
    -- 2 March
    -- Haste + Haste Samba
    -- 1 March + Haste Samba
    -- Embrava
    
    -- High haste buffs:
    -- 2x Marches + Haste Samba == 19% DW in gear
    -- 1x March + Haste + Haste Samba == 22% DW in gear
    -- Embrava + Haste or 1x March == 7% DW in gear
    
    -- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
    -- Max haste buffs:
    -- Embrava + Haste+March or 2x March
    -- 2x Marches + Haste
    
    -- So we want four tiers:
    -- Normal DW
    -- 20% DW -- High Haste
    -- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
    -- 0 DW - Max Haste
    
    classes.CustomMeleeGroups:clear()
    
    if buffactive.embrava and (buffactive.march == 2 or (buffactive.march and buffactive.haste)) then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.march == 2 and buffactive.haste then
        classes.CustomMeleeGroups:append('MaxHaste')
    elseif buffactive.embrava and (buffactive.haste or buffactive.march) then
        classes.CustomMeleeGroups:append('EmbravaHaste')
    elseif buffactive.march == 1 and buffactive.haste and buffactive['haste samba'] then
        classes.CustomMeleeGroups:append('HighHaste')
    elseif buffactive.march == 2 then
        classes.CustomMeleeGroups:append('HighHaste')
    end
end

function job_self_command(commandArgs, eventArgs)
		if commandArgs[1]:lower() == 'elemental' then
			handle_elemental(commandArgs)
			eventArgs.handled = true			
		end
end

function job_tick()

	return false
end

function handle_elemental(cmdParams)
    -- cmdParams[1] == 'elemental'
    -- cmdParams[2] == ability to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No elemental command given.')
        return
    end
    local elementalcom = cmdParams[2]:lower()

    if elementalcom == 'nuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Fire' then
			if silent_can_use(322) and spell_recasts[322] == 0 then
				windower.chat.input('/ma "Katon: San" <t>')
			elseif silent_can_use(321) and spell_recasts[321] == 0 then
				windower.chat.input('/ma "Katon: Ni" <t>')
			elseif silent_can_use(320) and spell_recasts[320] == 0 then
				windower.chat.input('/ma "Katon: Ichi" <t>')
			else
				add_to_chat(123,'Abort: All Fire Ninjutsu on cooldown.')
			end
			
		elseif state.ElementalMode.value == 'Wind' then
			if silent_can_use(328) and spell_recasts[328] == 0 then
				windower.chat.input('/ma "Huton: San" <t>')
			elseif silent_can_use(327) and spell_recasts[327] == 0 then
				windower.chat.input('/ma "Huton: Ni" <t>')
			elseif silent_can_use(326) and spell_recasts[326] == 0 then
				windower.chat.input('/ma "Huton: Ichi" <t>')
			else
				add_to_chat(123,'Abort: All Wind Ninjutsu on cooldown.')
			end
			
		elseif state.ElementalMode.value == 'Lightning' then
			if silent_can_use(334) and spell_recasts[334] == 0 then
				windower.chat.input('/ma "Raiton: San" <t>')
			elseif silent_can_use(333) and spell_recasts[333] == 0 then
				windower.chat.input('/ma "Raiton: Ni" <t>')
			elseif silent_can_use(332) and spell_recasts[332] == 0 then
				windower.chat.input('/ma "Raiton: Ichi" <t>')
			else
				add_to_chat(123,'Abort: All Lightning Ninjutsu on cooldown.')
			end

		elseif state.ElementalMode.value == 'Earth' then
			if silent_can_use(331) and spell_recasts[331] == 0 then
				windower.chat.input('/ma "Doton: San" <t>')
			elseif silent_can_use(330) and spell_recasts[330] == 0 then
				windower.chat.input('/ma "Doton: Ni" <t>')
			elseif silent_can_use(329) and spell_recasts[329] == 0 then
				windower.chat.input('/ma "Doton: Ichi" <t>')
			else
				add_to_chat(123,'Abort: All Earth Ninjutsu on cooldown.')
			end
			
		elseif state.ElementalMode.value == 'Ice' then
			if silent_can_use(325) and spell_recasts[325] == 0 then
				windower.chat.input('/ma "Hyoton: San" <t>')
			elseif silent_can_use(324) and spell_recasts[324] == 0 then
				windower.chat.input('/ma "Hyoton: Ni" <t>')
			elseif silent_can_use(323) and spell_recasts[323] == 0 then
				windower.chat.input('/ma "Hyoton: Ichi" <t>')
			else
				add_to_chat(123,'Abort: All Ice Ninjutsu on cooldown.')
			end
		
		elseif state.ElementalMode.value == 'Water' then
			if silent_can_use(337) and spell_recasts[337] == 0 then
				windower.chat.input('/ma "Suiton: San" <t>')
			elseif silent_can_use(336) and spell_recasts[336] == 0 then
				windower.chat.input('/ma "Suiton: Ni" <t>')
			elseif silent_can_use(335) and spell_recasts[335] == 0 then
				windower.chat.input('/ma "Suiton: Ichi" <t>')
			else
				add_to_chat(123,'Abort: All Water Ninjutsu on cooldown.')
			end
			
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There are no light Ninjutsu nukes.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There are no Dark Ninjutsu nukes.')
		end
	else
        add_to_chat(123,'Unrecognized elemental command.')
    end
end