-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh')

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = { 
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		body="Emet Harness +1",
		hands="Buremte Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		neck="Unmoving Collar",
		waist="Kasiri Belt",
		left_ear="Cryptic Earring",
		right_ear="Eris' Earring",
		left_ring="Provocare Ring",
		right_ring="Eihwaz Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Seeth. Bomblet +1",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Carm. Scale Mail", augments={'Attack+15','"Mag.Atk.Bns."+10','"Dbl.Atk."+2',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs="Shned. Tights +1",
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Eddy Necklace",
		waist="Flume Belt +1",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Fenrir Ring +1",
		back="Argocham. Mantle",
	}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['Vivacious Pulse'] = {
		ammo="Impatiens",
		head="Erilaz Galea +1",
		body="Vanir Cotehardie",
		neck="Incanter's Torque",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Healing Earring",
		right_ring="Ephedra Ring",
	}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Rune. Bandeau +1",
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
		hands="Runeist Mitons +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Voltsurge Torque",
		waist="Olympus Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",
	}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})


	-- Weaponskill sets
    sets.precast.WS['Resolution'] = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Herculean Vest", augments={'Mag. Acc.+25','Weapon skill damage +2%','INT+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
		left_ring="Epona's Ring",
		right_ring="Ifrit Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, 
        {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Herculean Vest", augments={'Mag. Acc.+25','Weapon skill damage +2%','INT+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
		left_ring="Epona's Ring",
		right_ring="Ifrit Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.precast.WS['Dimidiation'] = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Seeth. Bomblet +1",
		head={ name="Lustratio Cap", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		feet={ name="Lustratio Leggings", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Ramuh Ring +1",
		right_ring="Ramuh Ring +1",
		back="Agema Cape",
	}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, 
        {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Seeth. Bomblet +1",
		head={ name="Lustratio Cap", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		feet={ name="Lustratio Leggings", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Ramuh Ring +1",
		right_ring="Ramuh Ring +1",
		back="Agema Cape",
	}
	
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {
		ammo="Impatiens",
		head="Rune. Bandeau +1",
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
		hands="Runeist Mitons +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Voltsurge Torque",
		waist="Olympus Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",
	}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {head="Runeist Bandeau +1", legs="Futhark Trousers +1"}
    sets.midcast['Stoneskin'] = {waist="Siegel Sash"}
    sets.midcast.Cure = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Vanir Cotehardie",
		hands="Runeist Mitons +1",
		legs={ name="Carmine Cuisses", augments={'Accuracy+10','DEX+10','MND+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Incanter's Torque",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Healing Earring",
		left_ring="Ephedra Ring",
		right_ring="Ephedra Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {
		ammo="Homiliary",
		head="Oce. Headpiece +1",
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Erilaz Gauntlets +1",
		legs={ name="Carmine Cuisses", augments={'Accuracy+10','DEX+10','MND+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Wiglen Gorget",
		waist="Fucho-no-Obi",
		left_ear="Dawn Earring",
		right_ear="Etiolation Earring",
		left_ring="Paguroidea Ring",
		right_ring="Sheltered Ring",
		back="Archon Cape",
	}
    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1", waist="Fucho-no-obi"})
           
	sets.defense.PDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body="Erilaz Surcoat +1",
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Colossus's Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back="Archon Cape",
	}

	sets.defense.MDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head="Erilaz Galea +1",
		body="Erilaz Surcoat +1",
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Inq. Bead Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Zennaroi Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back="Engulfer Cape +1",
	}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.engaged.DD = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.engaged.Acc = set_combine(sets.engaged.DD, {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Yamarang",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Carmine Cuisses", augments={'Accuracy+10','DEX+10','MND+15',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Sanctity Necklace",
		waist="Olseni Belt",
		left_ear="Telos Earring",
		right_ear="Zennaroi Earring",
		left_ring="Ephedra Ring",
		right_ring="Epona's Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	})
    sets.engaged.PDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body="Erilaz Surcoat +1",
		hands="Buremte Gloves",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.engaged.MDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body="Erilaz Surcoat +1",
		hands="Buremte Gloves",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
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

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)




-- NOTE: I do not play run, so this will not be maintained for 'active' use. 
-- It is added to the repository to allow people to have a baseline to build from,
-- and make sure it is up-to-date with the library API.


-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

	-- Load and initialize the include file.
	include('Mote-Include.lua')
end


-- Setup vars that are user-independent.
function job_setup()
    -- Table of entries
    rune_timers = T{}
    -- entry = rune, index, expires
    
    if player.main_job_level >= 65 then
        max_runes = 3
    elseif player.main_job_level >= 35 then
        max_runes = 2
    elseif player.main_job_level >= 5 then
        max_runes = 1
    else
        max_runes = 0
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

function user_setup()
    state.OffenseMode:options('Normal', 'DD', 'Acc', 'PDT', 'MDT')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT')
    state.IdleMode:options('Regen', 'Refresh')

	select_default_macro_book()
end


function init_gear_sets()
    sets.enmity = { 
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		body="Emet Harness +1",
		hands="Buremte Gloves",
		legs="Eri. Leg Guards +1",
		feet="Rager Ledel. +1",
		neck="Unmoving Collar",
		waist="Kasiri Belt",
		left_ear="Cryptic Earring",
		right_ear="Eris' Earring",
		left_ring="Provocare Ring",
		right_ring="Eihwaz Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}

	--------------------------------------
	-- Precast sets
	--------------------------------------

	-- Precast sets to enhance JAs
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Seeth. Bomblet +1",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Carm. Scale Mail", augments={'Attack+15','"Mag.Atk.Bns."+10','"Dbl.Atk."+2',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs="Shned. Tights +1",
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Eddy Necklace",
		waist="Flume Belt +1",
		left_ear="Friomisi Earring",
		right_ear="Crematio Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Fenrir Ring +1",
		back="Argocham. Mantle",
	}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['Vivacious Pulse'] = {
		ammo="Impatiens",
		head="Erilaz Galea +1",
		body="Vanir Cotehardie",
		neck="Incanter's Torque",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Healing Earring",
		right_ring="Ephedra Ring",
	}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity


	-- Fast cast sets for spells
    sets.precast.FC = {
		ammo="Impatiens",
		head="Rune. Bandeau +1",
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
		hands="Runeist Mitons +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Voltsurge Torque",
		waist="Olympus Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",
	}
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash", legs="Futhark Trousers +1"})
    sets.precast.FC['Utsusemi: Ichi'] = set_combine(sets.precast.FC, {neck='Magoraga beads', back="Mujin Mantle"})
    sets.precast.FC['Utsusemi: Ni'] = set_combine(sets.precast.FC['Utsusemi: Ichi'], {})


	-- Weaponskill sets
    sets.precast.WS['Resolution'] = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Herculean Vest", augments={'Mag. Acc.+25','Weapon skill damage +2%','INT+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
		left_ring="Epona's Ring",
		right_ring="Ifrit Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS['Resolution'].Normal, 
        {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Herculean Vest", augments={'Mag. Acc.+25','Weapon skill damage +2%','INT+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}},
		left_ring="Epona's Ring",
		right_ring="Ifrit Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.precast.WS['Dimidiation'] = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Seeth. Bomblet +1",
		head={ name="Lustratio Cap", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		feet={ name="Lustratio Leggings", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Ramuh Ring +1",
		right_ring="Ramuh Ring +1",
		back="Agema Cape",
	}
    sets.precast.WS['Dimidiation'].Acc = set_combine(sets.precast.WS['Dimidiation'].Normal, 
        {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Seeth. Bomblet +1",
		head={ name="Lustratio Cap", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Lustratio Subligar", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		feet={ name="Lustratio Leggings", augments={'Accuracy+15','DEX+5','Crit. hit rate+2%',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Ramuh Ring +1",
		right_ring="Ramuh Ring +1",
		back="Agema Cape",
	}
	
    sets.precast.WS['Herculean Slash'] = set_combine(sets.precast['Lunge'], {hands="Umuthi Gloves"})
    sets.precast.WS['Herculean Slash'].Acc = set_combine(sets.precast.WS['Herculean Slash'].Normal, {})


	--------------------------------------
	-- Midcast sets
	--------------------------------------
	
    sets.midcast.FastRecast = {}
    sets.midcast['Enhancing Magic'] = {
		ammo="Impatiens",
		head="Rune. Bandeau +1",
		body={ name="Taeon Tabard", augments={'"Fast Cast"+5',}},
		hands="Runeist Mitons +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','"Store TP"+4','MND+7','"Mag.Atk.Bns."+6',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Voltsurge Torque",
		waist="Olympus Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",
	}
    sets.midcast['Phalanx'] = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast['Regen'] = {head="Runeist Bandeau +1", legs="Futhark Trousers +1"}
    sets.midcast['Stoneskin'] = {waist="Siegel Sash"}
    sets.midcast.Cure = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Aqreqaq Bomblet",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body="Vanir Cotehardie",
		hands="Runeist Mitons +1",
		legs={ name="Carmine Cuisses", augments={'Accuracy+10','DEX+10','MND+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Incanter's Torque",
		waist="Bishop's Sash",
		left_ear="Beatific Earring",
		right_ear="Healing Earring",
		left_ring="Ephedra Ring",
		right_ring="Ephedra Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.idle = {
		ammo="Homiliary",
		head="Oce. Headpiece +1",
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands="Erilaz Gauntlets +1",
		legs={ name="Carmine Cuisses", augments={'Accuracy+10','DEX+10','MND+15',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Wiglen Gorget",
		waist="Fucho-no-Obi",
		left_ear="Dawn Earring",
		right_ear="Etiolation Earring",
		left_ring="Paguroidea Ring",
		right_ring="Sheltered Ring",
		back="Archon Cape",
	}
    sets.idle.Refresh = set_combine(sets.idle, {body="Runeist Coat +1", waist="Fucho-no-obi"})
           
	sets.defense.PDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body="Erilaz Surcoat +1",
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Colossus's Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back="Archon Cape",
	}

	sets.defense.MDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head="Erilaz Galea +1",
		body="Erilaz Surcoat +1",
		hands="Erilaz Gauntlets +1",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Inq. Bead Necklace",
		waist="Flume Belt +1",
		left_ear="Etiolation Earring",
		right_ear="Zennaroi Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back="Engulfer Cape +1",
	}

	sets.Kiting = {feet="Skadi's Jambeaux +1"}


	--------------------------------------
	-- Engaged sets
	--------------------------------------

    sets.engaged = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.engaged.DD = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Ginsen",
		head={ name="Herculean Helm", augments={'Accuracy+21 Attack+21','Weapon skill damage +2%','DEX+2','Accuracy+13',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+22 Attack+22','Weapon skill damage +2%','Accuracy+9',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+13 Attack+13','"Triple Atk."+3','MND+2','Accuracy+15','Attack+15',}},
		neck="Lissome Necklace",
		waist="Windbuffet Belt +1",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Epona's Ring",
		right_ring="Rajas Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.engaged.Acc = set_combine(sets.engaged.DD, {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Yamarang",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Adhemar Wristbands", augments={'DEX+10','AGI+10','Accuracy+15',}},
		legs={ name="Carmine Cuisses", augments={'Accuracy+10','DEX+10','MND+15',}},
		feet={ name="Carmine Greaves", augments={'Accuracy+10','DEX+10','MND+15',}},
		neck="Sanctity Necklace",
		waist="Olseni Belt",
		left_ear="Telos Earring",
		right_ear="Zennaroi Earring",
		left_ring="Ephedra Ring",
		right_ring="Epona's Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	})
    sets.engaged.PDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body="Erilaz Surcoat +1",
		hands="Buremte Gloves",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}
    sets.engaged.MDT = {
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		sub="Refined Grip +1",
		ammo="Staunch Tathlum",
		head={ name="Fu. Bandeau +1", augments={'Enhances "Battuta" effect',}},
		body="Erilaz Surcoat +1",
		hands="Buremte Gloves",
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Moonbeam Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+2','"Embolden"+9','"Dbl.Atk."+3','Damage taken-5%',}},
	}

end

------------------------------------------------------------------
-- Action events
------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.english == 'Lunge' or spell.english == 'Swipe' then
        local obi = get_obi(get_rune_obi_element())
        if obi then
            equip({waist=obi})
        end
    end
end


function job_aftercast(spell)
    if not spell.interrupted then
        if spell.type == 'Rune' then
            update_timers(spell)
        elseif spell.name == "Lunge" or spell.name == "Gambit" or spell.name == 'Rayke' then
            reset_timers()
        elseif spell.name == "Swipe" then
            send_command(trim(1))
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Customization hooks for idle and melee sets, after they've been automatically constructed.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other events.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'WAR' then
		set_macro_page(3, 20)
	elseif player.sub_job == 'NIN' then
		set_macro_page(1, 20)
	elseif player.sub_job == 'SAM' then
		set_macro_page(2, 20)
	else
		set_macro_page(5, 20)
	end
end

function get_rune_obi_element()
    weather_rune = buffactive[elements.rune_of[world.weather_element] or '']
    day_rune = buffactive[elements.rune_of[world.day_element] or '']
    
    local found_rune_element
    
    if weather_rune and day_rune then
        if weather_rune > day_rune then
            found_rune_element = world.weather_element
        else
            found_rune_element = world.day_element
        end
    elseif weather_rune then
        found_rune_element = world.weather_element
    elseif day_rune then
        found_rune_element = world.day_element
    end
    
    return found_rune_element
end

function get_obi(element)
    if element and elements.obi_of[element] then
        return (player.inventory[elements.obi_of[element]] or player.wardrobe[elements.obi_of[element]]) and elements.obi_of[element]
    end
end


------------------------------------------------------------------
-- Timer manipulation
------------------------------------------------------------------

-- Add a new run to the custom timers, and update index values for existing timers.
function update_timers(spell)
    local expires_time = os.time() + 300
    local entry_index = rune_count(spell.name) + 1

    local entry = {rune=spell.name, index=entry_index, expires=expires_time}

    rune_timers:append(entry)
    local cmd_queue = create_timer(entry).. ';wait 0.05;'
    
    cmd_queue = cmd_queue .. trim()

    add_to_chat(123,'cmd_queue='..cmd_queue)

    send_command(cmd_queue)
end

-- Get the command string to create a custom timer for the provided entry.
function create_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    local duration = entry.expires - os.time()
    return 'timers c ' .. timer_name .. ' ' .. tostring(duration) .. ' down'
end

-- Get the command string to delete a custom timer for the provided entry.
function delete_timer(entry)
    local timer_name = '"Rune: ' .. entry.rune .. '-' .. tostring(entry.index) .. '"'
    return 'timers d ' .. timer_name .. ''
end

-- Reset all timers
function reset_timers()
    local cmd_queue = ''
    for index,entry in pairs(rune_timers) do
        cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
    end
    rune_timers:clear()
    send_command(cmd_queue)
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

-- Remove the oldest rune(s) from the table, until we're below the max_runes limit.
-- If given a value n, remove n runes from the table.
function trim(n)
    local cmd_queue = ''

    local to_remove = n or (rune_timers:length() - max_runes)

    while to_remove > 0 and rune_timers:length() > 0 do
        local oldest
        for index,entry in pairs(rune_timers) do
            if oldest == nil or entry.expires < rune_timers[oldest].expires then
                oldest = index
            end
        end
        
        cmd_queue = cmd_queue .. prune(rune_timers[oldest].rune)
        to_remove = to_remove - 1
    end
    
    return cmd_queue
end

-- Drop the index of all runes of a given type.
-- If the index drops to 0, it is removed from the table.
function prune(rune)
    local cmd_queue = ''
    
    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            cmd_queue = cmd_queue .. delete_timer(entry) .. ';wait 0.05;'
            entry.index = entry.index - 1
        end
    end

    for index,entry in pairs(rune_timers) do
        if entry.rune == rune then
            if entry.index == 0 then
                rune_timers[index] = nil
            else
                cmd_queue = cmd_queue .. create_timer(entry) .. ';wait 0.05;'
            end
        end
    end
    
    return cmd_queue
end


------------------------------------------------------------------
-- Reset events
------------------------------------------------------------------

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)
windower.raw_register_event('status change',function(new, old)
    if gearswap.res.statuses[new].english == 'Dead' then
        reset_timers()
    end
end)




