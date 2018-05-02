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

--	state.CombatForm = get_combat_form()

	update_combat_form()

	state.Buff = {}

    state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
    buffactive['Aftermath: Lv.2'] or
    buffactive['Aftermath: Lv.3'] or false
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Stardiver'}

	autows = 'Stardiver'
	autofood = 'Soy Ramen'
	
	init_job_states({"Capacity","AutoTrustMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode"},{"OffenseMode","WeaponskillMode","IdleMode","TreasureMode",})
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

function job_precast(spell, spellMap, eventArgs)

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


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
		if spell.action_type == 'Magic' then
		equip(sets.midcast.FastRecast)
		if player.hpp < 51 then
			classes.CustomClass = "Breath" -- This would cause it to look for sets.midcast.Breath 
		end
	end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
	
--	if state.DefenseMode == 'Reraise' or
--		(state.Defense.Active and state.Defense.Type == 'Physical' and state.Defense.PhysicalMode == 'Reraise') then
--		equip(sets.Reraise)
--	end
end

-- Runs when a pet initiates an action.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_midcast(spell, spellMap, eventArgs)
	if spell.english:startswith('Healing Breath') or spell.english == 'Restoring Breath' then
		equip(sets.HealingBreath)
	elseif spell.english:contains('Breath') then
		equip(sets.SmitingBreath)
	end
end

-- Run after the default pet midcast() is done.
-- eventArgs is the same one used in job_pet_midcast, in case information needs to be persisted.
function job_pet_post_midcast(spell, action, spellMap, eventArgs)
	
end

-- Run after the default aftercast() is done.
-- eventArgs is the same one used in job_aftercast, in case information needs to be persisted.
function job_post_aftercast(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_pet_aftercast(spell, action, spellMap, eventArgs)

end

-- Run after the default pet aftercast() is done.
-- eventArgs is the same one used in job_pet_aftercast, in case information needs to be persisted.
function job_pet_post_aftercast(spell, action, spellMap, eventArgs)

end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-- Called before the Include starts constructing melee/idle/resting sets.
-- Can customize state or custom melee class values at this point.
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_handle_equipping_gear(status, eventArgs)

end

-- Return a customized weaponskill mode to use for weaponskill sets.
-- Don't return anything if you're not overriding the default value.
function get_custom_wsmode(spell, action, spellMap)

end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
	return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
	return meleeSet
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when the player's pet's status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)

end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

		if buff:startswith('Aftermath') then
			classes.CustomMeleeGroups:clear()
                
			if gain then
					update_combat_form()
					update_melee_groups()
					classes.CustomMeleeGroups:append('AM')
					if not midaction then handle_equipping_gear(player.status) end
			end
        end
  
  -- Spirit Surge modifies the custom melee groups
    if buff == "Spirit Surge" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Spirit Surge" and gain) or buffactive['spirit surge'] then
            classes.CustomMeleeGroups:append('SpiritSurge')
        end
        
    end

    -- Update gear if any of the above changed
    if buff == "Spirit Surge" or buff:startswith('Aftermath') then
        handle_equipping_gear(player.status)
    end
	
end

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if state.Buff.Aftermath then
		classes.CustomMeleeGroups:append('AM')
	end
    
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called for custom player commands.
function job_self_command(commandArgs, eventArgs)

end

function job_tick()

	return false
end

--function get_combat_form()
--	if areas.Adoulin:contains(world.area) and buffactive.ionis then
--		return 'Adoulin'
--	end
--end

-- Job-specific toggles.
function job_toggle(field)

end

-- Request job-specific mode lists.
-- Return the list, and the current value for the requested field.
function job_get_mode_list(field)

end

-- Set job-specific mode values.
-- Return true if we recognize and set the requested field.
function job_set_mode(field, val)

end

-- Handle auto-targetting based on local setup.
function job_auto_change_target(spell, action, spellMap, eventArgs)

end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end

    return meleeSet
end