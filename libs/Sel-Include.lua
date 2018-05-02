-------------------------------------------------------------------------------------------------------------------
-- Much of these files have been adapted from Motenten's base files, much credit goes to him,
-- I have started to rename his files so that they don't get modified whenever the Windower
-- team very rarely decides to update his old files.
-- Common variables and functions to be included in job scripts, for general default handling.
--
-- Include this file in the get_sets() function with the command:
-- include('Sel-Include.lua')
--
-- It will then automatically run its own init_include() function.
--
-- IMPORTANT: This include requires supporting include files:
-- Sel-Utility
-- Sel-Mappings
-- Sel-SelfCommands
-- Sel-Globals
--
-- Place the include() directive at the start of a job's get_sets() function.
--
-- Included variables and functions are considered to be at the same scope level as
-- the job script itself, and can be used as such.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines variables to be used.
-- These are accessible at the including job lua script's scope.
--
-- Auto-initialize after defining this function.
-------------------------------------------------------------------------------------------------------------------

function init_include()
	extdata = require("extdata")
	res = require ("resources")

    -- Used to define various types of data mappings.  These may be used in the initialization, so load it up front.
    include('Sel-Mappings')
    
    -- Modes is the include for a mode-tracking variable class.  Used for state vars, below.
    include('Modes')
	
	-- Adding Organizer for gear management.
	include('organizer-lib.lua')
	
    -- Var for tracking state values
    state = {}

	--My Auto-Stun/Reaction module for gearswap, must come after state is defined.
	include('Sel-Stahp.lua')
	
	--Making Extdata/Resources dependant functions work
	cp_delay = 20

    -- General melee offense/defense modes, allowing for hybrid set builds, as well as idle/resting/weaponskill.
    -- This just defines the vars and sets the descriptions.  List modes with no values automatically
    -- get assigned a 'Normal' default value.
    state.OffenseMode         = M{['description'] = 'Offense Mode'}
    state.HybridMode          = M{['description'] = 'Hybrid Mode'}
    state.RangedMode          = M{['description'] = 'Ranged Mode'}
    state.WeaponskillMode     = M{['description'] = 'Weaponskill Mode'}
    state.CastingMode         = M{['description'] = 'Casting Mode'}
    state.IdleMode            = M{['description'] = 'Idle Mode'}
    state.RestingMode         = M{['description'] = 'Resting Mode'}

    state.DefenseMode         = M{['description'] = 'Defense Mode', 'None', 'Physical', 'Magical', 'Resist'}
    state.PhysicalDefenseMode = M{['description'] = 'Physical Defense Mode', 'PDT'}
    state.MagicalDefenseMode  = M{['description'] = 'Magical Defense Mode', 'MDT'}
	state.ResistDefenseMode   = M{['description'] = 'Resistance Defense Mode', 'MEVA'}

    state.Kiting              = M(false, 'Kiting')
    state.SelectNPCTargets    = M(false, 'Select NPC Targets')
	state.Capacity 			  = M(false, 'Capacity Mode')
	state.ReEquip 			  = M(false, 'ReEquip Mode')
	state.AutoArts	 		  = M(false, 'AutoArts Mode')
	state.AutoTrustMode 	  = M(false, 'Auto Trust Mode')
	state.AutoTankMode 		  = M(false, 'Auto Tank Mode')
	state.AutoNukeMode 		  = M(false, 'Auto Nuke Mode')
	state.AutoRuneMode 		  = M(false, 'Auto Rune Mode')
	state.AutoWSMode		  = M(false, 'Auto Weaponskill Mode')
	state.AutoFoodMode		  = M(false, 'Auto Food Mode')
	state.AutoShootMode 	  = M(false, 'Auto Shoot Mode')
	state.AutoSubMode 		  = M(false, 'Auto Sublimation Mode')
	state.AutoBuffMode 		  = M(false, 'Auto Buff Mode')
	state.AutoCleanupMode  	  = M(false, 'Auto Cleanup Mode')
	state.DisplayMode  	  	  = M(true, 'Display Mode')
	state.CancelStoneskin	  = M(true, 'Stoneskin Cancel Mode')
	
	state.RuneElement 		  = M{['description'] = 'Rune Element','Ignis','Gelus','Flabra','Tellus','Sulpor','Unda','Lux','Tenebrae'}
	state.ElementalMode 	  = M{['description'] = 'Elemental Mode', 'Fire','Ice','Wind','Earth','Lightning','Water','Light','Dark'}

	state.MagicBurstMode 	  = M{['description'] = 'Magic Burst Mode', 'Off', 'Single', 'Lock'}
	state.SkillchainMode 	  = M{['description'] = 'Skillchain Mode', 'Off', 'Single', 'Lock'}
    state.PCTargetMode        = M{['description'] = 'PC Target Mode', 'default', 'stpt', 'stal', 'stpc'}

    state.EquipStop           = M{['description'] = 'Stop Equipping Gear', 'off', 'precast', 'midcast', 'pet_midcast'}

    state.CombatWeapon        = M{['description']='Combat Weapon', ['string']=''}
    state.CombatForm          = M{['description']='Combat Form', ['string']=''}
	
    -- Non-mode vars that are used for state tracking.
    state.MaxWeaponskillDistance = 0
    state.Buff = {}

    -- Classes describe a 'type' of action.  They are similar to state, but
    -- may have any free-form value, or describe an entire table of mapped values.
    classes = {}
    -- Basic spell mappings are based on common spell series.
    -- EG: 'Cure' for Cure, Cure II, Cure III, Cure IV, Cure V, or Cure VI.
    classes.SpellMaps = spell_maps
    -- List of spells and spell maps that don't benefit from greater skill (though
    -- they may benefit from spell-specific augments, such as improved regen or refresh).
    -- Spells that fall under this category will be skipped when searching for
    -- spell.skill sets.
    classes.NoSkillSpells = no_skill_spells_list
    classes.SkipSkillCheck = false
    -- Custom, job-defined class, like the generic spell mappings.
    -- Takes precedence over default spell maps.
    -- Is reset at the end of each spell casting cycle (ie: at the end of aftercast).
    classes.JAMode = nil
    classes.CustomClass = nil
    -- Custom groups used for defining melee and idle sets.  Persists long-term.
    classes.CustomMeleeGroups = L{}
    classes.CustomRangedGroups = L{}
    classes.CustomIdleGroups = L{}
    classes.CustomDefenseGroups = L{}

    -- Class variables for time-based flags
    classes.Daytime = false
    classes.DuskToDawn = false
	
    -- Var for tracking misc info
    info = {}
    options = {}

    -- Special control flags.
    mote_vars = {}
    mote_vars.set_breadcrumbs = L{}
    mote_vars.res_buffs = S{}
    for index,struct in pairs(gearswap.res.buffs) do
        mote_vars.res_buffs:add(struct.en)
    end
	
	-- Define and default variables for auto-modes.
	autonuke = 'Fire'
	autows = ''
	autowstp = 1000
	utsusemi_cancel_delay = .5
	
    -- Sub-tables within the sets table that we expect to exist, and are annoying to have to
    -- define within each individual job file.  We can define them here to make sure we don't
    -- have to check for existence.  The job file should be including this before defining
    -- any sets, so any changes it makes will override these anyway.
    sets.precast = {}
    sets.precast.FC = {}
    sets.precast.JA = {}
    sets.precast.WS = {}
    sets.precast.RA = {}
    sets.midcast = {}
    sets.midcast.RA = {}
    sets.midcast.Pet = {}
    sets.idle = {}
    sets.resting = {}
    sets.engaged = {}
    sets.defense = {}
    sets.buff = {}

	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}
	
    gear = {}
    gear.default = {}

    gear.ElementalGorget = {name=""}
    gear.ElementalBelt = {name=""}
    gear.ElementalObi = {name=""}
    gear.ElementalCape = {name=""}
    gear.ElementalRing = {name=""}
    gear.FastcastStaff = {name=""}
    gear.RecastStaff = {name=""}

    -- Load externally-defined information (info that we don't want to change every time this file is updated).

    -- Used to define misc utility functions that may be useful for this include or any job files.
    include('Sel-Utility')

    -- Used for all self-command handling.
    include('Sel-SelfCommands')
	include('Sel-TreasureHunter')

    -- Include general user globals, such as custom binds or gear tables.
    -- Load Sel-Globals first, followed by User-Globals, followed by <character>-Globals.
    -- Any functions re-defined in the later includes will overwrite the earlier versions.
    include('Sel-Globals')
    optional_include({'user-globals.lua'})
    optional_include({player.name..'-globals.lua'})
    optional_include({'user-items.lua'})
    optional_include({player.name..'-items.lua'})
	
	-- New Display functions, needs to come after globals for user settings.
	include('Sel-Display.lua')

    -- Sel-globals.lua may define additional sets to be added to the local ones.
    if define_universal_sets then
        define_universal_sets()
    end

    -- Global default binds (either from Sel-Globals or user-globals)
    (binds_on_load or global_on_load)()

    -- Load a sidecar file for the job (if it exists) that may re-define init_gear_sets and file_unload.
    load_sidecar(player.main_job)
	
	-- Controls for handling our autmatic functions.
	
	tickdelay = 0
	
	-- Movement Handling
	mov = {counter=0}

	if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
		mov.x = windower.ffxi.get_mob_by_index(player.index).x
		mov.y = windower.ffxi.get_mob_by_index(player.index).y
		mov.z = windower.ffxi.get_mob_by_index(player.index).z
	end

	moving = false
	
	windower.raw_register_event('prerender',function()
		mov.counter = mov.counter + 1;
		if mov.counter > 20 then
			local pl = windower.ffxi.get_mob_by_index(player.index)
			if pl and pl.x and mov.x then
				dist = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 )
				if dist > .1 and not moving then
					send_command('gs c moving')
					moving = true
				elseif dist < .1 and moving then
					send_command('gs c stopping')
					moving = false
				end
			end
			if pl and pl.x then
				mov.x = pl.x
			
			mov.y = pl.y
				mov.z = pl.z
			end
			mov.counter = 0
		end
	end)
		
    -- General var initialization and setup.
    if job_setup then
        job_setup()
    end

    -- User-specific var initialization and setup.
    if user_setup then
        user_setup()
    end
	
	if extra_user_setup then
        extra_user_setup()
    end

	-- Event register to make time variables track.
	windower.register_event('time change', time_change)

	-- Event register to prevent auto-modes from spamming after zoning.
	windower.register_event('zone change', function()
		tickdelay = 0
		state.AutoBuffMode:reset()
		state.AutoShootMode:reset()
		state.AutoSubMode:reset()
		state.AutoTrustMode:reset()
		state.AutoTankMode:reset()
		state.AutoNukeMode:reset()
		if state.DisplayMode.value then update_job_states()	end
	end)

	-- New implementation of tick.
	windower.raw_register_event('prerender', function()
		tickdelay = tickdelay + 1
	
		if not (tickdelay > 1350) then return end
		
		local in_action, tickspell = midaction()
		if in_action and tickspell.action_type ~= 'Ranged Attack' then return end

		gearswap.refresh_globals(false)
		if (player ~= nil) and (player.status == 'Idle' or player.status == 'Engaged') and not (moving or buffactive['Sneak'] or buffactive['Invisible'] or silent_check_disable()) then
			if pre_tick then
				if pre_tick() then return end
			end
			
			if user_tick then
				if user_tick() then return end
			end
			
			if job_tick then
				if job_tick() then return end
			end
			
			if user_job_tick then
				if user_job_tick() then return end
			end

			if default_tick then
				if default_tick() then return end
			end			
		
			if extra_user_tick then
				if extra_user_tick() then return end
			end
			
		end
		
		tickdelay = 1320

	end)
	
    -- Load up all the gear sets.
    init_gear_sets()
