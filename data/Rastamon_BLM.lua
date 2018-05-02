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

end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant', 'Proc')
    state.IdleMode:options('Normal', 'Death', 'PDT')    
    state.MagicBurst = M(true, 'Magic Burst')

    lowTierNukes = S{'Stone', 'Water', 'Aero', 'Fire', 'Blizzard', 'Thunder',
        'Stone II', 'Water II', 'Aero II', 'Fire II', 'Blizzard II', 'Thunder II',
        'Stone III', 'Water III', 'Aero III', 'Fire III', 'Blizzard III', 'Thunder III',
        'Stonega', 'Waterga', 'Aeroga', 'Firaga', 'Blizzaga', 'Thundaga',
        'Stonega II', 'Waterga II', 'Aeroga II', 'Firaga II', 'Blizzaga II', 'Thundaga II'}

    gear.macc_hagondes = {name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+29'}}
    
    -- Additional local binds
    send_command('bind ^` input /ma Stun <t>')
    send_command('bind @` gs c activate MagicBurst')

    select_default_macro_book()
end

-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind @`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    ---- Precast Sets ----
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Mana Wall'] = {feet="Wicce Sabots"}

    sets.precast.JA.Manafont = {body="Sorcerer's Coat +2"}
    
    -- equip to maximize HP (for Tarus) and minimize MP loss before using convert
    sets.precast.JA.Convert = {}

sets.precast.Death={
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Clerisy Strap",
    ammo="Impatiens",
    head="Pixie Hairpin +1",
    body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+23',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Stoicheion Medal",
    waist="Forest Rope",
    left_ear="Barkaro. Earring",
    right_ear="Loquac. Earring",
    left_ring="Archon Ring",
    right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%','Breath dmg. taken -3%','Magic dmg. taken -4%',}},
    back={ name="Taranus's Cape", augments={'Elem. magic skill +10','Dark magic skill +9','"Mag.Atk.Bns."+1','"Fast Cast"+4',}},
}
    -- Fast cast sets for spells

    sets.precast.FC = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Impatiens",
        head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		neck="Voltsurge Torque",
		ear1="Enchanter earring +1",
		ear2="Loquacious Earring",
        body="Zendik Robe",ring1="Prolix Ring", ring2="Veneficium ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Gyve Trousers",feet="Amalric Nails",}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

    sets.precast.FC['Elemental Magic'] = set_combine(sets.precast.FC, {head="Wicce Petasos", neck="Mizukage-no-Kubikazari"})

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {body="Heka's Kalasiris", back="Pahtli Cape"})

    sets.precast.FC.Curaga = sets.precast.FC.Cure

    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hagondes Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands="Yaoyotl Gloves",ring1="Rajas Ring",ring2="Icesoul Ring",
        back="Refraction Cape",waist="Cognition Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Vidohunir'] = {ammo="Dosis Tathlum",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Barkarole Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands="Yaoyotl Gloves",ring1="Icesoul Ring",ring2="Acumen Ring",
        back="Toro Cape",waist="Thunder Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
    
    
    ---- Midcast Sets ----

    sets.midcast.FastRecast = {
        head="Befouled Crown",ear2="Loquacious Earring",
        body="Shango Robe",hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Prolix Ring",
        back="Swith Cape +1",waist="Goading Belt",legs="Amalric Slops",feet="Amalric Nails"}

    sets.midcast.Cure = {main="Tamaxchi",sub="Genbu's Shield",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		neck="Incanter's Torque",ear2="Loquacious Earring",
        body="Heka's Kalasiris",hands="Telchine Gloves",ring1="Ephedra Ring",ring2="Sirona's Ring",
        back="Swith Cape +1",waist=gear.ElementalObi,legs="Nares Trews",feet="Hagondes Sabots"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast['Enhancing Magic'] = {
        head="Befouled Crown",
		neck="Incanter's Torque",
        body="Manasa Chasuble",hands="Telchine Gloves",
        legs="Portent Pants"}
    
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast['Enfeebling Magic'] = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Ghastly Tathlum",
        head="Befouled Crown",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Spaekona's Coat +1",hands="Lurid Mitts",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Altruistic Cape",waist="Casso Sash",legs="Portent Pants",feet="Hagondes Sabots"}
        
    sets.midcast.ElementalEnfeeble = sets.midcast['Enfeebling Magic']

    sets.midcast['Dark Magic'] = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Ghastly Tathlum",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Shango Robe",
		hands="Hagondes Cuffs",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Taranus's Cape",waist="Goading Belt",legs="Portent Pants",feet="Wicce Sabots"}

    sets.midcast.Drain = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Shango Robe",
		hands="Hagondes Cuffs",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Taranus's Cape",waist="Fucho-no-Obi",legs="Portent Pants",feet="Wicce Sabots"}
    
    sets.midcast.Aspir = sets.midcast.Drain

    sets.midcast.Stun = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Ghastly Tathlum",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands="Yaoyotl Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Taranus's Cape",waist="Witful Belt",legs="Orvail Pants +1",feet="Bokwus Boots"}

    sets.midcast.BardSong = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Sturm's Report",
        head="Nahtirah Hat",neck="Incanter's Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Refraction Cape",legs="Bokwus Slops",feet="Bokwus Boots"}


    -- Elemental Magic sets
    
    sets.midcast['Elemental Magic'] = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Witchstone",
        head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst mdg.+10%','INT+4',}},
		neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Halasz Earring",
        --body="Spae. Coat +1",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
		ring1="Shiva Ring",ring2="Strendu Ring",
        back="Taranus's Cape",waist=gear.ElementalObi,legs="Amalric Slops",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},}

    sets.midcast['Elemental Magic'].Resistant = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Witchstone",
        head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst mdg.+10%','INT+4',}},
		neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Halasz Earring",
        body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
		ring1="Stikini Ring",ring2="Stikini Ring",
        back="Taranus's Cape",waist=gear.ElementalObi,legs="Amalric Slops", feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},}

    sets.midcast['Elemental Magic'].HighTierNuke = set_combine(sets.midcast['Elemental Magic'], {sub="Wizzan Grip"})
    sets.midcast['Elemental Magic'].HighTierNuke.Resistant = set_combine(sets.midcast['Elemental Magic'], {sub="Clerisy Strap"})


    -- Minimal damage gear for procs.
    sets.midcast['Elemental Magic'].Proc = {main="Earth Staff", sub="Clerisy Strap",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body="Manasa Chasuble",hands="Serpentes Cuffs",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Swith Cape +1",waist="Witful Belt",legs="Nares Trews",feet="Chelona Boots +1"}

	-- Death Gear
		sets.midcast.Death={
    main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Clerisy Strap",
    ammo="Impatiens",
    head="Kaabnax Hat",
    body="Amalric Doublet",
    hands={ name="Hagondes Cuffs", augments={'Phys. dmg. taken -3%','Mag. Acc.+23',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Stoicheion Medal",
    waist="Sekhmet Corset",
    left_ear="Barkaro. Earring",
    right_ear="Halasz Earring",
    left_ring="Archon Ring",
    right_ring="Fortified Ring",
    back={ name="Taranus's Cape", augments={'Elem. magic skill +10','Dark magic skill +9','"Mag.Atk.Bns."+1','"Fast Cast"+4',}},
}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main="Boonwell Staff",
    sub="Clerisy Strap",
    ammo="Impatiens",
    head="Befouled Crown",
    body="Wicce Coat",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    neck="Mizu. Kubikazari",
    waist="Fucho-no-Obi",
    left_ear="Barkaro. Earring",
    right_ear="Friomisi Earring",
    left_ring="Stikini Ring",
    right_ring="Paguroidea Ring",
    back={ name="Taranus's Cape", augments={'Elem. magic skill +10','Dark magic skill +9','"Mag.Atk.Bns."+1','"Fast Cast"+4',}},}
    

    -- sets
    
    -- Normal refresh idle set
    sets.idle = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Impatiens",
        head="Befouled Crown",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Loquacious Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Karieyh Ring",ring2="Paguroidea Ring",
        back="Taranus's Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},}

    -- Idle mode that keeps PDT gear on, but doesn't prevent normal gear swaps for precast/etc.
    sets.idle.PDT = {main="Earth Staff", sub="Clerisy Strap",ammo="Impatiens",
        head="Nahtirah Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Taranus's Cape",waist="Fucho-no-Obi",legs="Hagondes Pants",feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','Magic burst mdg.+11%','Mag. Acc.+10',}},}

    -- Idle mode scopes:
    -- Idle mode when weak.
    sets.idle.Weak = {main="Bolelabunga",sub="Genbu's Shield",ammo="Impatiens",
        head="Hagondes Hat",neck="Twilight Torque",ear1="Bloodgem Earring",ear2="Loquacious Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Defending Ring",ring2="Paguroidea Ring",
        back="Taranus's Cape",waist="Fucho-no-Obi",legs="Nares Trews",feet="Hagondes Sabots"}
    
    -- Town gear.
    sets.idle.Town = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
		sub="Clerisy Strap",ammo="Impatiens",
        head="Befouled Crown",neck="Mizukage-no-Kubikazari",ear1="Barkarole Earring",ear2="Friomisi Earring",
        body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ring1="Shiva Ring",ring2="Paguroidea Ring",
        back="Taranus's Cape",waist="Fucho-no-Obi",legs="Amalric Slops",feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','Magic burst mdg.+11%','Mag. Acc.+10',}},}
        
    -- Defense sets

    sets.defense.PDT = {main="Earth Staff",sub="Clerisy Strap",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Taranus's Cape",waist="Hierarch Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Nahtirah Hat",neck="Twilight Torque",
        body="Vanir Cotehardie",hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Shadow Ring",
        back="Tuilha Cape",waist="Hierarch Belt",legs="Bokwus Slops",feet="Hagondes Sabots"}

    sets.Kiting = {feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','Magic burst mdg.+11%','Mag. Acc.+10',}},}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    
    sets.buff['Mana Wall'] = {feet="Wicce Sabots"}

    sets.magic_burst = {main={ name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20',}},
    sub="Clerisy Strap",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst mdg.+10%','INT+4',}},
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
	--body="Spae. Coat +1",
	body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
    legs={ name="Helios Spats", augments={'"Mag.Atk.Bns."+23','"Fast Cast"+4','Magic burst mdg.+9%',}},
    feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+19','Magic burst mdg.+11%','Mag. Acc.+10',}},
    neck="Mizu. Kubikazari",
    left_ear="Barkaro. Earring",
    right_ear="Halasz Earring",
    left_ring="Mujin Band",
    right_ring="Strendu Ring",
    back="Taranus's Cape",}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
        head="Zelus Tiara",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Hagondes Coat",hands="Bokwus Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Taranus's Cape",waist="Goading Belt",legs="Hagondes Pants",feet="Hagondes Sabots"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spellMap == 'Cure' or spellMap == 'Curaga' then
        gear.default.obi_waist = "Witful Belt"
    elseif spell.skill == 'Elemental Magic' then
        gear.default.obi_waist = "Yamabuki-no-obi"
        if state.CastingMode.value == 'Proc' then
            classes.CustomClass = 'Proc'
        end
    end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)

end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Elemental Magic' and state.MagicBurst.value then
        equip(sets.magic_burst)
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    -- Lock feet after using Mana Wall.
    if not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet')
            equip(sets.buff['Mana Wall'])
            disable('feet')
        elseif spell.skill == 'Elemental Magic' then
            state.MagicBurst:reset()
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
    -- Unlock feet when Mana Wall buff is lost.
    if buff == "Mana Wall" and not gain then
        enable('feet')
        handle_equipping_gear(player.status)
    end
end

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','range')
        else
            enable('main','sub','range')
        end
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Custom spell mapping.
function job_get_spell_map(spell, default_spell_map)
    if spell.skill == 'Elemental Magic' and default_spell_map ~= 'ElementalEnfeeble' then
        --[[ No real need to differentiate with current gear.
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        else
            return 'HighTierNuke'
        end
        --]]
    end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 15)
end
