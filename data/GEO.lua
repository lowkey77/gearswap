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

	state.Buff.Entrust = buffactive.Entrust or false
	
    indi_timer = ''
    indi_duration = 180

    LowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga'}	
		
	state.RecoverMode = M('35%', '60%', 'Always', 'Never')
	
	autows = 'Realmrazer'
	autofood = 'Miso Ramen'
	indispell = 'Torpor'
	geospell = 'Frailty'
	
	init_job_states({"Capacity","AutoTrustMode","AutoNukeMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoBuffMode"},{"OffenseMode","WeaponskillMode","IdleMode","RecoverMode","ElementalMode","CastingMode","TreasureMode",})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_pretarget(spell, spellMap, eventArgs)
    if spell.type == 'Geomancy' then
		if spell.name:startswith('Indi') then
			if state.Buff.Entrust then
				if spell.target.type == 'SELF' then
					add_to_chat(204, 'Entrust active - You can\'t entrust yourself.')
					eventArgs.cancel = true
				end
			elseif spell.target.raw == '<t>' then
				change_target('<me>')
			end
		elseif spell.name:startswith('Geo') then
			if set.contains(spell.targets, 'Enemy') then
				if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) then
					eventArgs.cancel = true
				end
			elseif not ((spell.target.type == 'PLAYER' and not spell.target.charmed and spell.target.in_party) or (spell.target.type == 'NPC' and spell.target.in_party) or (spell.target.raw == '<stpt>' or spell.target.raw == '<stal>' or spell.target.raw == '<st>')) then
				change_target('<me>')
			end
		end
	end
end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, spellMap, eventArgs)

	if spell.action_type == 'Magic' then
		if spellMap == 'Cure' or spellMap == 'Curaga' then
			gear.default.obi_back = gear.obi_cure_back
			gear.default.obi_waist = gear.obi_cure_waist
		elseif spell.skill == 'Elemental Magic' then
			if LowTierNukes:contains(spell.english) then
				gear.default.obi_back = gear.obi_low_nuke_back
				gear.default.obi_waist = gear.obi_low_nuke_waist
			else
				gear.default.obi_back = gear.obi_high_nuke_back
				gear.default.obi_waist = gear.obi_high_nuke_waist
			end
		end
		
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end

function job_post_precast(spell, spellMap, eventArgs)

end

function job_post_midcast(spell, spellMap, eventArgs)

	if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' and spell.english ~= 'Impact' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
		if spell.element == world.weather_element or spell.element == world.day_element then
			if state.CastingMode.value == 'Fodder' then
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
		
		if spell.element == 'Wind' and sets.WindNuke then
			equip(sets.WindNuke)
		elseif spell.element == 'Ice' and sets.IceNuke then
			equip(sets.IceNuke)
		end
		
		if state.RecoverMode.value == 'Always' then equip(sets.RecoverMP)
		elseif state.RecoverMode.value == 'Never' then
		elseif state.RecoverMode.value == '60%' then
			if player.mpp <60 then equip(sets.RecoverMP) end
		elseif state.RecoverMode.value == '35%' then
			if player.mpp <35 then equip(sets.RecoverMP) end
		end
    elseif spell.skill == 'Geomancy' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
    end
	
end

function job_pet_midcast(spell, spellMap, eventArgs)
	if spell.name == 'Radial Arcana' and sets.precast.JA['Radial Arcana'] then
		equip(sets.precast.JA['Radial Arcana'])
	end
end

function job_aftercast(spell, spellMap, eventArgs)
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        elseif spell.skill == 'Elemental Magic' and state.MagicBurstMode.value == 'Single' then
            state.MagicBurstMode:reset()
			if state.DisplayMode.value then update_job_states()	end
		end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)

    if player.indi and not classes.CustomIdleGroups:contains('Indi') then
        classes.CustomIdleGroups:append('Indi')
        if not midaction () then handle_equipping_gear(player.status) end
    elseif classes.CustomIdleGroups:contains('Indi') and not player.indi then
        classes.CustomIdleGroups:clear()
        if not midaction () then handle_equipping_gear(player.status) end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function job_get_spell_map(spell, default_spell_map)

	if  default_spell_map == 'Cure' or default_spell_map == 'Curaga'  then
		if world.weather_element == 'Light' then
                return 'LightWeatherCure'
		elseif world.day_element == 'Light' then
                return 'LightDayCure'
        end

	elseif spell.skill == "Enfeebling Magic" then
		if spell.english:startswith('Dia') then
			return "Dia"
		elseif spell.type == "WhiteMagic" then
			return "MndEnfeebles"
		else
			return "IntEnfeebles"
		end
		
	elseif spell.skill == 'Geomancy' then
		if spell.english:startswith('Indi') then
			return 'Indi'
		end
	
    elseif spell.skill == 'Elemental Magic' then
		if default_spell_map == 'ElementalEnfeeble' or spell.english:contains('helix') then
			return
        elseif LowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
	end
	