end

-- Called when this job file is unloaded (eg: job change)
-- Conditional definition so that it doesn't overwrite explicit user
-- versions of this function.
if not file_unload then
    file_unload = function()
        if user_unload then
            user_unload()
		end
		
        if job_unload then
            job_unload()
        end
		
		global_unload()
    end
end

-- Function to bind GearSwap binds when loading a GS script, moved to globals to seperate per character and user.
function global_on_load()
		send_command('@wait 3;gs c weapons')
end

-- Function to revert binds when unloading.
function global_unload()
	send_command('unbind ^f8')
	send_command('unbind !f8')
	send_command('unbind @f8')
	send_command('unbind f9')
	send_command('unbind ^f9')
	send_command('unbind !f9')
	send_command('unbind @f9')
	send_command('unbind f10')
	send_command('unbind ^f10')
	send_command('unbind !f10')
	send_command('unbind @f10')
	send_command('unbind f11')
	send_command('unbind ^f11')
	send_command('unbind !f11')
	send_command('unbind @f11')
	send_command('unbind f12')
	send_command('unbind ^f12')
	send_command('unbind !f12')
	send_command('unbind @f12')
	send_command('unbind ^@!pause')
	send_command('unbind ^pause')
	send_command('unbind !pause')
	send_command('unbind @pause')
	send_command('unbind ^@!pause')

	send_command('unbind ^\\\\')
	send_command('unbind @\\\\')
	send_command('unbind !\\\\')

	send_command('unbind ^`')
	send_command('unbind !`')
	send_command('unbind @`')

	send_command('unbind ^backspace')
	send_command('unbind !backspace')
	send_command('unbind @backspace')

	send_command('unbind ^r')
	send_command('unbind !r')
	send_command('unbind @r')

	send_command('unbind ^y')
	send_command('unbind !y')
	send_command('unbind @y')

	send_command('unbind ^q')
	send_command('unbind !q')
	send_command('unbind @q')
	
	send_command('unbind ^-')
	send_command('unbind !-')
	send_command('unbind @-')

	send_command('unbind ^=')
	send_command('unbind !=')
	send_command('unbind @=')

	send_command('unbind ^delete')
	send_command('unbind !delete')
	send_command('unbind @delete')
	
	if clear_job_states() then
		clear_job_states()
	end		
end

-------------------------------------------------------------------------------------------------------------------
-- Generalized functions for handling precast/midcast/aftercast for player-initiated actions.
-- This depends on proper set naming.
-- Global hooks can be written as user_xxx() to override functions at a global level.
-- Each job can override any of these general functions using job_xxx() hooks.
-------------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------
-- Generic function to map a set processing order to all action events.
------------------------------------------------------------------------


