-------------------------------------------------------------------------------------------------------------------
-- Last Revised: May 7th, 2015 (Added a 'PetOnly' Mode - 'Windows Key'+F8 cycles Pet Modes.
-- And a new rule for equipping TP Bonus Hands for TP-based moves.)
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 toggles Monster Correlation between Neutral and Favorable
-- 'Windows Key'+F8 switches between Pet stances for Master/Pet hybrid gearsets
-- alt+= cycles through Pet Food types
-- ctrl+= can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-- General Gearswap Commands:
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- 'Windows Key'+F9 cycles Weapon Skill modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Pet Food/etc. reset to default options.
-- F12 will list your current options.
-------------------------------------------------------------------------------------------------------------------
 
-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------
 
-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.
 
-- Initialization function for this job file.
function get_sets()
        -- Load and initialize the include file.
        include('Sel-Include.lua')
end
 
function job_setup()

	state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false
	state.Buff["Unleash"] = buffactive["Unleash"] or false
		
	-- 'Out of Range' distance; WS will auto-cancel
	target_distance = 6
 
	-- Complete list of Ready moves to use with Sic & Ready Recast -5 Desultor Tassets.
	ready_moves_to_check = S{'Sic','Whirl Claws','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
        'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit',
        'Numbing Noise','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Power Attack',
        'Hi-Freq Field','Sandpit','Sandblast','Venom Spray','Mandibular Bite','Metallic Body','Bubble Shower',
        'Bubble Curtain','Scissor Guard','Big Scissors','Grapple','Spinning Top','Double Claw','Filamented Hold',
        'Frog Kick','Queasyshroom','Silence Gas','Numbshroom','Spore','Dark Spore','Shakeshroom','Blockhead',
        'Secretion','Fireball','Tail Blow','Plague Breath','Brain Crush','Infrasonics','??? Needles',
        'Needleshot','Chaotic Eye','Blaster','Scythe Tail','Ripper Fang','Chomp Rush','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Spiral Spin','Noisome Powder','Wing Slap',
        'Beak Lunge','Suction','Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath',
        'Fantod','Charged Whisker','Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath',
        'Sensilla Blades','Tegmina Buffet','Molting Plumage','Swooping Frenzy','Pentapeck','Sweeping Gouge',
        'Zealous Snort','Somersault ','Tickling Tendrils','Stink Bomb','Nectarous Deluge','Nepenthic Plunge',
        'Pecking Flurry','Pestilent Plume','Foul Waters','Spider Web','Sickle Slash'}
 
	tp_based_ready_moves = S{'Sic','Somersault ','Dust Cloud','Foot Kick','Sheep Song','Sheep Charge','Lamb Chop',
        'Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Roar',
        'Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Geist Wall','Numbing Noise','Frogkick',
        'Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
        'Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard','Grapple','Spinning Top',
        'Double Claw','Filamented Hold','Spore','Blockhead','Secretion','Fireball','Tail Blow','Plague Breath',
        'Brain Crush','Infrasonics','Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive',
        'Water Wall','Snow Cloud','Wild Carrot','Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction',
        'Drainkiss','Acid Mist','TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker',
        'Purulent Ooze','Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades',
        'Tegmina Buffet','Sweeping Gouge','Zealous Snort','Tickling Tendrils','Pecking Flurry',
        'Pestilent Plume','Foul Waters','Spider Web'}
 
	-- List of Magic-based Ready moves to use with Pet MAB or Pet M.Acc gearset.
	magic_ready_moves = S{'Dust Cloud','Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
        'Soporific','Cursed Sphere','Venom','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field',
        'Sandpit','Sandblast','Venom Spray','Bubble Shower','Filamented Hold','Queasyshroom','Silence Gas',
        'Numbshroom','Spore','Dark Spore','Shakeshroom','Fireball','Plague Breath','Infrasonics','Chaotic Eye',
        'Blaster','Intimidate','Snow Cloud','Noisome Powder','TP Drainkiss','Jettatura','Charged Whisker',
        'Purulent Ooze','Corrosive Ooze','Aqua Breath','Molting Plumage','Stink Bomb','Nectarous Deluge',
        'Nepenthic Plunge','Pestilent Plume','Foul Waters','Spider Web'}
 
	-- List of abilities to reference for applying Treasure Hunter +1 via Chaac Belt.
	abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish','Violent Flourish',
        'Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II','Sleep','Sleep II',
        'Drain','Aspir','Dispel','Steal','Mug'}
		
	--List of which WS you plan to use TP bonus WS with.
	moonshade_ws = S{'Rampage','Calamity'}
 
	state.AutoReadyMode = M(false, 'Auto Ready Mode')
	state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Zeta', 'Eta'}
    state.JugMode = M{['description']='Jug Mode', 'ScissorlegXerin', 'BlackbeardRandy', 'AttentiveIbuki', 'AgedAngus',
                'RedolentCandi','DroopyDortwin','WarlikePatrick','HeraldHenry','AlluringHoney','SwoopingZhivago','AcuexFamiliar'}

	UnleashLock = true
	UnleashLocked = false
	ReadyChargeTimer = 15
	autows = 'Cloudsplitter'
	autofood = 'Akamochi'
 
	get_combat_form()
	init_job_states({"Capacity","AutoTrustMode","AutoWSMode","AutoFoodMode","AutoStunMode","AutoDefenseMode","AutoReadyMode"},{"OffenseMode","WeaponskillMode","IdleMode","JugMode","RewardMode","TreasureMode",})
