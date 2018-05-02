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

    state.Buff['Burst Affinity'] = buffactive['Burst Affinity'] or false
    state.Buff['Chain Affinity'] = buffactive['Chain Affinity'] or false
	state.Buff['Azure Lore'] = buffactive['Azure Lore'] or false
    state.Buff.Convergence = buffactive.Convergence or false
    state.Buff.Diffusion = buffactive.Diffusion or false
    state.Buff.Efflux = buffactive.Efflux or false
    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Unbridled Learning'] = buffactive['Unbridled Learning'] or false
	state.Buff['Unbridled Wisdom'] = buffactive['Unbridled Wisdom'] or false
	
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Chant du Cygne', 'Savage Blade','Requiescat'}
	
	state.LearningMode = M(false, 'Learning Mode')
	autows = 'Chant Du Cygne'
	autofood = 'Soy Ramen'
	
    blue_magic_maps = {}
    
    -- Mappings for gear sets to use for various blue magic spells.
    -- While Str isn't listed for each, it's generally assumed as being at least
    -- moderately signficant, even for spells with other mods.
    
    -- Physical Spells --
    
    -- Physical spells with no particular (or known) stat mods
    blue_magic_maps.Physical = S{
        'Bilgestorm'
    }

    -- Spells with heavy accuracy penalties, that need to prioritize accuracy first.
    blue_magic_maps.PhysicalAcc = S{
        'Heavy Strike',
    }

    -- Physical spells with Str stat mod
    blue_magic_maps.PhysicalStr = S{
        'Bloodrake','Death Scissors','Dimensional Death',
        'Empty Thrash','Quadrastrike','Sinker Drill','Spinal Cleave',
        'Uppercut','Vertical Cleave',
    }
        
    -- Physical spells with Dex stat mod
    blue_magic_maps.PhysicalDex = S{
        'Amorphic Spikes','Asuran Claws','Claw Cyclone','Disseverment',
        'Foot Kick','Frenetic Rip','Goblin Rush','Hysteric Barrage','Paralyzing Triad',
        'Sickle Slash','Smite of Rage','Thrashing Assault','Vanity Dive',
    }
        
    -- Physical spells with Vit stat mod
    blue_magic_maps.PhysicalVit = S{
        'Body Slam','Cannonball','Delta Thrust','Glutinous Dart','Grand Slam',
        'Power Attack','Quad. Continuum',
    }
        
    -- Physical spells with Agi stat mod
    blue_magic_maps.PhysicalAgi = S{
        'Helldive','Jet Stream',
    }

    -- Physical spells with Int stat mod
    blue_magic_maps.PhysicalInt = S{
        'Mandibular Bite',
    }

    -- Physical spells with Mnd stat mod
    blue_magic_maps.PhysicalMnd = S{
        'Ram Charge','Screwdriver','Tourbillion'
    }

    -- Physical spells with Chr stat mod
    blue_magic_maps.PhysicalChr = S{
        'Bludgeon'
    }

    -- Physical spells with HP stat mod
    blue_magic_maps.PhysicalHP = S{
        'Final Sting'
    }

    -- Magical Spells --

    -- Magical spells with the typical Int mod
    blue_magic_maps.Magical = S{
        'Blastbomb','Blazing Bound','Bomb Toss','Cursed Sphere','Dark Orb','Death Ray',
        'Diffusion Ray','Droning Whirlwind','Embalming Earth','Firespit','Foul Waters',
        'Ice Break','Leafstorm','Maelstrom','Rail Cannon','Regurgitation','Rending Deluge',
        'Retinal Glare','Subduction','Tearing Gust','Tem. Upheaval','Water Bomb','Molting Plumage',
		'Nectarous Deluge','Searing Tempest','Blinding Fulgor','Spectral Floe','Scouring Spate',
		'Anvil Lightning','Silent Storm','Entomb','Tenebral Crush','Palling Salvo'
    }

    -- Magical spells with a primary Mnd mod 
    blue_magic_maps.MagicalMnd = S{
        'Acrid Stream','Evryone. Grudge','Magic Hammer','Mind Blast'
    }

    -- Magical spells with a primary Chr mod
    blue_magic_maps.MagicalChr = S{
        'Eyes On Me','Mysterious Light'
    }

    -- Magical spells with a Vit stat mod
    blue_magic_maps.MagicalVit = S{
        'Thermal Pulse'
    }

    -- Magical spells with a Dex stat mod (on top of Int)
    blue_magic_maps.MagicalDex = S{
        'Charged Whisker','Gates of Hades'
    }
            
    -- Magical spells (generally debuffs) that we want to focus on magic accuracy over damage.
    -- Add Int for damage where available, though.
    blue_magic_maps.MagicAccuracy = S{
        '1000 Needles','Absolute Terror','Actinic Burst','Auroral Drape','Awful Eye',
        'Bad Breath', 'Blank Gaze','Blistering Roar','Blitzstrahl','Blood Drain','Blood Saber','Cesspool','Chaotic Eye',
        'Cimicine Discharge','Cold Wave','Corrosive Ooze','Cruel Joke','Demoralizing Roar','Digest',
        'Dream Flower','Enervation','Feather Tickle','Filamented Hold','Frightful Roar',
        'Frost Breath','Geist Wall','Hecatomb Wave','Infrasonics','Jettatura','Light of Penance',
        'Lowing','Mind Blast','Mortal Ray','MP Drainkiss','Osmosis','Radiant Breath','Reaving Wind',
        'Sandspin','Sandspray','Sheep Song','Soporific','Sound Blast','Stinking Gas',
        'Sub-zero Smash','Temporal Shift','Thunderbolt','Venom Shell','Voracious Trunk',
		'Yawn', 'Atra. Libations'
    }
        
    -- Breath-based spells that we don't care about the added effect of.
    blue_magic_maps.Breath = S{
        'Flying Hip Press','Heat Breath',
        'Hecatomb Wave','Magnetite Cloud','Poison Breath','Self-Destruct',
        'Thunder Breath','Vapor Spray','Wind Breath'
    }

    -- Physical stun spells and physical added effect spells.
    blue_magic_maps.Stun = S{
        'Barbed Crescent','Battle Dance','Benthic Typhoon','Bilgestorm',
		'Feather Storm','Frypan','Head Butt','Hydro Shot','Pinecone Bomb','Queasyshroom',
		'Saurian Slide','Seedspray','Spiral Spin','Sprout Smack','Sub-zero Smash',
		'Sudden Lunge','Sweeping Gouge','Tail Slap','Terror Touch','Wild Oats','Whirl of Rage',
    }
        
    -- Healing spells
    blue_magic_maps.Healing = S{
        'Exuviation','Healing Breeze','Magic Fruit','Plenilune Embrace',
		'Pollen','Restoral','White Wind','Wild Carrot'
    }
    
    -- Buffs that depend on blue magic skill that don't cap very low.
    blue_magic_maps.SkillBasedBuff = S{
        'Diamondhide','Magic Barrier','Occultation','Plasma Charge','Reactor Cool',
    }

    -- Other general buffs
    blue_magic_maps.Buff = S{
        'Amplification','Animating Wail','Barrier Tusk','Battery Charge','Carcharian Verve','Cocoon',
        'Erratic Flutter','Fantod','Feather Barrier','Harden Shell','Memento Mori','Metallic Body',
		'Mighty Guard','Nat. Meditation','Orcish Counterstance','Pyric Bulwark',
		'Refueling','Regeneration','Saline Coat','Triumphant Roar','Warm-Up','Winds of Promy.',
        'Zephyr Mantle'
    }
    
    
    -- Spells that require Unbridled Learning to cast.
    unbridled_spells = S{
        'Absolute Terror','Blistering Roar','Bloodrake','Carcharian Verve','Cesspool',
        'Crashing Thunder','Cruel Joke','Droning Whirlwind','Gates of Hades','Harden Shell','Mighty Guard','Polar Roar',
        'Pyric Bulwark','Tearing Gust','Thunderbolt','Tourbillion','Uproot'
    }
	
	init_job_states({"Capacity","AutoTrustMode","AutoWSMode","AutoFoodMode","AutoNukeMode","AutoStunMode","AutoDefenseMode"},{"OffenseMode","WeaponskillMode","IdleMode","LearningMode","CastingMode","TreasureMode"})
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)
	if spell.type == 'WeaponSkill' then
		local available_ws = S(windower.ffxi.get_abilities().weapon_skills)
		-- WS 160 is Shining Strike, meaning a club is equipped.
		if available_ws:contains(160) then
            if spell.english == "Chant du Cygne" then
                send_command('@input /ws "Realmrazer" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Sanguine Blade" then
                send_command('@input /ws "Flash Nova" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Flat Blade" then
                send_command('@input /ws "Brainshaker" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Expiacion" then
                send_command('@input /ws "Judgment" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Vorpal Blade" then
                send_command('@input /ws "True Strike" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            elseif spell.english == "Savage Blade" then
                send_command('@input /ws "Black Halo" '..spell.target.raw)
                cancel_spell()
				eventArgs.cancel = true
            end
        end
	end
end

function job_pretarget(spell, spellMap, eventArgs)

end

function job_filter_precast(spell, spellMap, eventArgs)

	if unbridled_spells:contains(spell.english) and not (state.Buff['Unbridled Learning'] or state.Buff['Unbridled Wisdom']) then
		eventArgs.cancel = true
		cancel_spell()
		add_to_chat(123,'Abort: Unbridled Learning not active.')
	end

end

function job_precast(spell, spellMap, eventArgs)
	if spell.action_type == 'Magic' then
	
		if spellMap == 'Cure' or spellMap == 'Curaga' or (spell.skill == 'Blue Magic' and spellMap == 'Healing') then
			gear.default.obi_back = gear.obi_cure_back
			gear.default.obi_waist = gear.obi_cure_waist
		else
			gear.default.obi_back = gear.obi_nuke_back
			gear.default.obi_waist = gear.obi_nuke_waist
		end
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

    -- If in learning mode, keep on gear intended to help with that, regardless of action.
	if state.LearningMode.value == true then
        equip(sets.Learning)
    end
end

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, spellMap, eventArgs)
    -- Add enhancement gear for Chain Affinity, etc.
    if spell.skill == 'Blue Magic' then
        for buff,active in pairs(state.Buff) do
            if active and sets.buff[buff] then
                equip(sets.buff[buff])
            end
        end
		
        if spellMap == 'Healing' then
			if spell.element == 'None' and sets.NonElementalCure then
				equip(sets.NonElementalCure)
			end
			if spell.target.type == 'SELF' then
				if ((player.equipment.main == 'Nibiru Cudgel' and player.equipment.sub == 'Nibiru Cudgel') or state.OffenseMode.value == 'None') and sets.Self_Healing_DWClub then
					equip(sets.Self_Healing_DWClub)
				elseif player.equipment.main == 'Nibiru Cudgel' or player.equipment.main == 'Nibiru Cudgel' and sets.Self_Healing_Club then
					equip(sets.Self_Healing_Club)
				elseif sets.Self_Healing then
					equip(sets.Self_Healing)
				end
			elseif player.equipment.main == 'Nibiru Cudgel' and player.equipment.main == 'Nibiru Cudgel' and sets.Healing_DWClub then
				equip(sets.Healing_DWClub)
			elseif player.equipment.main == 'Nibiru Cudgel' or player.equipment.main == 'Nibiru Cudgel' and sets.Healing_Club then
				equip(sets.Healing_Club)
			end
			
		elseif spellMap:contains('Magical') then
			if state.MagicBurstMode.value ~= 'Off' and (state.Buff['Burst Affinity'] or state.Buff['Azure Lore']) then
					equip(sets.MagicBurst)
			end
			if spell.element == world.weather_element or spell.element == world.day_element then
				if state.CastingMode.value == 'Fodder' then
					if item_available('Twilight Cape') and not state.Capacity.value then
						sets.TwilightCape = {back="Twilight Cape"}
						equip(sets.TwilightCape)
					end
					if spell.element == world.day_element and not (world.day_element == 'Dark' or world.day_element == 'Light') then
						if item_available('Zodiac Ring') then
							sets.ZodiacRing = {ring2="Zodiac Ring"}
							equip(sets.ZodiacRing)
						end
					end
				end
			end
			if spell.element == 'Dark' and sets.DarkNuke then equip(sets.DarkNuke)
			elseif spell.element == 'Light' and sets.LightNuke then equip(sets.LightNuke)
			end
			if state.TreasureMode.value == "Tag" then equip(sets.TreasureHunter) end

		end

    elseif spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        if state.MagicBurstMode.value ~= 'Off' then equip(sets.MagicBurst) end
	
	end
	
    -- If in learning mode, keep on gear intended to help with that, regardless of action.
    if state.LearningMode.value == true then
		equip(sets.Learning)
    end
end

function job_aftercast(spell, spellMap, eventArgs)

        if state.MagicBurstMode.value == 'Single' then
			if spell.skill == 'Elemental Magic' or (spell.skill == 'Blue Magic' and spellMap:contains('Magical')) then
				state.MagicBurstMode:reset()
				if state.DisplayMode.value then update_job_states()	end
			end
		end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	update_melee_groups()
end

-- Custom spell mapping.
-- Return custom spellMap value that can override the default spell mapping.
-- Don't return anything to allow default spell mapping to be used.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Blue Magic' then
        for category,spell_list in pairs(blue_magic_maps) do
            if spell_list:contains(spell.english) then
                return category
            end
        end
    end
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)
    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end

	if state.LearningMode.value == true then 
		meleeSet = set_combine(meleeSet, sets.Learning)
	end

    return meleeSet
end

-- Modify the default idle set after it was constructed.
function job_customize_idle_set(idleSet)
    if player.mpp < 51 and (state.IdleMode.value == 'Normal' or state.IdleMode.value == 'Sphere') and state.DefenseMode.value == 'None' then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
	
	if state.LearningMode.value == true then 
		idleSet = set_combine(idleSet, sets.Learning)
	end
	
    return idleSet
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end

function job_self_command(commandArgs, eventArgs)
    if commandArgs[1]:lower() == 'curecheat' then
		if sets.HPDown then
			eventArgs.handled = true
			equip(sets.HPDown)
			send_command('@wait 1;input /ma "Magic Fruit" <me>')
		else
			eventArgs.handled = true
			add_to_chat(123,"You don't have a sets.HPDown to cheat with.")
		end
	end
end

function job_tick()
	if check_arts() then return true end
	return false
end

function check_arts()
	if state.AutoArts.value and not moving and not areas.Cities:contains(world.area) then
	
		local abil_recasts = windower.ffxi.get_ability_recasts()

		local needsArts = 
				player.sub_job:lower() == 'sch' and
				not buffactive['Light Arts'] and
				not buffactive['Addendum: White'] and
				not buffactive['Dark Arts'] and
				not buffactive['Addendum: Black']
				

		if needsArts and abil_recasts[228] == 0 then
			send_command('@input /ja "Light Arts" <me>')
			tickdelay = 1320
			return true
		end

	end
	
	return false
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
	if player.equipment.sub then
		if player.equipment.sub:contains('Shield') or player.equipment.sub == 'Culminus' or player.equipment.sub == 'empty' then
			state.CombatForm:set('Fencer')
		else
			state.CombatForm:reset()
		end
	end
end

function update_melee_groups()
	if player.equipment.main then
		classes.CustomMeleeGroups:clear()
		
		if player.equipment.main == "Tizona" and state.Buff['Aftermath: Lv.3'] then
				classes.CustomMeleeGroups:append('AM')
		end
	end	
end