-- Process actions in a specific order of events:
-- Filter  - filter_xxx() functions determine whether to run any of the code for this action.
-- Global  - user_xxx() functions get called first.  Define in Sel-Globals or User-Globals.
-- Local   - job_xxx() functions get called next. Define in JOB.lua file.
-- Default - default_xxx() functions get called next. Defined in this file.
-- Cleanup - cleanup_xxx() functions always get called before exiting.
--
-- Parameters:
-- spell - standard spell table passed in by GearSwap
-- action - string defining the function mapping to use (precast, midcast, etc)
function handle_actions(spell, action)
    -- Init an eventArgs that allows cancelling.
    local eventArgs = {handled = false, cancel = false}
    
    mote_vars.set_breadcrumbs:clear()

    -- Get the spell mapping, since we'll be passing it to various functions and checks.
    local spellMap = get_spell_map(spell)
	gearswap.refresh_globals(false)

    -- General filter checks to see whether this function should be run.
    -- If eventArgs.cancel is set, cancels this function, not the spell.
    if _G['user_filter_'..action] then
        _G['user_filter_'..action](spell, spellMap, eventArgs)
		
		if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
			cancel_spell()
		end
    end
	
    if _G['user_job_filter_'..action] and not eventArgs.cancel then
        _G['user_job_filter_'..action](spell, spellMap, eventArgs)
		
		if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
			cancel_spell()
		end
    end
	
    if _G['job_filter_'..action] and not eventArgs.cancel then
        _G['job_filter_'..action](spell, spellMap, eventArgs)
		
		if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
			cancel_spell()
		end
    end
	
    if _G['filter_'..action] and not eventArgs.cancel then
        _G['filter_'..action](spell, spellMap, eventArgs)
		
		if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
			cancel_spell()
		end
    end
	
    -- If filter didn't cancel it, process user and default actions.
    if not eventArgs.cancel then
        -- Global user handling of this action
        if _G['user_'..action] then
            _G['user_'..action](spell, spellMap, eventArgs)
            
            if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
                cancel_spell()
            end
        end
		
        -- Job-specific handling of this action
        if not eventArgs.cancel and not eventArgs.handled and _G['job_'..action] then
            _G['job_'..action](spell, spellMap, eventArgs)
            
            if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
                cancel_spell()
            end
        end
		
        if not eventArgs.cancel and not eventArgs.handled and _G['user_job_'..action] then
            _G['user_job_'..action](spell, spellMap, eventArgs)
            
            if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
                cancel_spell()
            end
        end
    
        -- Default handling of this action
        if not eventArgs.cancel and not eventArgs.handled and _G['default_'..action] then
            _G['default_'..action](spell, spellMap, eventArgs)
            display_breadcrumbs(spell, spellMap, action)
			
			if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
				cancel_spell()
			end
        end
		
        -- Global user handling of this action
        if _G['extra_user_'..action] then
            _G['extra_user_'..action](spell, spellMap, eventArgs)
            
            if eventArgs.cancel and (action == 'pretarget' or action == 'precast') then
                cancel_spell()
            end
        end
		
        -- Global post-handling of this action
        if not eventArgs.cancel and _G['user_post_'..action] then
            _G['user_post_'..action](spell, spellMap, eventArgs)
        end

       -- Job-specific post-handling of this action
        if not eventArgs.cancel and _G['job_post_'..action] then
            _G['job_post_'..action](spell, spellMap, eventArgs)
        end
		
        if not eventArgs.cancel and _G['user_job_post_'..action] then
            _G['user_job_post_'..action](spell, spellMap, eventArgs)
        end

        if not eventArgs.cancel and _G['default_post_'..action] then
            _G['default_post_'..action](spell, spellMap, eventArgs)
        end
		
        if not eventArgs.cancel and _G['extra_user_post_'..action] then
            _G['extra_user_post_'..action](spell, spellMap, eventArgs)
        end
		
    end

    -- Cleanup once this action is done
    if _G['cleanup_'..action] then
        _G['cleanup_'..action](spell, spellMap, eventArgs)
    end
end


--------------------------------------
-- Action hooks called by GearSwap.
--------------------------------------

function filtered_action(spell, eventArgs)
	local eventArgs = {cancel = false}

    -- Check users action filtering
    if not eventArgs.cancel and user_filtered_action then
        user_filtered_action(spell, eventArgs)
    end

    -- Check jobs action filtering
    if not eventArgs.cancel and user_job_filtered_action then
        user_job_filtered_action(spell, eventArgs)
    end
	
    -- Check jobs action filtering
    if not eventArgs.cancel and job_filtered_action then
        job_filtered_action(spell, eventArgs)
    end
	
    -- Check users action filtering
    if not eventArgs.cancel and default_filtered_action then
        default_filtered_action(spell, eventArgs)
    end
	
	-- Final user for filtering and error reporting.
    if not eventArgs.cancel and extra_user_filtered_action then
        extra_user_filtered_action(spell, eventArgs)
    end
	
	-- Final pass for filtering and error reporting.
    if not eventArgs.cancel and extra_default_filtered_action then
        extra_default_filtered_action(spell, eventArgs)
    end

end



function pretarget(spell)
    handle_actions(spell, 'pretarget')
end

function precast(spell)
    handle_actions(spell, 'precast')
end

function midcast(spell)
    handle_actions(spell, 'midcast')
end

function aftercast(spell)
    if state.Buff[spell.english:ucfirst()] ~= nil and spell.target.type == 'SELF' then
        state.Buff[spell.english:ucfirst()] = not spell.interrupted or buffactive[spell.english] or false
    end
    handle_actions(spell, 'aftercast')
end

function pet_midcast(spell)
    handle_actions(spell, 'pet_midcast')
end

function pet_aftercast(spell)
    handle_actions(spell, 'pet_aftercast')
end

--------------------------------------
-- Default code for each action.
--------------------------------------

function default_filtered_action(spell, eventArgs)
	if spell.english == 'Warp' then
		windower.send_command('get "Warp Ring" satchel;wait 2;gs c forceequip Warp ring2;wait 11;input /item "Warp Ring" <me>;wait 20;gs c quietenable ring2;put "Warp Ring" satchel')
		add_to_chat(217,"You can't cast warp, attempting to use Warp Ring instead.")
		cancel_spell()
		eventArgs.cancel = true
		return
	elseif spell.english == 'Teleport-Holla' then
		windower.send_command('get "Dim. Ring (Holla)" satchel;wait 2;gs c forceequip HollaRing ring2;wait 11;input /item "Dim. Ring (Holla)" <me>;wait 20;gs c quietenable ring2;put "Dim. Ring (Holla)" satchel')
		add_to_chat(217,"You can't cast Teleport-Holla, attempting to use Dimensional Ring (Holla) instead.")
		cancel_spell()
		eventArgs.cancel = true
		return
	elseif spell.english == 'Teleport-Dem' then
		windower.send_command('get "Dim. Ring (Dem)" satchel;wait 2;gs c forceequip DemRing ring2;wait 11;input /item "Dim. Ring (Dem)" <me>;wait 20;gs c quietenable ring2;put "Dim. Ring (Dem)" satchel')
		add_to_chat(217,"You can't cast Teleport-Dem, attempting to use Dimensional Ring (Dem) instead.")
		cancel_spell()
		eventArgs.cancel = true
		return
	elseif spell.english == 'Teleport-Mea' then
		windower.send_command('get "Dim. Ring (Mea)" satchel;wait 2;gs c forceequip MeaRing ring2;wait 11;input /item "Dim. Ring (Mea)" <me>;wait 20;gs c quietenable ring2;put "Dim. Ring (Mea)" satchel')
		add_to_chat(217,"You can't cast Teleport-Mea, attempting to use Dimensional Ring (Mea) instead.")
		cancel_spell()
		eventArgs.cancel = true
		return
	end