end
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.

function job_filtered_action(spell, eventArgs)

end

function job_filter_precast(spell, spellMap, eventArgs)
    if spell.english == "Bestial Loyalty" then
		
		local abil_recasts = windower.ffxi.get_ability_recasts()
		
		if abil_recasts[94] ~= 0 then
				send_command('@input /ja "Call Beast" <me>')
                eventArgs.cancel = true
				return
		end

    end
end

function job_precast(spell, spellMap, eventArgs)
        cancel_conflicting_buffs(spell, action, spellMap, eventArgs)
 
        if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
                eventArgs.cancel = true
                add_to_chat(123, spell.name..' Canceled: [Out of Range]')

		elseif spell.english == 'Reward' then
			equip(sets.precast.JA.Reward[state.RewardMode.value])
			
			if state.PetMode.value == 'PetOnly' then
				if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
					equip(sets.RewardAxesDW)
				else
					equip(sets.RewardAxe)
				end
			end

		elseif spell.english == 'Spur' then
			equip(sets.precast.JA.Spur)
			
			if state.PetMode.value == 'PetOnly' then
				if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
					equip(sets.SpurAxesDW)
				else
					equip(sets.SpurAxe)
				end
			end

		elseif spell.english == 'Bestial Loyalty' then
				if state.JugMode.value == 'DroopyDortwin' and item_available('Vis. Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].PonderingPeter)
				elseif state.JugMode.value == 'SunburstMalfik' and item_available('Ferm. Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].AgedAngus)
				elseif state.JugMode.value == 'ScissorlegXerin' and item_available('Bubbly Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].BouncingBertha)
				elseif state.JugMode.value == 'AttentiveIbuki' and item_available('Windy Greens') then
					equip(sets.precast.JA['Bestial Loyalty'].SwoopingZhivago)
				elseif state.JugMode.value == 'RedolentCandi' and item_available('Bug-Ridden Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].AlluringHoney)
				elseif state.JugMode.value == 'CaringKiyomaro' and item_available('Tant. Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].VivaciousVickie)
				elseif state.JugMode.value == 'ColibriFamiliar' and item_available('Glazed Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].ChoralLeera)
				elseif state.JugMode.value == 'SpiderFamiliar' and item_available('Slimy Webbing') then
					equip(sets.precast.JA['Bestial Loyalty'].GussyHachirobe)
				elseif state.JugMode.value == 'SurgingStorm' and item_available('Deepwater Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].SubmergedIyo)
				elseif state.JugMode.value == 'AcuexFamiliar' and item_available('Venomous Broth') then
					equip(sets.precast.JA['Bestial Loyalty'].FluffyBredo)
				elseif state.JugMode.value == 'MosquitoFamiliar' and item_available('Heavenly Broth') then
					equip(sets.precast.JA['Bestial Loyalty']['Left-HandedYoko'])
				else
					equip(sets.precast.JA['Bestial Loyalty'][state.JugMode.value])
				end
				
		elseif spell.english == 'Call Beast' then
				equip(sets.precast.JA['Bestial Loyalty'][state.JugMode.value])

-- Define class for Sic and Ready moves.
        elseif ready_moves_to_check:contains(spell.english) then
                classes.CustomClass = "WS"
                if state.PetMode.Value == 'PetOnly' and (player.sub_job == 'NIN' or player.sub_job == 'DNC') then
                         equip(sets.midcast.Pet.ReadyRecastNE)
                else
                         equip(sets.midcast.Pet.ReadyRecast)
                end
        end
end
 
function job_post_precast(spell, spellMap, eventArgs)

	-- Replace Moonshade Earring if we're at cap TP
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
		
		-- If Killer Instinct is active during WS, equip Ferine Gausape +2.
        if buffactive['Killer Instinct'] then
                equip(sets.buff['Killer Instinct'])
        end
	end
 
	
end
 
function job_pet_midcast(spell, spellMap, eventArgs)
        if state.PetMode.value == 'PetOnly' then
                if state.OffenseMode.value:contains('Acc') then
                        equip(sets.midcast.Pet.ReadyNE.Acc)
                elseif state.OffenseMode.value == 'FullAcc' then
                        equip(sets.midcast.Pet.FullAcc)
                else
                        equip(set_combine(sets.midcast.Pet.ReadyNE, sets.midcast.Pet[state.CorrelationMode.value]))
                end
        else
                if state.OffenseMode.value:contains('Acc') then
                        equip(sets.midcast.Pet.Acc)
                elseif state.OffenseMode.value == 'FullAcc' then
                        equip(sets.midcast.Pet.ReadyNE.Acc)
                else
                        equip(set_combine(sets.midcast.Pet.WS, sets.midcast.Pet[state.CorrelationMode.value]))
                end
        end
 
        if magic_ready_moves:contains(spell.name) then
                if state.PetMode.value == 'PetOnly' then
                        equip(sets.midcast.Pet.MagicReadyNE)
                else
                        equip(sets.midcast.Pet.MagicReady)
                end
        end
 
        -- If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +1
        if tp_based_ready_moves:contains(spell.name) and PetJob == 'Warrior' then
                if pet.tp < 1900 then
                        equip(sets.midcast.Pet.TPBonus)
                end
        elseif tp_based_ready_moves:contains(spell.name) and PetJob ~= 'Warrior' then
                if pet.tp < 2400 then
                        equip(sets.midcast.Pet.TPBonus)
                end
        end
end

function job_post_pet_midcast(spell, spellMap, eventArgs)
	if state.Buff["Unleash"] and UnleashLock and not UnleashLocked then
		UnleashLocked = true
		disable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
		add_to_chat(217, "Unleash is on, locking your current Ready set.")
	end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
	send_command('@wait 1;gs c showcharge')
end
 
-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, spellMap, eventArgs)

end
 
-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle sets.
-------------------------------------------------------------------------------------------------------------------
 
function job_customize_idle_set(idleSet)

        if  state.PetMode.value == 'PetOnly' then
           idleSet = set_combine(idleSet, sets.IdleAxesNE)
        end

    return idleSet
end

-- Modify the default melee set after it was constructed.
function job_customize_melee_set(meleeSet)

    if state.ExtraMeleeMode.value ~= 'None' then
        meleeSet = set_combine(meleeSet, sets[state.ExtraMeleeMode.value])
    end

    return meleeSet
end 

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
	if buff == 'Unleash' and UnleashLocked and not gain then
		UnleashLocked = false
		enable('main','sub','range','ammo','head','neck','lear','rear','body','hands','lring','rring','back','waist','legs','feet')
		add_to_chat(217, "Unleash has worn, enabling all slots.")
	end
end

function job_state_change(stateField, newValue, oldValue)
        if stateField == 'Correlation Mode' then
                state.CorrelationMode:set(newValue)
        elseif stateField == 'Reward Mode' then
                state.RewardMode:set(newValue)
        elseif stateField == 'Treasure Mode' then
                state.TreasureMode:set(newValue)
        elseif stateField == 'Pet Mode' then
                state.CombatWeapon:set(newValue)
        elseif stateField == 'Jug Mode' then
                state.JugMode:set(newValue)
        end
end
 
function get_custom_wsmode(spell, spellMap, default_wsmode)
        if default_wsmode ~= 'Fodder' then
                if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
                        return 'Mekira'
                end
        end
end
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
        get_combat_form()
 
        if state.JugMode.value == 'FunguarFamiliar' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'CourierCarrie' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
        elseif state.JugMode.value == 'AmigoSabotender' then
                PetInfo = "Cactuar, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'NurseryNazuna' then
                PetInfo = "Sheep, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'CraftyClyvonne' then
                PetInfo = "Coeurl, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'FleetReinhard' then
                PetInfo = "Raptor, Lizard"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'PrestoJulio' then
                PetInfo = "Flytrap, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'SwiftSieghard' then
                PetInfo = "Raptor, Lizard"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'MailbusterCetas' then
                PetInfo = "Fly, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'AudaciousAnna' then
                PetInfo = "Lizard, Lizard"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'TurbidToloi' then
                PetInfo = "Pugil, Aquan"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'SlipperySilas' then
                PetInfo = "Toad, Aquan"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'LuckyLulush' then
                PetInfo = "Rabbit, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'DipperYuly' then
                PetInfo = "Ladybug, Vermin"
                PetJob = 'Thief'
        elseif state.JugMode.value == 'FlowerpotMerle' then
                PetInfo = "Mandragora, Plantoid"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'DapperMac' then
                PetInfo = "Apkallu, Bird"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'DiscreetLouise' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'FatsoFargann' then
                PetInfo = "Leech, Amorph"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'FaithfulFalcorr' then
                PetInfo = "Hippogryph, Bird"
                PetJob = 'Thief'
        elseif state.JugMode.value == 'BugeyedBroncha' then
                PetInfo = "Eft, Lizard"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'BloodclawShasra' then
                PetInfo = "Lynx, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'GorefangHobs' then
                PetInfo = "Tiger, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'GooeyGerard' then
                PetInfo = "Slug, Amorph"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'CrudeRaphie' then
                PetInfo = "Adamantoise, Lizard"
                PetJob = 'Paladin'
        elseif state.JugMode.value == 'DroopyDortwin' then
                PetInfo = "Rabbit, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'PonderingPeter' then
                PetInfo = "HQ Rabbit, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'SunburstMalfik' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
        elseif state.JugMode.value == 'AgedAngus' then
                PetInfo = "HQ Crab, Aquan"
                PetJob = 'Paladin'
        elseif state.JugMode.value == 'WarlikePatrick' then
                PetInfo = "Lizard, Lizard"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'MosquitoFamiliar' then
                PetInfo = "Mosquito, Vermin"
                PetJob = 'Dark Knight'
        elseif state.JugMode.value == 'Left-HandedYoko' then
                PetInfo = "Mosquito, Vermin"
                PetJob = 'Dark Knight'
        elseif state.JugMode.value == 'ScissorlegXerin' then
                PetInfo = "Chapuli, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'BouncingBertha' then
                PetInfo = "HQ Chapuli, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'RhymingShizuna' then
                PetInfo = "Sheep, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'AttentiveIbuki' then
                PetInfo = "Tulfaire, Bird"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'SwoopingZhivago' then
                PetInfo = "HQ Tulfaire, Bird"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'AmiableRoche' then
                PetInfo = "Pugil, Aquan"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'HeraldHenry' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
        elseif state.JugMode.value == 'BrainyWaluis' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'SuspiciousAlice' then
                PetInfo = "Eft, Lizard"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'HeadbreakerKen' then
                PetInfo = "Fly, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'RedolentCandi' then
                PetInfo = "Snapweed, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'AlluringHoney' then
                PetInfo = "HQ Snapweed, Plantoid"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'CaringKiyomaro' then
                PetInfo = "Raaz, Beast"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'SurgingStorm' then
                PetInfo = "Apkallu, Bird"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'SubmergedIyo' then
                PetInfo = "Apkallu, Bird"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'CursedAnnabelle' then
                PetInfo = "Antlion, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'AnklebiterJedd' then
                PetInfo = "Diremite, Vermin"
                PetJob = 'Dark Knight'
        elseif state.JugMode.value == 'VivaciousVickie' then
                PetInfo = "HQ Raaz, Beast"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'HurlerPercival' then
                PetInfo = "Beetle, Vermin"
                PetJob = 'Paladin'
        elseif state.JugMode.value == 'BlackbeardRandy' then
                PetInfo = "Tiger, Beast"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'GenerousArthur' then
                PetInfo = "Slug, Amorph"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'ThreestarLynn' then
                PetInfo = "Ladybug, Vermin"
                PetJob = 'Thief'
        elseif state.JugMode.value == 'BraveHeroGlenn' then
                PetInfo = "Frog, Aquan"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'SharpwitHermes' then
                PetInfo = "Mandragora, Plantoid"
                PetJob = 'Monk'
        elseif state.JugMode.value == 'ColibriFamiliar' then
                PetInfo = "Colibri, Bird"
                PetJob = 'Red Mage'
        elseif state.JugMode.value == 'ChoralLeera' then
                PetInfo = "HQ Colibri, Bird"
                PetJob = 'Red Mage'
        elseif state.JugMode.value == 'SpiderFamiliar' then
                PetInfo = "Spider, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'GussyHachirobe' then
                PetInfo = "HQ Spider, Vermin"
                PetJob = 'Warrior'
        elseif state.JugMode.value == 'AcuexFamiliar' then
                PetInfo = "Acuex, Amorph"
                PetJob = 'Black Mage'
        elseif state.JugMode.value == 'FluffyBredo' then
                PetInfo = "HQ Acuex, Amorph"
                PetJob = 'Black Mage'
        end
end
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
   
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
   
    msg = msg .. ': '
   
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
   
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
   
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end
	
    if state.ExtraMeleeMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraMeleeMode.value
    end
 
    msg = msg .. ', Reward: '..state.RewardMode.value..', Correlation: '..state.CorrelationMode.value
 
    if state.JugMode.value ~= 'None' then
        add_to_chat(8,'--- Jug Pet: '.. state.JugMode.value ..' --- ('.. PetInfo ..', '.. PetJob ..')')
    end
 
    add_to_chat(122, msg)
 
    eventArgs.handled = true
end
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
function get_combat_form()
	if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
			state.CombatForm:set('DW')
	else
			state.CombatForm:reset()
	end
end

function job_self_command(commandArgs, eventArgs)

		if commandArgs[1]:lower() == 'showcharge' then
			add_to_chat(204, '~~~Current Ready Charges Available: ['..get_current_ready_count()..']~~~')

		elseif commandArgs[1]:lower() == 'unleashlock' then
			if UnleashLock == true then
				UnleashLock = false
				add_to_chat(122, "Unleash no longer locks gear.")
			elseif UnleashLock == false then
				UnleashLock = true
				add_to_chat(122, "Unleash now locks gear.")
			end
			
		elseif commandArgs[1] == 'StandardReady' and pet.isvalid and get_current_ready_count() > 0 then
	
			if pet.status == "Idle" and player.target.type == "MONSTER" then windower.send_command('input /pet Fight <t>')
			elseif pet.status == "Idle" and player.target.type ~= "MONSTER" then add_to_chat(123, 'Abort: Pet not engaged and target is not an enemy.')
			elseif pet.name == 'DroopyDortwin' or pet.name == 'PonderingPeter' then send_command('input /pet "Foot Kick" <me>')
			elseif pet.name == 'HeraldHenry' or pet.name == 'SunburstMalfik' or pet.name == 'AgedAngus' then send_command('input /pet "Big Scissors" <me>')
			elseif pet.name == 'WarlikePatrick' then send_command('input /pet "Fireball" <me>')
			elseif pet.name == 'ScissorlegXerin' or pet.name == 'BouncingBertha' then send_command('input /pet "Sensilla Blades" <me>')
			elseif pet.name == 'RhymingShizuna' then send_command('input /pet "Lamb Chop" <me>')
			elseif pet.name == 'AttentiveIbuki' or pet.name == 'SwoopingZhivago' then send_command('input /pet "Swooping Frenzy" <me>')
			elseif pet.name == 'AmiableRoche' then send_command('input /pet "Recoil Dive" <me>')
			elseif pet.name == 'BrainyWaluis' then send_command('input /pet "Frogkick" <me>')
			elseif pet.name == 'SuspiciousAlice' then send_command('input /pet "Cyclotail" <me>')
			elseif pet.name == 'HeadbreakerKen' then send_command('input /pet "Somersault" <me>')
			elseif pet.name == 'RedolentCandi' or pet.name == 'AlluringHoney' then send_command('input /pet "Tickling Tendrils" <me>')
			elseif pet.name == 'CaringKiyomaro' or pet.name == 'VivaciousVickie' then send_command('input /pet "Sweeping Gouge" <me>')
			elseif pet.name == 'AnklebiterJedd' then send_command('input /pet "Double Claw" <me>')
			elseif pet.name == 'HurlerPercival' then send_command('input /pet "Power Attack" <me>')
			elseif pet.name == 'BlackbeardRandy' then send_command('input /pet "Razor Fang" <me>')
			elseif pet.name == 'FleetReinhard' then send_command('input /pet "Scythe Tail" <me>')
			elseif pet.name == 'ColibriFamiliar' or pet.name == 'ChoralLeera' then send_command('input /pet "Pecking Flurry" <me>')
			elseif pet.name == 'SpiderFamiliar' or pet.name == 'GussyHachirobe' then send_command('input /pet "Sickle Slash" <me>')
			elseif pet.name == 'CursedAnnabelle' then send_command('input /pet "Mandibular Bite" <me>')
			elseif pet.name == 'SurgingStorm' or pet.name == 'SubmergedIyo' then send_command('input /pet "Beak Lunge" <me>')
			elseif pet.name == 'ThreestarLynn' then send_command('input /pet "Spiral Spin" <me>')
			elseif pet.name == 'GenerousArthur' then send_command('input /pet "Purulent Ooze" <me>')
			elseif pet.name == 'SharpwitHermes' then send_command('input /pet "Head Butt" <me>')
			elseif pet.name == 'AcuexFamiliar' or pet.name == 'FluffyBredo' then send_command('input /pet "Pestilent Plume" <me>')
			elseif pet.name == 'MosquitoFamiliar' or pet.name == 'Left-HandedYoko' then send_command('input /pet "Infected Leech" <me>')
			end
		
		end
end

function job_tick()
	if check_pet() then return true end
	if check_ready() then return true end
	return false
end

function check_pet()

	if pet.isvalid and pet.hpp < 34 then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if abil_recasts[103] == 0 then
			if (state.RewardMode.value == 'Theta' and player.inventory['Pet Food Theta']) or (state.RewardMode.value == 'Zeta' and player.inventory['Pet Food Zeta']) or (state.RewardMode.value == 'Eta' and player.inventory['Pet Food Eta']) then
				windower.send_command('input /ja "Reward" <me>')
				tickdelay = 1320
				return true
			else
				return false
			end
		end
	else
		return false
	end

end

function check_ready()
	if state.AutoReadyMode.value and not moving then
		if pet.isvalid then
			if pet.status == "Engaged" and get_current_ready_count() > 0 then
				windower.send_command('gs c StandardReady')
				tickdelay = 1265
				return true
			elseif pet.status == "Idle" and player.target.type == "MONSTER" then
				windower.send_command('input /pet Fight <t>')
				tickdelay = 1290
				return true
			else
				return false
			end
		elseif not areas.Cities:contains(world.area) then
			local abil_recasts = windower.ffxi.get_ability_recasts()
			if abil_recasts[94] == 0 then
				send_command('@input /ja "Bestial Loyalty" <me>')
				tickdelay = 1240
				return true
			elseif abil_recasts[104] == 0 then
				send_command('@input /ja "Call Beast" <me>')
				tickdelay = 1240
				return true
			else
				return false
			end
		end
	else
		return false
	end
end

function get_current_ready_count()
    local abil_recasts = windower.ffxi.get_ability_recasts()
    local readyRecast = abil_recasts[102]
 
    local maxCharges = 3
 
	-- The *# is your current recharge timer.
    local fullRechargeTime = 3*ReadyChargeTimer
 
    local currentCharges = math.floor(maxCharges - maxCharges * readyRecast / fullRechargeTime)
 
    return currentCharges
end

windower.register_event('zone change', function()
	state.AutoReadyMode:reset()
end)