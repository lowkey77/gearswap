-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()

	-- Load and initialize the include file.
	include('Sel-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()

	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Chant du Cygne', 'Savage Blade','Requiescat','Resolution','Ruinator'}
	
	autows = 'Resolution'
	autofood = 'Miso Ramen'
	
	init_job_states({"Capacity","AutoTrustMode","AutoTankMode","AutoWSMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode"},{"OffenseMode","WeaponskillMode","IdleMode","RuneElement","PhysicalDefenseMode","MagicalDefenseMode","ResistDefenseMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_filter_precast(spell, spellMap, eventArgs)

	if spell.english == 'Valiance' then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[113] > 0 and not buffactive['Valiance'] and abil_recasts[23] == 0 then
			eventArgs.cancel = true
			send_command('@input /ja "Vallation" <me>')
		end
	end
	
end

function job_precast(spell, spellMap, eventArgs)

	if spell.english == 'Vivacious Pulse' then
		equip(sets.precast.JA['Vivacious Pulse'][state.RuneElement.value])
		return
	end
	
end

function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 and moonshade_ws:contains(spell.english) then
			if state.WeaponskillMode.Current:contains('Acc') then
				if sets.precast.AccMaxTP then
					equip(sets.precast.AccMaxTP)
				end
						
			elseif sets.precast.MaxTP then
					equip(sets.precast.MaxTP)
			end
		end
    end

end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        if weather_rune_match() then
			if item_available('Twilight Cape') and not state.Capacity.value then
				sets.TwilightCape = {back="Twilight Cape"}
				equip(sets.TwilightCape)
			end
			if item_available('Hachirin-no-Obi') then
				sets.HachiObi = {waist="Hachirin-no-Obi"}
				equip(sets.HachiObi)
			end
        end
    end
end


function job_aftercast(spell)

end

-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.ExtraDefenseMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraDefenseMode.value])
    end
   
    return meleeSet

end

function job_customize_idle_set(idleSet)

    return idleSet
end

function job_customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    return defenseSet
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end

    return idleSet
end

function job_update(cmdParams, eventArgs)
 
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

function job_self_command(commandArgs, eventArgs)
	if commandArgs[1] == 'RuneElement' then
		send_command('input /ja "'..state.RuneElement.value..'" <me>')

	elseif commandArgs[1] == 'SubJobEnmity' then

		if player.target.type ~= "MONSTER" then
			add_to_chat(123,'Abort: You are not targeting a monster.')
			return
	
		elseif player.sub_job == 'BLU' then
			local spell_recasts = windower.ffxi.get_spell_recasts()
					
			if spell_recasts[575] == 0 then
				send_command('input /ma "Jettatura" <t>')
			elseif spell_recasts[584] == 0 then
				send_command('input /ma "Sheep Song" <t>')
			elseif spell_recasts[598] == 0 then
				send_command('input /ma "Soporific" <t>')
			elseif spell_recasts[605] == 0 then
				send_command('input /ma "Geist Wall" <t>')
			elseif spell_recasts[592] == 0 then
				send_command('input /ma "Blank Gaze" <t>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Blue Magic on cooldown.') end
			end
					
		elseif player.sub_job == 'WAR' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			
			if state.HybridMode.value ~= 'Normal' and buffactive['Berserk'] then
				send_command('cancel berserk')
			end
			
			if abil_recasts[5] == 0 then
				send_command('input /ja "Provoke" <t>')
			elseif abil_recasts[2] == 0 then
				send_command('input /ja "Warcry" <me>')
			elseif abil_recasts[3] == 0 then
				send_command('input /ja "Defender" <me>')
			elseif abil_recasts[4] == 0 then
				send_command('input /ja "Aggressor" <me>')
			elseif abil_recasts[1] == 0 then
				send_command('input /ja "Berserk" <me>')
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'All Enmity Warrior Job Abilities on cooldown.') end
			end
			
		elseif player.sub_job == 'DNC' then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			local under3FMs = not buffactive['Finishing Move 3'] and not buffactive['Finishing Move 4'] and not buffactive['Finishing Move 5']
        
			if under3FMs then
				if abil_recasts[220] == 0 then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				state.CurrentStep:cycle()
				return
				end
			elseif abil_recasts[221] == 0 then
				send_command('input /ja "Animated Flourish" <t>')
				return
			elseif abil_recasts[220] == 0 and not buffactive['Finishing Move 5'] then
				send_command('@input /ja "'..state.CurrentStep.value..'" <t>')
				state.CurrentStep:cycle()
				return
			elseif not check_auto_tank_ws() then
				if not state.AutoTankMode.value then add_to_chat(123,'Dancer job abilities not needed.') end
			end
		end

	end

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function weather_rune_match()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    if weather_rune or day_rune then
		return true
	else
		return false
	end
end

-- Get a count of the number of runes of a given type
function rune_count(rune)
    local count = 0
    local current_time = os.time()
    for _,entry in pairs(rune_timers) do
        if entry.rune == rune and entry.expires > current_time then
            count = count + 1
        end
    end
    return count
end

function job_tick()
	if state.AutoTankMode.value and player.target.type == "MONSTER" and not moving then
		if check_rune() then return true end
		if check_flash_foil() then return true end
		windower.send_command('gs c SubJobEnmity')
		tickdelay = 1260
		return true
	end
	return false
end

function check_flash_foil()

	local spell_recasts = windower.ffxi.get_spell_recasts()

	if spell_recasts[112] == 0 then
		send_command('input /ma "Flash" <t>')
		tickdelay = 1230
		return true
	elseif spell_recasts[840] == 0 then
		send_command('input /ma "Foil" <me>')
		tickdelay = 1230
		return true
	else
		return false
	end

end

function check_rune()
	local abil_recasts = windower.ffxi.get_ability_recasts()
	if abil_recasts[92] > 0 then return false end
	if not buffactive[state.RuneElement.value] or buffactive[state.RuneElement.value] < 3 then
		send_command('input /ja "'..state.RuneElement.value..'" <me>')
		tickdelay = 1240
		return true
	elseif not (buffactive['Vallation'] or buffactive['Valiance']) then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if abil_recasts[113] == 0 then
			send_command('input /ja "Valiance" <me>')
			tickdelay = 1240
		elseif abil_recasts[23] == 0 then
			send_command('input /ja "Vallation" <me>')
			tickdelay = 1240
		else
			return false
		end
	else
		return false
	end

end