end

function extra_default_filtered_action(spell, eventArgs)
	if not can_use(spell) then
		cancel_spell()
		eventArgs.cancel = true
		return		
	end
end

function default_pretarget(spell, spellMap, eventArgs)
    auto_change_target(spell, spellMap)
end

function default_precast(spell, spellMap, eventArgs)
    cancel_conflicting_buffs(spell, spellMap, eventArgs)
    refine_waltz(spell, spellMap, eventArgs)

	if eventArgs.cancel then
		cancel_spell()
	else
		equip(get_precast_set(spell, spellMap))
	end	
end

function default_post_precast(spell, spellMap, eventArgs)
	if not eventArgs.handled then
		if spell.type == 'Waltz' then
			if spell.target.type == 'SELF' and sets.Self_Waltz and not (spell.english == "Healing Waltz" or spell.english == "Divine Waltz" or spell.english == "Divine Waltz II") then
				equip(sets.Self_Waltz)
			end
		
		elseif spell.action_type == 'Magic' then
			if spell.english == "Fire" or spell.english == "Blizzard" or spell.english == "Aero" or spell.english == "Stone" or spell.english == "Thunder" or spell.english == "Water" then
				if state.CastingMode.value == 'Proc' and sets.midcast['Elemental Magic'].Proc then
					equip(sets.midcast['Elemental Magic'].Proc)
				else
					equip(sets.midcast['Elemental Magic'])
				end
			end

		elseif spell.type == 'WeaponSkill' then
			
			if elemental_obi_weaponskills:contains(spell.name) and spell.element and (spell.element == world.weather_element or spell.element == world.day_element) and item_available('Hachirin-no-Obi') then
				equip({waist="Hachirin-no-Obi"})
			end
			
			if sets.Reive and buffactive['Reive Mark'] and sets.Reive.neck == "Ygnas's Resolve +1" then
				equip(sets.Reive)
			end
			
			if state.Capacity.value == true then 
				equip(sets.Capacity)
			end
		end
		
		if state.DefenseMode.value ~= 'None' then
			if spell.action_type == 'Magic' then
				if sets.precast[spell.english] and sets.precast[spell.english].DT then
					equip(sets.precast[spell.english].DT)
				elseif sets.precast.FC.DT then
					equip(sets.precast.FC.DT)
				else
					handle_equipping_gear(player.status)
				end
			elseif spell.type == 'WeaponSkill' then
				if state.SkillchainMode.value ~= 'Off' and sets.Skillchain then
					equip(sets.Skillchain)
				end
				
				if sets.precast.WS[spell.english] and sets.precast.WS[spell.english].DT then
					equip(sets.precast.WS[spell.english].DT)
				elseif sets.precast.WS.DT then
					equip(sets.precast.WS.DT)
				else
					handle_equipping_gear(player.status)
				end
			elseif spell.action_type == 'Ability' then
				if sets.precast.JA[spell.english] and sets.precast.JA[spell.english].DT then
					equip(sets.precast.JA[spell.english].DT)
				else
					handle_equipping_gear(player.status)
				end
			else
				handle_equipping_gear(player.status)
			end
		end
	end
end

function default_midcast(spell, spellMap, eventArgs)
    equip(get_midcast_set(spell, spellMap))
end

function default_post_midcast(spell, spellMap, eventArgs)

	if not eventArgs.handled then
		if not job_post_midcast and is_nuke(spell, spellMap) and state.MagicBurstMode.value ~= 'Off' and sets.MagicBurst then
			equip(sets.MagicBurst)
		end

		if spell.target.type == 'SELF' and spellMap then
			if spellMap:contains('Cure') and sets.Self_Healing then
				equip(sets.Self_Healing)
			elseif spellMap == 'Refresh' and sets.Self_Refresh then
				equip(sets.Self_Refresh)
			end
		end
		
		if state.Capacity.value == true then
			if set.contains(spell.targets, 'Enemy') then
		
				if spell.skill == 'Elemental Magic' then
					equip(sets.Capacity)
				
				elseif spell.skill == 'Blue Magic'then
					equip(sets.Capacity)
				
				end
			end
		end
		
		if sets.Reive and buffactive['Reive Mark'] and (spell.skill == 'Elemental Magic' or spellMap == 'Cure' or spellMap == 'Curaga') then
			if sets.Reive.neck == "Arciela's Grace +1" then
				equip(sets.Reive)
			end
		end
		
		if state.DefenseMode.value ~= 'None' and spell.action_type == 'Magic' then
			if sets.midcast[spell.english] and sets.midcast[spell.english].DT then
				equip(sets.midcast[spell.english].DT)
			elseif sets.midcast[spellMap] and sets.midcast[spellMap].DT then
				equip(sets.midcast[spellMap].DT)
			elseif sets.midcast[spell.skill] and sets.midcast[spell.skill].DT then
				equip(sets.midcast[spell.skill].DT)
			elseif sets.midcast.FastRecast.DT then
				equip(sets.midcast.FastRecast.DT)
			else
				handle_equipping_gear(player.status)
			end

			if spell.target.type == 'SELF' and spellMap and spellMap:contains('Cure') and sets.Self_Healing.DT then
				equip(sets.Self_Healing.DT)

			end
			
			eventArgs.handled = true
		end
	end		
	
	if buffactive.doom then
		equip(sets.buff.Doom)
	end
end

function default_post_pet_midcast(spell, spellMap, eventArgs)
	if state.Capacity.value == true then
		equip(sets.Capacity)
	end

	if buffactive.doom then
		equip(sets.buff.Doom)
	end
end

function default_aftercast(spell, spellMap, eventArgs)

	if is_nuke(spell, spellMap) and state.MagicBurstMode.value == 'Single' then
		state.MagicBurstMode:reset()
	elseif spell.type == 'WeaponSkill' and state.SkillchainMode.value == 'Single' then
		state.SkillchainMode:reset()
	end

    if not pet_midaction() then
        handle_equipping_gear(player.status)
    end
end

function default_pet_midcast(spell, spellMap, eventArgs)
    equip(get_pet_midcast_set(spell, spellMap))
end

function default_pet_aftercast(spell, spellMap, eventArgs)
    if not midaction() then handle_equipping_gear(player.status) end
end

--------------------------------------
-- Filters for each action.
-- Set eventArgs.cancel to true to stop further processing.
-- May show notification messages, but should not do any processing here.
--------------------------------------

function filter_precast(spell, spellMap, eventArgs)
	if check_disable(spell, spellMap, eventArgs) then return end
	if check_doom(spell, spellMap, eventArgs) then return end
	if check_silence(spell, spellMap, eventArgs) then return end
	if check_amnesia(spell, spellMap, eventArgs) then return end
	if check_abilities(spell, spellMap, eventArgs) then return end
	if check_recast(spell, spellMap, eventArgs) then return end
	if check_cost(spell, spellMap, eventArgs) then return end

	if spellMap == 'Cure' or spellMap == 'Curaga' then
		if spell.target.distance > 21 and spell.target.type == 'PLAYER' then
			cancel_spell()
			eventArgs.cancel = true
			--Delete the next line and uncomment the line after, if you'd rather it send a tell if they're too far to heal.
			add_to_chat(123,'Target out of range, too far to heal!')
			--windower.send_command('input /tell '..spell.target.name..' !!! OUT OF RANGE !!! TOO FAR TO HEAL !!!')
		end
	end
end

