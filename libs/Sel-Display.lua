----------------------------------------------------------------------------------------------------
-- Job State Display -- Originally written by Talym, modified by Selindrile.
----------------------------------------------------------------------------------------------------
-- Creates a customizable visual job state display for states managed by Modes.lua
--
-- Include in get_sets(), user_setup(), etc, or custom include file
--
-- By default, supports the following modal states:
-- OffenseMode, DefenseMode, HybridMode, IdleMode, WeaponskillMode, CastingMode,
-- MainStep, AltStep, TreasureMode, TotalHaste, DelayReduction
--
-- Additional modal states can be supported by defining a label mapping in update_job_states()
-- Boolean states require no modifications
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Initialize display
-- Call after defining job states in get_sets(), user_setup(), etc.
--
-- required     job_bools   List of boolean-type states to manage
-- required     job_modes   List of modal-type states to manage
--
-- EXAMPLE
-- function user_setup()
--      state.MagicBurst = M(false, 'Magic Burst')
--      state.CastingMode:options('Normal', 'Death')
--      state.IdleMode:options('Normal', 'Death')
--      init_job_states({"MagicBurst"},{"CastingMode","IdleMode"})
-- end
----------------------------------------------------------------------------------------------------
function init_job_states(job_bools,job_modes)

    stateList = job_modes
    stateBool = job_bools

    if stateBox then stateBox:destroy() end

    local settings = windower.get_windower_settings()
	local x,y
	
	if displayx and displayy then
		x = displayx
		y = displayy
	elseif settings["ui_x_res"] == 1920 and settings["ui_y_res"] == 1080 then
		x,y = settings["ui_x_res"]-1917, settings["ui_y_res"]-18 -- -285, -18
	else
		x,y = 0, settings["ui_y_res"]-17 -- -285, -18
	end
	
    stateBox = texts.new()
    stateBox:pos(x,y)
    stateBox:font('Arial')--Arial
    stateBox:size(12)
    stateBox:bold(true)
    stateBox:bg_alpha(0)--128
    stateBox:right_justified(false)
    stateBox:stroke_width(2)
    stateBox:stroke_transparency(192)

    update_job_states(stateBox)

end