end

function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    classes.CustomIdleGroups:clear()
    if player.indi then
        classes.CustomIdleGroups:append('Indi')
    end
	
end

-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

function job_self_command(commandArgs, eventArgs)
		if commandArgs[1] == 'autoindi' and commandArgs[2] then
			indispell = commandArgs[2]:ucfirst()
			add_to_chat(122,'Your Auto Indi- spell is set to '..indispell..'.')
			if state.DisplayMode.value then update_job_states()	end
		elseif commandArgs[1] == 'autogeo' and commandArgs[2] then
			geospell = commandArgs[2]:ucfirst()
			add_to_chat(122,'Your Auto Geo- spell is set to '..geospell..'.')
			if state.DisplayMode.value then update_job_states()	end
		elseif commandArgs[1]:lower() == 'elemental' then
			handle_elemental(commandArgs)
			eventArgs.handled = true			
		end
end

-- Handling Elemental spells within Gearswap.
-- Format: gs c elemental <nuke, helix, skillchain1, skillchain2, weather>
function handle_elemental(cmdParams)
    -- cmdParams[1] == 'elemental'
    -- cmdParams[2] == ability to use

    if not cmdParams[2] then
        add_to_chat(123,'Error: No elemental command given.')
        return
    end
    local strategem = cmdParams[2]:lower()

    if strategem == 'nuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Fire' then
			if spell_recasts[148] == 0 then
				send_command('input /ma "Fire V" <t>')
			elseif spell_recasts[147] == 0 then
				send_command('input /ma "Fire IV" <t>')
			elseif spell_recasts[146] == 0 then
				send_command('input /ma "Fire III" <t>')
			elseif spell_recasts[145] == 0 then
				send_command('input /ma "Fire II" <t>')
			elseif spell_recasts[144] == 0 then
				send_command('input /ma "Fire" <t>')
			end
			
		elseif state.ElementalMode.value == 'Wind' then
			if spell_recasts[158] == 0 then
				send_command('input /ma "Aero V" <t>')
			elseif spell_recasts[157] == 0 then
				send_command('input /ma "Aero IV" <t>')
			elseif spell_recasts[156] == 0 then
				send_command('input /ma "Aero III" <t>')
			elseif spell_recasts[155] == 0 then
				send_command('input /ma "Aero II" <t>')
			elseif spell_recasts[154] == 0 then
				send_command('input /ma "Aero" <t>')
			end
			
		elseif state.ElementalMode.value == 'Lightning' then
			if spell_recasts[168] == 0 then
				send_command('input /ma "Thunder V" <t>')
			elseif spell_recasts[167] == 0 then
				send_command('input /ma "Thunder IV" <t>')
			elseif spell_recasts[166] == 0 then
				send_command('input /ma "Thunder III" <t>')
			elseif spell_recasts[165] == 0 then
				send_command('input /ma "Thunder II" <t>')
			elseif spell_recasts[164] == 0 then
				send_command('input /ma "Thunder" <t>')
			end

		elseif state.ElementalMode.value == 'Earth' then
			if spell_recasts[163] == 0 then
				send_command('input /ma "Stone V" <t>')
			elseif spell_recasts[162] == 0 then
				send_command('input /ma "Stone IV" <t>')
			elseif spell_recasts[161] == 0 then
				send_command('input /ma "Stone III" <t>')
			elseif spell_recasts[160] == 0 then
				send_command('input /ma "Stone II" <t>')
			elseif spell_recasts[159] == 0 then
				send_command('input /ma "Stone" <t>')
			end
			
		elseif state.ElementalMode.value == 'Ice' then
			if spell_recasts[153] == 0 then
				send_command('input /ma "Blizzard V" <t>')
			elseif spell_recasts[152] == 0 then
				send_command('input /ma "Blizzard IV" <t>')
			elseif spell_recasts[151] == 0 then
				send_command('input /ma "Blizzard III" <t>')
			elseif spell_recasts[150] == 0 then
				send_command('input /ma "Blizzard II" <t>')
			elseif spell_recasts[149] == 0 then
				send_command('input /ma "Blizzard" <t>')
			end
		
		elseif state.ElementalMode.value == 'Water' then
			if spell_recasts[173] == 0 then
				send_command('input /ma "Water V" <t>')
			elseif spell_recasts[172] == 0 then
				send_command('input /ma "Water IV" <t>')
			elseif spell_recasts[171] == 0 then
				send_command('input /ma "Water III" <t>')
			elseif spell_recasts[170] == 0 then
				send_command('input /ma "Water II" <t>')
			elseif spell_recasts[169] == 0 then
				send_command('input /ma "Water" <t>')
			end
			
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There are no light nukes.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There are no dark nukes.')
		end
		
	elseif strategem == 'smallnuke' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Fire' then
			if spell_recasts[145] == 0 then
				send_command('input /ma "Fire II" <t>')
			elseif spell_recasts[144] == 0 then
				send_command('input /ma "Fire" <t>')
			end
			
		elseif state.ElementalMode.value == 'Wind' then
			if spell_recasts[155] == 0 then
				send_command('input /ma "Aero II" <t>')
			elseif spell_recasts[154] == 0 then
				send_command('input /ma "Aero" <t>')
			end
			
		elseif state.ElementalMode.value == 'Lightning' then
			if spell_recasts[165] == 0 then
				send_command('input /ma "Thunder II" <t>')
			elseif spell_recasts[164] == 0 then
				send_command('input /ma "Thunder" <t>')
			end

		elseif state.ElementalMode.value == 'Earth' then
			if spell_recasts[160] == 0 then
				send_command('input /ma "Stone II" <t>')
			elseif spell_recasts[159] == 0 then
				send_command('input /ma "Stone" <t>')
			end
			
		elseif state.ElementalMode.value == 'Ice' then
			if spell_recasts[150] == 0 then
				send_command('input /ma "Blizzard II" <t>')
			elseif spell_recasts[149] == 0 then
				send_command('input /ma "Blizzard" <t>')
			end
		
		elseif state.ElementalMode.value == 'Water' then
			if spell_recasts[170] == 0 then
				send_command('input /ma "Water II" <t>')
			elseif spell_recasts[169] == 0 then
				send_command('input /ma "Water" <t>')
			end
			
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There are no light nukes.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There are no dark nukes.')
		end

	elseif strategem == 'tier1' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fire" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aero" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thunder" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stone" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzard" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Water" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Banish" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			send_command('input /ma "Bio" <t>')
		end
		
	elseif strategem == 'tier2' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fire II" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aero II" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thunder II" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stone II" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzard II" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Water II" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Banish II" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			send_command('input /ma "Bio II" <t>')
		end
		
	elseif strategem == 'tier3' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fire III" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aero III" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thunder III" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stone III" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzard III" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Water III" <t>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light tier III.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark tier III.')
		end
		
	elseif strategem == 'tier4' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fire IV" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aero IV" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thunder IV" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stone IV" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzard IV" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Water IV" <t>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light tier IV.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark tier IV.')
		end
		
	elseif strategem == 'tier5' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fire V" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aero V" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thunder V" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stone V" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzard V" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Water V" <t>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light tier V.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark tier V.')
		end
		
	elseif strategem == 'aga' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Firaga" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aeroga" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thundaga" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stonega" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzaga" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Waterga" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Banishga" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark -aja.')
		end
		
	elseif strategem == 'aga2' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Firaga II" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aeroga II" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thundaga II" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stonega II" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzaga II" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Waterga II" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Banishga II" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark -aja.')
		end
		
	elseif strategem == 'ara' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Fire' then
			if spell_recasts[865] == 0 then
				send_command('input /ma "Fira III" <t>')
			elseif spell_recasts[829] == 0 then
				send_command('input /ma "Fira II" <t>')
			elseif spell_recasts[828] == 0 then
				send_command('input /ma "Fira" <t>')
			end
			
		elseif state.ElementalMode.value == 'Wind' then
			if spell_recasts[867] == 0 then
				send_command('input /ma "Aera III" <t>')
			elseif spell_recasts[833] == 0 then
				send_command('input /ma "Aera II" <t>')
			elseif spell_recasts[832] == 0 then
				send_command('input /ma "Aera" <t>')
			end
			
		elseif state.ElementalMode.value == 'Lightning' then
			if spell_recasts[869] == 0 then
				send_command('input /ma "Thundara III" <t>')
			elseif spell_recasts[837] == 0 then
				send_command('input /ma "Thundara II" <t>')
			elseif spell_recasts[836] == 0 then
				send_command('input /ma "Thundara" <t>')
			end

		elseif state.ElementalMode.value == 'Earth' then
			if spell_recasts[868] == 0 then
				send_command('input /ma "Stonera III" <t>')
			elseif spell_recasts[835] == 0 then
				send_command('input /ma "Stonera II" <t>')
			elseif spell_recasts[834] == 0 then
				send_command('input /ma "Stonera" <t>')
			end
			
		elseif state.ElementalMode.value == 'Ice' then
			if spell_recasts[866] == 0 then
				send_command('input /ma "Blizzara III" <t>')
			elseif spell_recasts[831] == 0 then
				send_command('input /ma "Blizzara II" <t>')
			elseif spell_recasts[830] == 0 then
				send_command('input /ma "Blizzara" <t>')
			end
		
		elseif state.ElementalMode.value == 'Water' then
			if spell_recasts[870] == 0 then
				send_command('input /ma "Watera III" <t>')
			elseif spell_recasts[839] == 0 then
				send_command('input /ma "Watera II" <t>')
			elseif spell_recasts[838] == 0 then
				send_command('input /ma "Watera" <t>')
			end
			
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There are no light -ara spells.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There are no dark -ara spells.')
		end
		
	elseif strategem == 'ara1' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fira" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aera" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thundara" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stonera" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzara" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Watera" <t>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light -ara spells.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark -ara spells.')
		end

	elseif strategem == 'ara2' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fira II" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aera II" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thundara II" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stonera II" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzara II" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Watera II" <t>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light -ara spells.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark -ara spells.')
		end
		
	elseif strategem == 'ara3' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Fira III" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Aera III" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Thundara III" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Stonera III" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Blizzara III" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Watera III" <t>')
		elseif state.ElementalMode.value == 'Light' then
			add_to_chat(123,'Error: There is no light -ara spells.')
		elseif state.ElementalMode.value == 'Dark' then
			add_to_chat(123,'Error: There is no dark -ara spells.')
		end
		
	elseif strategem == 'helix' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Pyrohelix" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Anemohelix" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Ionohelix" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Luminohelix" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Geohelix" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Cryohelix" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Hydrohelix" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			send_command('input /ma "Noctohelix" <t>')
		end
	
	elseif strategem == 'enfeeble' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Burn" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Choke" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Shock" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Rasp" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Frost" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Drown" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Dia II" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			send_command('input /ma "Blind" <t>')
		end
	
	elseif strategem == 'bardsong' then
		if state.ElementalMode.value == 'Fire' then
			send_command('input /ma "Ice Threnody" <t>')
		elseif state.ElementalMode.value == 'Wind' then
			send_command('input /ma "Earth Threnody" <t>')
		elseif state.ElementalMode.value == 'Lightning' then
			send_command('input /ma "Water Threnody" <t>')
		elseif state.ElementalMode.value == 'Earth' then
			send_command('input /ma "Ltng. Threnody" <t>')
		elseif state.ElementalMode.value == 'Ice' then
			send_command('input /ma "Wind Threnody" <t>')
		elseif state.ElementalMode.value == 'Water' then
			send_command('input /ma "Fire Threnody" <t>')
		elseif state.ElementalMode.value == 'Light' then
			send_command('input /ma "Dark Threnody" <t>')
		elseif state.ElementalMode.value == 'Dark' then
			send_command('input /ma "Light Threnody" <t>')
		end

	--Leave out target, let shortcuts auto-determine it.
	elseif strategem == 'weather' then
		local spell_recasts = windower.ffxi.get_spell_recasts()
		
		if state.ElementalMode.value == 'Fire' then
			if player.target.index == player.index and buffactive['Firestorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Firestorm"')
			end
		elseif state.ElementalMode.value == 'Wind' then
			if player.target.index == player.index and buffactive['Windstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Windstorm"')
			end
		elseif state.ElementalMode.value == 'Lightning' then
			if player.target.index == player.index and buffactive['Thunderstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Thunderstorm"')
			end
		elseif state.ElementalMode.value == 'Light' then
			if player.target.index == player.index and buffactive['Aurorastorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Aurorastorm"')
			end
		elseif state.ElementalMode.value == 'Earth' then
			if player.target.index == player.index and buffactive['Sandstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Sandstorm"')
			end
		elseif state.ElementalMode.value == 'Ice' then
			if player.target.index == player.index and buffactive['Hailstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Hailstorm"')
			end
		elseif state.ElementalMode.value == 'Water' then
			if player.target.index == player.index and buffactive['Rainstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Rainstorm"')
			end
		elseif state.ElementalMode.value == 'Dark' then
			if player.target.index == player.index and buffactive['Voidstorm'] and not buffactive['Klimaform'] and spell_recasts[287] == 0 then
				send_command('input /ma "Klimaform" <me>')
			else
				send_command('input /ma "Voidstorm"')
			end
		end
	
    else
        add_to_chat(123,'Unrecognized elemental command.')
    end
end

function job_tick()
	if check_geo() then return true end
	return false
end

function check_geo()
	if state.AutoBuffMode.value and not moving and not areas.Cities:contains(world.area) then
		if not player.indi then
			windower.send_command('input /ma "Indi-'..indispell..'" <me>')
			tickdelay = 1260
			return true 
		elseif not pet.isvalid then
			windower.send_command('input /ma "Geo-'..geospell..'" <bt>')
			tickdelay = 1260
			return true
		else
			return false
		end
	else
		return false
	end
end