function filter_midcast(spell, spellMap, eventArgs)
    if state.EquipStop.value == 'precast' then
        eventArgs.cancel = true
		return
	end
	
	-- Default base equipment layer of fast recast, needs to come before job-midcast.
	if spell.action_type == 'Magic' and sets.midcast and sets.midcast.FastRecast then
		equip(sets.midcast.FastRecast)
	end
end

function filter_aftercast(spell, spellMap, eventArgs)
    if state.EquipStop.value == 'precast' or state.EquipStop.value == 'midcast' or state.EquipStop.value == 'pet_midcast' then
        eventArgs.cancel = true
    elseif spell.name == 'Unknown Interrupt' then
        eventArgs.cancel = true
    end
end

function filter_pet_midcast(spell, spellMap, eventArgs)
    -- If we have show_set active for precast or midcast, don't try to equip pet midcast gear.
    if state.EquipStop.value == 'precast' or state.EquipStop.value == 'midcast' then
        add_to_chat(104, 'Show Sets: Pet midcast not equipped.')
        eventArgs.cancel = true
    end
end

function filter_pet_aftercast(spell, spellMap, eventArgs)
    -- If show_set is flagged for precast or midcast, don't try to equip aftercast gear.
    if state.EquipStop.value == 'precast' or state.EquipStop.value == 'midcast' or state.EquipStop.value == 'pet_midcast' then
        eventArgs.cancel = true
    end
end

--------------------------------------
-- Cleanup code for each action.
--------------------------------------

function cleanup_precast(spell, spellMap, eventArgs)
    -- If show_set is flagged for precast, notify that we won't try to equip later gear.
    if state.EquipStop.value == 'precast' then
        add_to_chat(104, 'Show Sets: Stopping at precast.')
    end
end

function cleanup_midcast(spell, spellMap, eventArgs)
    -- If show_set is flagged for midcast, notify that we won't try to equip later gear.
    if state.EquipStop.value == 'midcast' then
        add_to_chat(104, 'Show Sets: Stopping at midcast.')
    end
end

function cleanup_aftercast(spell, spellMap, eventArgs)
    -- Reset custom classes after all possible precast/midcast/aftercast/job-specific usage of the value.
    -- If we're in the middle of a pet action, pet_aftercast will handle clearing it.
    if not pet_midaction() then
        reset_transitory_classes()
    end
end

function cleanup_pet_midcast(spell, spellMap, eventArgs)
    -- If show_set is flagged for pet midcast, notify that we won't try to equip later gear.
    if state.EquipStop.value == 'pet_midcast' then
        add_to_chat(104, 'Show Sets: Stopping at pet midcast.')
    end
end

function cleanup_pet_aftercast(spell, spellMap, eventArgs)
    -- Reset custom classes after all possible precast/midcast/aftercast/job-specific usage of the value.
    reset_transitory_classes()
end

function pre_tick()
	if check_trust() then return true end
	
	return false
end

function default_tick()
	if check_sub() then return true end
	if check_food() then return true end
	if check_ws() then return true end
	if check_cpring_buff() then return true end
	if check_cleanup() then return true end
	if check_shoot() then return true end
	if check_nuke() then return true end
	return false
end

-- Clears the values from classes that only exist til the action is complete.
function reset_transitory_classes()
    classes.CustomClass = nil
    classes.JAMode = nil
end



-------------------------------------------------------------------------------------------------------------------
-- High-level functions for selecting and equipping gear sets.
-------------------------------------------------------------------------------------------------------------------

-- Central point to call to equip gear based on status.
-- Status - Player status that we're using to define what gear to equip.
function handle_equipping_gear(playerStatus, petStatus)
    -- init a new eventArgs
    local eventArgs = {handled = false}

    -- Allow jobs to override this code
    if job_handle_equipping_gear then
        job_handle_equipping_gear(playerStatus, eventArgs)
    end

	if player.equipment.main == 'empty' and player.equipment.sub == 'empty' and state.ReEquip.value then
		local commandArgs = {}
		handle_weapons(commandArgs)
	end
	
    -- Equip default gear if job didn't handle it.
    if not eventArgs.handled then
        equip_gear_by_status(playerStatus, petStatus)
    end
end


-- Function to wrap logic for equipping gear on aftercast, status change, or user update.
-- @param status : The current or new player status that determines what sort of gear to equip.
function equip_gear_by_status(playerStatus, petStatus)
    if _global.debug_mode then add_to_chat(123,'Debug: Equip gear for status ['..tostring(status)..'], HP='..tostring(player.hp)) end

    playerStatus = playerStatus or player.status or 'Idle'
    -- If status not defined, treat as idle.
    -- Be sure to check for positive HP to make sure they're not dead.
    if (playerStatus == 'Idle' or playerStatus == '') and player.hp > 0 then
        equip(get_idle_set(petStatus))
    elseif playerStatus == 'Engaged' then
        equip(get_melee_set(petStatus))
    elseif playerStatus == 'Resting' then
        equip(get_resting_set(petStatus))
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Functions for constructing default gear sets based on status.
-------------------------------------------------------------------------------------------------------------------