----------------------------------------------------------------------------------------------------
-- Update display
-- Call from state_change(), job_state_change(), etc.
----------------------------------------------------------------------------------------------------
function update_job_states()

	if not state.DisplayMode.value then
		if stateBox then stateBox:hide() end
		return		
	end

    -- Define colors for text in the display
    local clr = {
        h='\\cs(255,192,0)', -- Yellow for active booleans and non-default modals
		w='\\cs(255,255,255)', -- White for labels and default modals
        n='\\cs(192,192,192)', -- White for labels and default modals
        s='\\cs(96,96,96)' -- Gray for inactive booleans
    }

    local info = {}
    local orig = {}
    local spc = '   '

    -- Define labels for each modal state
    local labels = {
        OffenseMode = "Offense",
		RangedMode = "Ranged",
        DefenseMode = "Defense",
        HybridMode = "Hybrid",
        IdleMode = "Idle",
        WeaponskillMode = "Weaponskill",
        CastingMode = "Casting",
        MainStep = "Main Step",
        AltStep = "Alt Step",
        TreasureMode = "Treasure",
        TotalHaste = "Haste",
        DelayReduction = "Delay",
		LearningMode = "Learning",
		MagicBurstMode = "Magic Burst",
		RecoverMode = "Recover MP",
		ElementalMode = "Element",
		ExtraSongsMode = "Songs",
		AutoStunMode = "Auto Stun",
		LuzafRing = "Luzaf's Ring",
		AutoDefenseMode = "Auto Defense",
		AutoTrustMode = "Auto Trust",
		JugMode = "Pet",
		RewardMode = "Reward",
		AutoNukeMode = "Auto Nuke: "..autonuke.."",
		AutoBuffMode = "Auto Buff",
		AutoWSMode = "Auto WS: "..autows..": "..autowstp.."",
		AutoFoodMode = "Auto Food: "..autofood.."",
		AutoShootMode = "Auto Shoot",
		Capacity = "Capacity",
		AutoTankMode = "Auto Tank",
		PhysicalDefenseMode = "Physical Defense",
		MagicalDefenseMode = "Magical Defense",
		ResistDefenseMode = "Resist Defense",
		RuneElement = "Rune Element",
		AutoReadyMode = "Auto Ready",
		PactSpamMode = "Pact Spam",
    }

    stateBox:clear()
	stateBox:append(spc)

    -- Construct and append info for boolean states
    for i,n in pairs(stateBool) do

        -- Define color for modal state
        if state[n].index then
			if n == 'AutoBuffMode' then
				if player.main_job == 'GEO' then
					stateBox:append("Auto Buff: Indi-"..indispell.." Geo-"..geospell.."")
				end
			else
				stateBox:append(clr.h..labels[n]..clr.n)
			end
			stateBox:append(spc)
		else

		end

        -- Append basic formatted boolean state

    end
		stateBox:append(clr.w)
    -- Construct and append info for modal states
    for i,n in ipairs(stateList) do

        -- Format total haste and delay reduction as percentages
        if n == 'TotalHaste' or n == 'DelayReduction' then
            info[n] = state[n]..'%'
            orig[n] = '0%'
        else
            info[n] = state[n].current
            orig[n] = state[n][1]
        end
        if info[n] ~= orig[n] then
            info[n] = clr.h..info[n]..clr.n
        end

        -- Append basic formatted modal state


        -- Add additional information for active hybrid defense mode
		if n == 'OffenseMode' then
			if state.DefenseMode.value ~= 'None' then
				stateBox:append(string.format("%sDefense Active: ", clr.w))
				if state.DefenseMode.value == 'Physical' then
					stateBox:append(string.format("%s%s: %s%s", clr.h, state.DefenseMode.current, state.PhysicalDefenseMode.current, clr.s))
				elseif state.DefenseMode.value == 'Magical' then
					stateBox:append(string.format("%s%s: %s%s", clr.h, state.DefenseMode.current, state.MagicalDefenseMode.current, clr.s))
				elseif state.DefenseMode.value == 'Resist' then
					stateBox:append(string.format("%s%s: %s%s", clr.h, state.DefenseMode.current, state.ResistDefenseMode.current, clr.s))
				end
				if state.ExtraDefenseMode and state.ExtraDefenseMode.value ~= 'None' then
					stateBox:append(string.format("%s / %s%s%s", clr.n, clr.h, state.ExtraDefenseMode.current, clr.n))
				end
			else
				stateBox:append(string.format("%s: ${%s}", labels[n], n))
				if state.HybridMode then
					if state.HybridMode.value == 'Normal' then
						stateBox:append(string.format("%s / %s%s%s", clr.n, clr.w, state.HybridMode.current, clr.n))
					else
						stateBox:append(string.format("%s / %s%s%s", clr.n, clr.h, state.HybridMode.current, clr.n))
					end
				end
				if state.ExtraMeleeMode then
					if state.ExtraMeleeMode.value == 'None' then
						stateBox:append(string.format("%s / %s%s%s", clr.n, clr.w, state.ExtraMeleeMode.current, clr.n))
					else
						stateBox:append(string.format("%s / %s%s%s", clr.n, clr.h, state.ExtraMeleeMode.current, clr.n))
					end
				end
			end
		elseif n == 'IdleMode' then
			if state.IdleMode.value ~= 'Normal' and state.DefenseMode.value == 'None' then
				stateBox:append(string.format("%s%s: ${%s}", clr.w, labels[n], n))
			end
			if state.Kiting.value then
				stateBox:append(string.format("   %sKiting: %sOn", clr.w, clr.h))
			end
		elseif n == 'TreasureMode' then
			if state.TreasureMode.value ~= 'None' and state.DefenseMode.value == 'None' then
				stateBox:append(string.format("%s   Treasure: %s%s", clr.w, clr.h, state.TreasureMode.value))
			end
		elseif n == 'CastingMode' then
			stateBox:append(string.format("%s%s: ${%s}", clr.w, labels[n], n))
			if state.MagicBurstMode.value ~= 'Off' then
				stateBox:append(string.format("%s   Magic Burst: %s%s", clr.w, clr.h, state.MagicBurstMode.value))
			end
			if state.DeathMode and state.DeathMode.value ~= 'Off' then
				stateBox:append(string.format("   %sDeath Mode: %s%s", clr.w, clr.h, state.DeathMode.value))
			end
		elseif n == 'WeaponskillMode' then
			if state.WeaponskillMode.value ~= 'Normal' then
				stateBox:append(string.format("%s   Weaponskill: %s%s", clr.w, clr.h, state.WeaponskillMode.value))
			end
		elseif n == 'ElementalMode' then
				stateBox:append(string.format("%sElement: %s%s", clr.w, clr.h, state.ElementalMode.value))
		elseif n == 'RuneElement' then
				stateBox:append(string.format("%sElement: %s%s", clr.w, clr.h, state.RuneElement.value))
		elseif n == 'LearningMode' then
			if state.LearningMode.value and state.DefenseMode.value == 'None' then
				stateBox:append(string.format("%sLearning Mode: %sOn", clr.w, clr.h))
			end
		elseif n == 'ExtraSongsMode' then
			if state.ExtraSongsMode.value ~= "None" then
				stateBox:append(string.format("%sSongs: %s%s", clr.w, clr.h, state.ExtraSongsMode.value))
			end
		else
			stateBox:append(string.format("%s%s: ${%s}", clr.w, labels[n], n))
		end

        stateBox:append(spc)
    end
	
	if state.ExtraDefenseMode and state.ExtraDefenseMode.value ~= 'None' and state.DefenseMode.value == 'None' then
		stateBox:append(string.format("%sExtra Defense: %s%s", clr.w, clr.h, state.ExtraDefenseMode.value))
	end
    -- Update and display current info
    stateBox:update(info)
    stateBox:show()

end

----------------------------------------------------------------------------------------------------
-- Clean up display objects
-- Call from file_unload(), user_unload(), etc.
----------------------------------------------------------------------------------------------------
function clear_job_states()

    if stateBox then stateBox:destroy() end

end


windower.raw_register_event('outgoing chunk', function(id, data)
    if id == 0x00D and stateBox then
        stateBox:hide()
    end
end)

windower.raw_register_event('incoming chunk', function(id, data)
    if id == 0x00A and stateBox and state.DisplayMode.value then
        stateBox:show()
    end
end)
