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

	state.Buff.Charge = buffactive['Brazen Rush'] or buffactive["Warrior's Charge"] or false
	state.Buff.Mighty = buffactive['Mighty Strikes']  or false
	
	state.Buff.Retaliation = buffactive['Retaliation'] or false
	state.Buff.Restraint = buffactive['Restraint'] or false
	
    state.Buff['Aftermath'] = buffactive['Aftermath: Lv.1'] or
    buffactive['Aftermath: Lv.2'] or
    buffactive['Aftermath: Lv.3'] or false
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Savage Blade','Upheaval','Ruinator','Resolution','Rampage','Raging Rush',"Ukko's Fury",}

	autows = "Ukko's Fury"
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

function job_aftercast(spell, spellMap, eventArgs)

end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

	if not state.OffenseMode.value:contains('Acc') and state.HybridMode.value == 'Normal' and buffactive['Retaliation'] then
		meleeSet = set_combine(meleeSet, sets.buff.Retaliation)
	end
	
	if not state.OffenseMode.value:contains('Acc') and state.HybridMode.value == 'Normal' and buffactive['Restraint'] then
		meleeSet = set_combine(meleeSet, sets.buff.Restraint)
	end

    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end
	
    return meleeSet
end

function job_customize_defense_set(defenseSet)
    return defenseSet
end

-- Run after the general precast() is done.
function job_post_precast(spell, spellMap, eventArgs)

	if spell.type == 'WeaponSkill' then

		local WSset = get_precast_set(spell, spellMap)
		if WSset.left_ear then WSset.ear1 = WSset.left_ear end
		if WSset.right_ear then WSset.ear2 = WSset.right_ear end
        -- Replace Moonshade Earring if we're at cap TP
		if player.tp > 2950 and (WSset.ear1 == "Moonshade Earring" or WSset.ear2 == "Moonshade Earring") then
			if state.WeaponskillMode.Current:contains('Acc') and not buffactive['Sneak Attack'] and sets.precast.AccMaxTP then
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
			if state.WeaponskillMode.Current:contains('Acc') and not buffactive['Sneak Attack'] and (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.AccDayWSEars then
				equip(sets.AccDayWSEars)
			elseif (WSset.ear1:startswith("Lugra Earring") or WSset.ear2:startswith("Lugra Earring")) and not classes.DuskToDawn and sets.DayWSEars then
				equip(sets.DayWSEars)
			end
		end

		if state.WeaponskillMode.Current:contains('Acc') and not buffactive['Sneak Attack'] then
			if state.Buff.Charge and state.Buff.Mighty and sets.ACCWSMightyCharge then
				equip(sets.ACCWSMightyCharge)
			elseif state.Buff.Charge and sets.ACCWSCharge then
				equip(sets.ACCWSCharge)
			elseif state.Buff.Mighty and sets.ACCWSMighty then
				equip(sets.AccWSMighty)
			end
		else
			if state.Buff.Charge and state.Buff.Mighty and sets.WSMightyCharge then
				equip(sets.WSMightyCharge)
			elseif state.Buff.Charge and sets.WSCharge then
				equip(sets.WSCharge)
			elseif state.Buff.Mighty and sets.WSMighty then
				equip(sets.WSMighty)
			end
		end

	end

end

function job_self_command(commandArgs, eventArgs)

end

function job_tick()

	return false
end

function job_post_midcast(spell, spellMap, eventArgs)

end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

function job_buff_change(buff, gain)
	if buff:startswith('Aftermath') then
		state.Buff.Aftermath = gain
		update_melee_groups()
	
	elseif buff == 'Brazen Rush' or buff == "Warrior's Charge" then
		if buffactive['Brazen Rush'] or buffactive["Warrior's Charge"] then
			state.Buff.Charge = true
		else
			state.Buff.Charge = false
		end
		update_melee_groups()
		
	elseif buff == 'Mighty Strikes' then
		state.Buff.Mighty = gain
		update_melee_groups()
		
	end
end
	
function update_combat_form()
	if player.equipment.main then
		if player.equipment.main == "Ragnarok" then
			state.CombatForm:set('Ragnarok')
		elseif player.equipment.main == "Bravura" then
			state.CombatForm:set('Bravura')
		elseif player.equipment.main == "Conqueror" then
			state.CombatForm:set('Conqueror')
		else
			state.CombatForm:reset()
		end
	end
end
	
function update_melee_groups()
    if player then
		classes.CustomMeleeGroups:clear()
		
		if areas.Adoulin:contains(world.area) and buffactive.ionis then
			classes.CustomMeleeGroups:append('Adoulin')
		end
		
		if state.Buff.Charge then
			classes.CustomMeleeGroups:append('Charge')
		end
		
		if state.Buff.Mighty then
			classes.CustomMeleeGroups:append('Mighty')
		end
		
		if state.CombatForm.Value == "Conqueror" then
			if buffactive['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
			end
		elseif state.Buff.Aftermath then
			classes.CustomMeleeGroups:append('AM')
		end
	end
end