-- Returns the appropriate idle set based on current state values and location.
-- Set construction order (all of which are optional):
--   sets.idle[idleScope][state.IdleMode][Pet[Engaged]][CustomIdleGroups]
--
-- Params:
-- petStatus - Optional explicit definition of pet status.
function get_idle_set(petStatus)
    local idleSet = sets.idle
    
    if not idleSet then
        return {}
    end
    
    mote_vars.set_breadcrumbs:append('sets')
    mote_vars.set_breadcrumbs:append('idle')
    
    local idleScope

    if buffactive.weakness then
        idleScope = 'Weak'
    elseif areas.Cities:contains(world.area) then
        idleScope = 'Town'
    else
        idleScope = 'Field'
    end

    if idleSet[idleScope] then
        idleSet = idleSet[idleScope]
        mote_vars.set_breadcrumbs:append(idleScope)
    end

    if idleSet[state.IdleMode.current] then
        idleSet = idleSet[state.IdleMode.current]
        mote_vars.set_breadcrumbs:append(state.IdleMode.current)
    end

    if (pet.isvalid or state.Buff.Pet) and idleSet.Pet then
        idleSet = idleSet.Pet
        petStatus = petStatus or pet.status
        mote_vars.set_breadcrumbs:append('Pet')

        if petStatus == 'Engaged' and idleSet.Engaged then
            idleSet = idleSet.Engaged
            mote_vars.set_breadcrumbs:append('Engaged')
        end
    end

    for _,group in ipairs(classes.CustomIdleGroups) do
        if idleSet[group] then
            idleSet = idleSet[group]
            mote_vars.set_breadcrumbs:append(group)
        end
    end

	--Apply time based gear.
    if (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and not pet.isvalid then
		if classes.DuskToDawn then
			if sets.DuskIdle then idleSet = set_combine(idleSet, sets.DuskIdle) end
		end
		
		if classes.Daytime then
			if sets.DayIdle then idleSet = set_combine(idleSet, sets.DayIdle) end
		else
			if sets.NightIdle then idleSet = set_combine(idleSet, sets.NightIdle) end
		end
	end

    if areas.Assault:contains(world.area) and sets.Assault then
        idleSet = set_combine(idleSet, sets.Assault)
    end
	
	if state.Capacity.value then 
		idleSet = set_combine(idleSet, sets.Capacity)
	end	
	
    if sets.Reive and buffactive['Reive Mark'] then
        idleSet = set_combine(idleSet, sets.Reive)
    end
	
    idleSet = apply_defense(idleSet)
    idleSet = apply_kiting(idleSet)
	
    if user_customize_idle_set then
        idleSet = user_customize_idle_set(idleSet)
    end
	
    if job_customize_idle_set then
        idleSet = job_customize_idle_set(idleSet)
    end
	
    if job_user_customize_idle_set then
        idleSet = job_user_customize_idle_set(idleSet)
    end

    if areas.Cities:contains(world.area) and state.DefenseMode.value == 'None' then
		if sets.Town then
			idleSet = set_combine(idleSet, sets.Kiting, sets.Town)
		else 
			idleSet = set_combine(idleSet, sets.Kiting)
		end
	end

	if silent_check_disable() and state.DefenseMode.value == 'None' then
		if state.IdleMode.value:contains('MDT') and sets.defense.MDT then
			idleSet = set_combine(idleSet, sets.defense.MDT)
		elseif sets.defense.PDT then
			idleSet = set_combine(idleSet, sets.defense.PDT)
		end
	end
	
	if (buffactive.sleep or buffactive.Lullaby) and (player.main_job == 'SMN' and pet.isvalid) then
		idleSet = set_combine(idleSet, sets.buff.Sleep)
	end
	
    if buffactive.doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end

    if extra_user_customize_idle_set then
        idleSet = extra_user_customize_idle_set(idleSet)
    end

    return idleSet
end


-- Returns the appropriate melee set based on current state values.
-- Set construction order (all sets after sets.engaged are optional):
--   sets.engaged[state.CombatForm][state.CombatWeapon][state.OffenseMode][state.DefenseMode][classes.CustomMeleeGroups (any number)]
function get_melee_set()
    local meleeSet = sets.engaged
    
    if not meleeSet then
        return {}
    end
    
    mote_vars.set_breadcrumbs:append('sets')
    mote_vars.set_breadcrumbs:append('engaged')

    if state.CombatForm.has_value and meleeSet[state.CombatForm.value] then
        meleeSet = meleeSet[state.CombatForm.value]
        mote_vars.set_breadcrumbs:append(state.CombatForm.value)
    end

    if state.CombatWeapon.has_value and meleeSet[state.CombatWeapon.value] then
        meleeSet = meleeSet[state.CombatWeapon.value]
        mote_vars.set_breadcrumbs:append(state.CombatWeapon.value)
    end

    if meleeSet[state.OffenseMode.current] then
        meleeSet = meleeSet[state.OffenseMode.current]
        mote_vars.set_breadcrumbs:append(state.OffenseMode.current)
    end

    if meleeSet[state.HybridMode.current] then
        meleeSet = meleeSet[state.HybridMode.current]
        mote_vars.set_breadcrumbs:append(state.HybridMode.current)
    end

    for _,group in ipairs(classes.CustomMeleeGroups) do
        if meleeSet[group] then
            meleeSet = meleeSet[group]
            mote_vars.set_breadcrumbs:append(group)
        end
    end

    meleeSet = apply_defense(meleeSet)
    meleeSet = apply_kiting(meleeSet)

    if user_customize_melee_set then
        meleeSet = user_customize_melee_set(meleeSet)
    end
	
    if job_customize_melee_set then
        meleeSet = job_customize_melee_set(meleeSet)
    end
	
	if silent_check_disable() and state.DefenseMode.value == 'None' then
		if state.HybridMode.value:contains('MDT') and sets.defense.MDT then
			meleeSet = set_combine(meleeSet, sets.defense.MDT)
		elseif sets.defense.PDT then
			meleeSet = set_combine(meleeSet, sets.defense.PDT)
		end
	end
	
	if sets.Reive and buffactive['Reive Mark'] then
        meleeSet = set_combine(meleeSet, sets.Reive)
    end
	
	if state.Capacity.value == true and state.DefenseMode.value == 'None' then 
		meleeSet = set_combine(meleeSet, sets.Capacity)
	end
	
	if (buffactive.sleep or buffactive.Lullaby) and sets.buff.Sleep then
        meleeSet = set_combine(meleeSet, sets.buff.Sleep)
    end
	
	if buffactive.doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
	
    if extra_user_customize_melee_set then
        meleeSet = extra_user_customize_melee_set(meleeSet)
    end
	
    return meleeSet
end


-- Returns the appropriate resting set based on current state values.
-- Set construction order:
--   sets.resting[state.RestingMode]
function get_resting_set()
    local restingSet = sets.resting

    if not restingSet then
        return {}
    end

    mote_vars.set_breadcrumbs:append('sets')
    mote_vars.set_breadcrumbs:append('resting')

    if restingSet[state.RestingMode.current] then
        restingSet = restingSet[state.RestingMode.current]
        mote_vars.set_breadcrumbs:append(state.RestingMode.current)
    end

    return restingSet
end


-------------------------------------------------------------------------------------------------------------------
-- Functions for constructing default gear sets based on action.
-------------------------------------------------------------------------------------------------------------------

-- Get the default precast gear set.
function get_precast_set(spell, spellMap)
    -- If there are no precast sets defined, bail out.
    if not sets.precast then
        return {}
    end

    local equipSet = sets.precast

    mote_vars.set_breadcrumbs:append('sets')
    mote_vars.set_breadcrumbs:append('precast')
    
    -- Determine base sub-table from type of action being performed.
    
    local cat
    
    if spell.action_type == 'Magic' then
        cat = 'FC'
    elseif spell.action_type == 'Ranged Attack' then
        cat = (sets.precast.RangedAttack and 'RangedAttack') or 'RA'
    elseif spell.action_type == 'Ability' then
        if spell.type == 'WeaponSkill' then
            cat = 'WS'
        elseif spell.type == 'JobAbility' then
            cat = 'JA'
        else
            -- Allow fallback to .JA table if spell.type isn't found, for all non-weaponskill abilities.
            cat = (sets.precast[spell.type] and spell.type) or 'JA'
        end
    elseif spell.action_type == 'Item' then
        cat = 'Item'
    end
    
    -- If no proper sub-category is defined in the job file, bail out.
    if cat then
        if equipSet[cat] then
            equipSet = equipSet[cat]
            mote_vars.set_breadcrumbs:append(cat)
        else
            mote_vars.set_breadcrumbs:clear()
            return {}
        end
    end

    classes.SkipSkillCheck = false
    -- Handle automatic selection of set based on spell class/name/map/skill/type.
    equipSet = select_specific_set(equipSet, spell, spellMap)

    
    -- Once we have a named base set, do checks for specialized modes (casting mode, weaponskill mode, etc).
    
    if spell.action_type == 'Magic' then
        if equipSet[state.CastingMode.current] then
            equipSet = equipSet[state.CastingMode.current]
            mote_vars.set_breadcrumbs:append(state.CastingMode.current)
        end
    elseif spell.type == 'WeaponSkill' then
        equipSet = get_weaponskill_set(equipSet, spell, spellMap)
    elseif spell.action_type == 'Ability' then
        if classes.JAMode and equipSet[classes.JAMode] then
            equipSet = equipSet[classes.JAMode]
            mote_vars.set_breadcrumbs:append(classes.JAMode)
        end
    elseif spell.action_type == 'Ranged Attack' then
        equipSet = get_ranged_set(equipSet, spell, spellMap)
    end

    -- Update defintions for element-specific gear that may be used.
    set_elemental_gear(spell)
    
    -- Return whatever we've constructed.
    return equipSet
end



-- Get the default midcast gear set.
-- This builds on sets.midcast.
function get_midcast_set(spell, spellMap)
    -- If there are no midcast sets defined, bail out.
    if not sets.midcast then
        return {}
    end
    
    local equipSet = sets.midcast

    mote_vars.set_breadcrumbs:append('sets')
    mote_vars.set_breadcrumbs:append('midcast')
    
    -- Determine base sub-table from type of action being performed.
    -- Only ranged attacks and items get specific sub-categories here.
    
    local cat

    if spell.action_type == 'Ranged Attack' then
        cat = (sets.precast.RangedAttack and 'RangedAttack') or 'RA'
    elseif spell.action_type == 'Item' then
        cat = 'Item'
    end
    
    -- If no proper sub-category is defined in the job file, bail out.
    if cat then
        if equipSet[cat] then
            equipSet = equipSet[cat]
            mote_vars.set_breadcrumbs:append(cat)
        else
            mote_vars.set_breadcrumbs:clear()
            return {}
        end
    end
    
    classes.SkipSkillCheck = classes.NoSkillSpells:contains(spell.english)
    -- Handle automatic selection of set based on spell class/name/map/skill/type.
    equipSet = select_specific_set(equipSet, spell, spellMap)
    
    -- After the default checks, do checks for specialized modes (casting mode, etc).
    
    if spell.action_type == 'Magic' then
        if equipSet[state.CastingMode.current] then
            equipSet = equipSet[state.CastingMode.current]
            mote_vars.set_breadcrumbs:append(state.CastingMode.current)
        end
    elseif spell.action_type == 'Ranged Attack' then
        equipSet = get_ranged_set(equipSet, spell, spellMap)
    end
    
    -- Return whatever we've constructed.
    return equipSet
end


-- Get the default pet midcast gear set.
-- This is built in sets.midcast.Pet.
function get_pet_midcast_set(spell, spellMap)
    -- If there are no midcast sets defined, bail out.
    if not sets.midcast or not sets.midcast.Pet then
        return {}
    end

    local equipSet = sets.midcast.Pet

    mote_vars.set_breadcrumbs:append('sets')
    mote_vars.set_breadcrumbs:append('midcast')
    mote_vars.set_breadcrumbs:append('Pet')

    if sets.midcast and sets.midcast.Pet then
        classes.SkipSkillCheck = false
        equipSet = select_specific_set(equipSet, spell, spellMap)

        -- We can only generally be certain about whether the pet's action is
        -- Magic (ie: it cast a spell of its own volition) or Ability (it performed
        -- an action at the request of the player).  Allow CastinMode and
        -- OffenseMode to refine whatever set was selected above.
        if spell.action_type == 'Magic' then
            if equipSet[state.CastingMode.current] then
                equipSet = equipSet[state.CastingMode.current]
                mote_vars.set_breadcrumbs:append(state.CastingMode.current)
            end
        elseif spell.action_type == 'Ability' then
            if equipSet[state.OffenseMode.current] then
                equipSet = equipSet[state.OffenseMode.current]
                mote_vars.set_breadcrumbs:append(state.OffenseMode.current)
            end
        end
    end

    return equipSet
end


-- Function to handle the logic of selecting the proper weaponskill set.
function get_weaponskill_set(equipSet, spell, spellMap)
    -- Custom handling for weaponskills
    local ws_mode = state.WeaponskillMode.current
    
    if ws_mode == 'Normal' then
        -- If a particular weaponskill mode isn't specified, see if we have a weaponskill mode
        -- corresponding to the current offense mode.  If so, use that.
        if spell.skill == 'Archery' or spell.skill == 'Marksmanship' then
            if state.RangedMode.current ~= 'Normal' and state.WeaponskillMode:contains(state.RangedMode.current) then
                ws_mode = state.RangedMode.current
            end
        else
            if state.OffenseMode.current ~= 'Normal' and state.WeaponskillMode:contains(state.OffenseMode.current) then
                ws_mode = state.OffenseMode.current
            end
        end
    end

    local custom_wsmode

    -- Allow the job file to specify a preferred weaponskill mode
    if get_custom_wsmode then
        custom_wsmode = get_custom_wsmode(spell, spellMap, ws_mode)
    end

    -- If the job file returned a weaponskill mode, use that.
    if custom_wsmode then
        ws_mode = custom_wsmode
    end

    if equipSet[ws_mode] then
        equipSet = equipSet[ws_mode]
        mote_vars.set_breadcrumbs:append(ws_mode)
    end
    
    return equipSet
end


-- Function to handle the logic of selecting the proper ranged set.
function get_ranged_set(equipSet, spell, spellMap)
    -- Attach Combat Form and Combat Weapon to set checks
    if state.CombatForm.has_value and equipSet[state.CombatForm.value] then
        equipSet = equipSet[state.CombatForm.value]
        mote_vars.set_breadcrumbs:append(state.CombatForm.value)
    end

    if state.CombatWeapon.has_value and equipSet[state.CombatWeapon.value] then
        equipSet = equipSet[state.CombatWeapon.value]
        mote_vars.set_breadcrumbs:append(state.CombatWeapon.value)
    end

    -- Check for specific mode for ranged attacks (eg: Acc, Att, etc)
    if equipSet[state.RangedMode.current] then
        equipSet = equipSet[state.RangedMode.current]
        mote_vars.set_breadcrumbs:append(state.RangedMode.current)
    end

    -- Tack on any additionally specified custom groups, if the sets are defined.
    for _,group in ipairs(classes.CustomRangedGroups) do
        if equipSet[group] then
            equipSet = equipSet[group]
            mote_vars.set_breadcrumbs:append(group)
        end
    end

    return equipSet
end


-------------------------------------------------------------------------------------------------------------------
-- Functions for optional supplemental gear overriding the default sets defined above.
-------------------------------------------------------------------------------------------------------------------

-- Function to apply any active defense set on top of the supplied set
-- @param baseSet : The set that any currently active defense set will be applied on top of. (gear set table)

function apply_defense(baseSet)
    if state.DefenseMode.current ~= 'None' then
        local defenseSet = sets.defense
		
        defenseSet = sets.defense[state[state.DefenseMode.current .. 'DefenseMode'].current] or defenseSet

        for _,group in ipairs(classes.CustomDefenseGroups) do
            defenseSet = defenseSet[group] or defenseSet
        end

		if sets.Reive and buffactive['Reive Mark'] and sets.Reive.neck == "Adoulin's Refuge +1" then
			defenseSet = set_combine(defenseSet, sets.Reive)
		end

        if user_customize_defense_set then
            defenseSet = user_customize_defense_set(defenseSet)
        end
		
        if job_customize_defense_set then
            defenseSet = job_customize_defense_set(defenseSet)
        end
		
        if user_job_customize_defense_set then
            defenseSet = extra_user_customize_defense_set(defenseSet)
        end

        baseSet = set_combine(baseSet, defenseSet)
    end
	
    return baseSet
end


-- Function to add kiting gear on top of the base set if kiting state is true.
-- @param baseSet : The gear set that the kiting gear will be applied on top of.
function apply_kiting(baseSet)
    if state.Kiting.value then
        if sets.Kiting then
            baseSet = set_combine(baseSet, sets.Kiting)
        end
	elseif player.status == 'Idle' and moving and state.DefenseMode.value == 'None' and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') then
		if sets.Kiting then
		baseSet = set_combine(baseSet, sets.Kiting)
		end
    end

    return baseSet
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions for constructing default gear sets.
-------------------------------------------------------------------------------------------------------------------

-- Get a spell mapping for the spell.
function get_spell_map(spell)
    local defaultSpellMap = classes.SpellMaps[spell.english]
    local jobSpellMap
    
    if job_get_spell_map then
        jobSpellMap = job_get_spell_map(spell, defaultSpellMap)
    end

    return jobSpellMap or defaultSpellMap
end


-- Select the equipment set to equip from a given starting table, based on standard
-- selection order: custom class, spell name, spell map, spell skill, and spell type.
-- Spell skill and spell type may further refine their selections based on
-- custom class, spell name and spell map.
function select_specific_set(equipSet, spell, spellMap)
    -- Take the determined base equipment set and try to get the simple naming extensions that
    -- may apply to it (class, spell name, spell map).
    local namedSet = get_named_set(equipSet, spell, spellMap)
    
    -- If no simple naming sub-tables were found, and we simply got back the original equip set,
    -- check for spell.skill and spell.type, then check the simple naming extensions again.
    if namedSet == equipSet then
        if spell.skill and equipSet[spell.skill] and not classes.SkipSkillCheck then
            namedSet = equipSet[spell.skill]
            mote_vars.set_breadcrumbs:append(spell.skill)
        elseif spell.type and equipSet[spell.type] then
            namedSet = equipSet[spell.type]
            mote_vars.set_breadcrumbs:append(spell.type)
        else
            return equipSet
        end
        
        namedSet = get_named_set(namedSet, spell, spellMap)
    end

    return namedSet or equipSet
end


-- Simple utility function to handle a portion of the equipment set determination.
-- It attempts to select a sub-table of the provided equipment set based on the
-- standard search order of custom class, spell name, and spell map.
-- If no such set is found, it returns the original base set (equipSet) provided.
function get_named_set(equipSet, spell, spellMap)
    if equipSet then
        if classes.CustomClass and equipSet[classes.CustomClass] then
            mote_vars.set_breadcrumbs:append(classes.CustomClass)
            return equipSet[classes.CustomClass]
        elseif equipSet[spell.english] then
            mote_vars.set_breadcrumbs:append(spell.english)
            return equipSet[spell.english]
        elseif spellMap and equipSet[spellMap] then
            mote_vars.set_breadcrumbs:append(spellMap)
            return equipSet[spellMap]
        else
            return equipSet
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's subjob changes.
function sub_job_change(newSubjob, oldSubjob)
    if user_setup then
        user_setup()
    end
	
    if extra_user_setup then
        extra_user_setup()
    end
    
    if job_sub_job_change then
        job_sub_job_change(newSubjob, oldSubjob)
    end
    
    send_command('gs c update')
end


-- Called when the player's status changes.
function status_change(newStatus, oldStatus)
    -- init a new eventArgs
    local eventArgs = {handled = false}
    mote_vars.set_breadcrumbs:clear()

    -- Allow a global function to be called on status change.
    if user_status_change then
        user_status_change(newStatus, oldStatus, eventArgs)
    end
	
    if extra_user_status_change then
        extra_user_status_change(newStatus, oldStatus, eventArgs)
    end

    -- Then call individual jobs to handle status change events.
    if not eventArgs.handled then
        if job_status_change then
            job_status_change(newStatus, oldStatus, eventArgs)
        end
    end

    -- Handle equipping default gear if the job didn't mark this as handled.
    if not eventArgs.handled then
        handle_equipping_gear(newStatus)
        display_breadcrumbs()
    end
end

-- Handle notifications of general state change.
function state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
			if stateField == 'Offense Mode' and newValue == 'Normal' and mageJobs:contains(player.main_job) and sets.Weapons then
				equip(sets.Weapons)
			end
			if player.main_job ~= 'BST' then
				disable('main','sub','range')
			end
        end
    end
	
	if job_state_change then
		job_state_change(stateField, newValue, oldValue)
	end
	
	if stateField == 'Rune Element' then
		send_command('wait .1;gs c DisplayRune')
	elseif stateField == 'Elemental Mode' then
		if player.main_job == 'COR' then
			send_command('wait .1;gs c DisplayShot')
		else
			send_command('wait .1;gs c DisplayElement')
		end
	elseif stateField:contains('Auto') then
		tickdelay = 1350
	elseif stateField == 'Capacity' and newValue == 'off' and cprings:contains(player.equipment.left_ring) then
            enable("left_ring")
	end
	
	if state.DisplayMode.value then update_job_states()	end
end

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function buff_change(buff, gain)
    -- Init a new eventArgs
    local eventArgs = {handled = false}

    if state.Buff[buff:ucfirst()] ~= nil then
        state.Buff[buff:ucfirst()] = gain
    end

    -- Allow a global function to be called on buff change.
    if user_buff_change then
        user_buff_change(buff, gain, eventArgs)
    end

    -- Allow jobs to handle buff change events.
    if not eventArgs.handled then
        if job_buff_change then
            job_buff_change(buff, gain, eventArgs)
        end
    end
	
    if extra_user_buff_change then
        extra_user_buff_change(buff, gain, eventArgs)
    end
	
	if S{'sleep','Lullaby'}:contains(buff) and state.CancelStoneskin.value then
		send_command('cancel stoneskin')
	end
	
    if S{'Commitment','Dedication'}:contains(buff) then
        if gain and cprings:contains(player.equipment.left_ring) then
            enable("left_ring")
        end
    end

	if not midaction() then
		handle_equipping_gear(player.status)
	end
	
	if state.DisplayMode.value then update_job_states()	end
end


-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function pet_change(pet, gain)
    -- Init a new eventArgs
    local eventArgs = {handled = false}

    -- Allow jobs to handle pet change events.
    if job_pet_change then
        job_pet_change(pet, gain, eventArgs)
    end

    -- Equip default gear if not handled by the job.
    if not eventArgs.handled then
        if not midaction() then handle_equipping_gear(player.status) end
    end
end


-- Called when the player's pet's status changes.
-- Note that this is also called after pet_change when the pet is released.
-- As such, don't automatically handle gear equips.  Only do so if directed
-- to do so by the job.
function pet_status_change(newStatus, oldStatus)
    -- Init a new eventArgs
    local eventArgs = {handled = false}

    -- Allow jobs to override this code
    if job_pet_status_change then
        job_pet_status_change(newStatus, oldStatus, eventArgs)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Debugging functions.
-------------------------------------------------------------------------------------------------------------------

-- This is a debugging function that will print the accumulated set selection
-- breadcrumbs for the default selected set for any given action stage.
function display_breadcrumbs(spell, spellMap, action)
    if not _settings.debug_mode then
        return
    end
    
    local msg = 'Default '
    
    if action and spell then
        msg = msg .. action .. ' set selection for ' .. spell.name
    end
    
    if spellMap then
        msg = msg .. ' (' .. spellMap .. ')'
    end
    msg = msg .. ' : '
    
    local cons
    
    for _,name in ipairs(mote_vars.set_breadcrumbs) do
        if not cons then
            cons = name
        else
            if name:contains(' ') or name:contains("'") then
                cons = cons .. '["' .. name .. '"]'
            else
                cons = cons .. '.' .. name
            end
        end
    end

    if cons then
        if action and cons == ('sets.' .. action) then
            msg = msg .. "None"
        else
            msg = msg .. tostring(cons)
        end
        add_to_chat(123, msg)
    end
end

-- Auto-initialize the include - Do this at the bottom so that other user-files can overwrite these functions.
init_include()