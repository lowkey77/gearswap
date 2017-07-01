-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Hasso = buffactive.Hasso or false
    state.Buff.Seigan = buffactive.Seigan or false
    state.Buff.Sekkanoki = buffactive.Sekkanoki or false
    state.Buff.Sengikori = buffactive.Sengikori or false
    state.Buff['Meikyo Shisui'] = buffactive['Meikyo Shisui'] or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
    state.PhysicalDefenseMode:options('PDT', 'Reraise')

    update_combat_form()
    
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !-')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote", back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Rao Kabuto",
        body="Flamma Korazin +1",hands="Wakido Kote +2",ring1="Spiral Ring",
        back="Iximulew Cape",waist="Caudata Belt",legs="Karieyh Brayettes +1",feet="Rao Sune-ate"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		sub="Utu Grip",
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body={ name="Valorous Mail", augments={'Accuracy+27','Weapon skill damage +4%','VIT+1',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Hizamaru Hizayoroi +1",
		feet={ name="Valorous Greaves", augments={'Accuracy+17','Weapon skill damage +4%','CHR+7',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Karieyh Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
    --sets.precast.WS.Acc = set_combine(sets.precast.WS, {back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {feet="Wakido Sune-ate +1"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {hands="Sakonji Kote"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ear2="Cessance Earring"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {neck="Justice Torque"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {neck="Fotia gorget", waist="Fotia Belt", left_ear="Moonshade Earring"})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia gorget"})
    sets.precast.WS['Tachi: Fudo'].Mod = set_combine(sets.precast.WS['Tachi: Fudo'], {waist="Fotia Belt"})
	
	sets.precast.WS['Tachi: Kaiten'] = set_combine(sets.precast.WS, {neck="Fotia gorget", left_ear="Ishvara Earring"})
    sets.precast.WS['Tachi: Kaiten'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia gorget"})
    sets.precast.WS['Tachi: Kaiten'].Mod = set_combine(sets.precast.WS['Tachi: Kaiten'], {waist="Fotia Belt"})

    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {neck="Fotia gorget", waist="Fotia Belt", left_ear="Moonshade Earring"})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia gorget"})
    sets.precast.WS['Tachi: Shoha'].Mod = set_combine(sets.precast.WS['Tachi: Shoha'], {waist="Fotia Belt"})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {neck="Fotia gorget",ear1="Telos Earring",ear2="Cessance Earring",})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia gorget",ear1="Telos Earring",ear2="Cessance Earring",})
    sets.precast.WS['Tachi: Rana'].Mod = set_combine(sets.precast.WS['Tachi: Rana'], {waist="Fotia Belt"})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {neck="Fotia gorget",waist="Fotia Belt", left_ear="Ishvara Earring"})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {neck="Fotia gorget",waist="Fotia Belt", left_ear="Ishvara Earring"})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, {neck="Fotia gorget",waist="Fotia Belt", left_ear="Ishvara Earring"})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {neck="Fotia gorget",waist="Fotia Belt", left_ear="Moonshade Earring"})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {neck="Fotia gorget",waist="Fotia Belt"})


    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Rao Kabuto",
        body="Flamma Korazin +1",hands="Wakido Kote +1",
        legs="Jokushu Haidate",feet="Rao Sune-ate"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {neck="Sanctity Necklace",ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle.Town = {
		sub="Utu Grip",
		ammo="Ginsen",
        head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		neck="Moonbeam Nodowa",
		body="Wakido Domaru +2",
		ear1="Telos Earring",
		ear2="Cessance Earring",
        head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		hands="Wakido Kote +2",
		ring1="Chirich Ring",
		ring2="Karieyh Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		waist="Ioskeha Belt",legs="Flamma Dirs +1",
		feet="Wakido sune-ate +3"
		}
    
    sets.idle.Field = {
        head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		neck="Moonbeam Nodowa",
		ear1="Odnowa Earring +1",
		ear2="Cessance Earring",
		body="Wakido Domaru +2",
        head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		hands="Wakido Kote +2",
		ring1="Chirich Ring",
		ring2="Karieyh Ring",
        back="Shadow Mantle",
		waist="Ioskeha Belt",
		legs="Karieyh Brayettes +1",
		feet="Wakido sune-ate +3"
		}

    sets.idle.Weak = {
        head="Twilight Helm",neck="Wiglen Gorget",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        body="Twilight Mail",hands="Wakido Kote +2",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Ioskeha Belt",legs="Karieyh Brayettes +1",feet="Rao Sune-ate"}
    
    -- Defense sets
    sets.defense.PDT = {
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
    body="Wakido Domaru +2",
    hands="Wakido Kote +2",
    legs="Flamma Dirs +1",
    feet="Wakido Sune. +3",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Odnowa Earring",
    left_ring="Defending Ring",
    right_ring="Karieyh Ring",
    back="Agema Cape",
		}

    sets.defense.Reraise = {
        head="Twilight Helm",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        body="Twilight Mail",hands="Wakido Kote +2",ring1="Patricius Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Ioskeha Belt",legs="Karieyh Brayettes +1",feet="Wakido sune-ate +3"}

    sets.defense.MDT = {
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
    body="Wakido Domaru +2",
    hands="Wakido Kote +2",
    legs="Flamma Dirs +1",
    feet="Wakido Sune. +3",
    neck="Loricate Torque +1",
    waist="Ioskeha Belt",
    left_ear="Odnowa Earring +1",
    right_ear="Odnowa Earring",
    left_ring="Defending Ring",
    right_ring="Karieyh Ring",
    back="Agema Cape",
		}

    sets.Kiting = {feet="Rao Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 437 GK, => 65 Store TP for a 5-hit (48 Store TP in gear)
    sets.engaged = {
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		--right_ring="Chirich Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
	
	--Accuracy set
	sets.engaged.Acc = {
    sub="Utu Grip",
    ammo="Amar Cluster",
	head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
    body="Wakido Domaru +2",
    hands="Wakido Kote +2",--6--
    legs="Flamma Dirs +1",--7--
    feet="Wakido sune-ate +3",--5--
    neck="Lissome Necklace",--4--
    waist="Ioskeha Belt",
    left_ear="Telos Earring",--5--
    right_ear="Cessance Earring",--3--
    left_ring="Chirich Ring",--5--
    right_ring="Chirich Ring",--5--
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	}
    
	--PDT Set
	sets.engaged.PDT = {range="Cibitshavore",
        head="Rao Kabuto",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        body="Mes'yohi Haubergeon",hands="Otronif Gloves",ring1="Patricius Ring",ring2="Defending Ring",
        back="Iximulew Cape",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    
	--ACC/PDT Set
	sets.engaged.Acc.PDT = {range="Cibitshavore",
        head="Rao Kabuto",neck="Twilight Torque",ear1="Telos Earring",ear2="Cessance Earring",
        body="Mes'yohi Haubergeon",hands="Otronif Gloves",ring1="Patricius Ring",ring2="K'ayres Ring",
        back="Letalis Mantle",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    
	--Reraise
	sets.engaged.Reraise = {
    head="Twilight Helm",
    body="Twilight Mail",
    feet={ name="Rao Sune-Ate", augments={'Accuracy+10','Attack+10','Evasion+15',}},
    neck="Subtlety Spec.",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Fortified Ring",
    right_ring="Paguroidea Ring",
    back={ name="Takaha Mantle", augments={'STR+2','"Zanshin"+2','"Store TP"+1','Meditate eff. dur. +5',}},}
	
	--ACC/Reraise	
    sets.engaged.Acc.Reraise = {
    head="Twilight Helm",
    body="Twilight Mail",
    feet={ name="Rao Sune-Ate", augments={'Accuracy+10','Attack+10','Evasion+15',}},
    neck="Subtlety Spec.",
    left_ear="Odnowa Earring",
    right_ear="Odnowa Earring +1",
    left_ring="Fortified Ring",
    right_ring="Paguroidea Ring",
    back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
    -- sets.engaged.Adoulin = {range="Cibitshavore",
        -- head="Rao Kabuto",neck="Asperity Necklace",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        -- body="Mes'yohi Haubergeon",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        -- back="Takaha Mantle",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    -- sets.engaged.Adoulin.Acc = {range="Cibitshavore",
        -- head="Rao Kabuto",neck="Asperity Necklace",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        -- body="Unkai Domaru +2",hands="Otronif Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        -- back="Letalis Mantle",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    -- sets.engaged.Adoulin.PDT = {range="Cibitshavore",
        -- head="Rao Kabuto",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        -- body="Mes'yohi Haubergeon",hands="Otronif Gloves",ring1="Patricius Ring",ring2="K'ayres Ring",
        -- back="Iximulew Cape",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    -- sets.engaged.Adoulin.Acc.PDT = {ammo="Honed Tathlum",
        -- head="Rao Kabuto",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        -- body="Mes'yohi Haubergeon",hands="Otronif Gloves",ring1="Patricius Ring",ring2="K'ayres Ring",
        -- back="Letalis Mantle",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    -- sets.engaged.Adoulin.Reraise = {range="Cibitshavore",
        -- head="Twilight Helm",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        -- body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        -- back="Ik Cape",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}
    -- sets.engaged.Adoulin.Acc.Reraise = {range="Cibitshavore",
        -- head="Twilight Helm",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Cessance Earring",
        -- body="Twilight Mail",hands="Otronif Gloves",ring1="Beeline Ring",ring2="K'ayres Ring",
        -- back="Letalis Mantle",waist="Dynamic Belt",legs="Wakido Haidate +1",feet="Rao Sune-ate"}


    sets.buff.Sekkanoki = {hands="Unkai Kote +2"}
    sets.buff.Sengikori = {feet="Unkai Sune-ate +2"}
    sets.buff['Meikyo Shisui'] = {feet="Sakonji Sune-ate"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic target handling to be done.
function job_pretarget(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' then
        -- Change any GK weaponskills to polearm weaponskill if we're using a polearm.
        if player.equipment.main=='Quint Spear' or player.equipment.main=='Quint Spear' then
            if spell.english:startswith("Tachi:") then
                send_command('@input /ws "Penta Thrust" '..spell.target.raw)
                eventArgs.cancel = true
            end
        end
    end
end

-- Run after the default precast() is done.
-- eventArgs is the same one used in job_precast, in case information needs to be persisted.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type:lower() == 'weaponskill' then
        if state.Buff.Sekkanoki then
            equip(sets.buff.Sekkanoki)
        end
        if state.Buff.Sengikori then
            equip(sets.buff.Sengikori)
        end
        if state.Buff['Meikyo Shisui'] then
            equip(sets.buff['Meikyo Shisui'])
        end
    end
end


-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    -- Effectively lock these items in place.
    if state.HybridMode.value == 'Reraise' or
        (state.DefenseMode.value == 'Physical' and state.PhysicalDefenseMode.value == 'Reraise') then
        equip(sets.Reraise)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_combat_form()
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)

end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if areas.Adoulin:contains(world.area) and buffactive.ionis then
        state.CombatForm:set('Adoulin')
    else
        state.CombatForm:reset()
    end
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'THF' then
        set_macro_page(3, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(4, 2)
    else
        set_macro_page(1, 2)
    end
end
