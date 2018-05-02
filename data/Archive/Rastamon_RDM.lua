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
    state.Buff.Saboteur = buffactive.saboteur or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')

    gear.default.obi_waist = "Sekhmet Corset"
    
    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Chainspell'] = {body="Vitivation Tabard +1"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Atrophy Chapeau +1",
        body="Atrophy Tabard +1",hands="Yaoyotl Gloves",
        back="Refraction Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    -- 80% Fast Cast (including trait) for all spells, plus 5% quick cast
    -- No other FC sets necessary.
	--85% FC
    sets.precast.FC = {
    main={ name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}}, --4%
    sub="Clerisy Strap",--2%
    ammo="Impatiens",
    head="Atrophy Chapeau +1", --12%
    body="Zendik Robe",--13%
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs="Gyve Trousers",--4%
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},--5%
    neck="Voltsurge Torque",--4%
    waist="Witful Belt",--3%
    left_ear="Estq. Earring",--2%
    right_ear="Enchntr. Earring +1",--2%
    left_ring="Veneficium Ring",
    right_ring="Prolix Ring",--2%
    back="Perimede Cape",
}

    sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, 
        {neck="Soil Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        ring1="Aquasoul Ring",ring2="Aquasoul Ring",waist="Soil Belt"})

    sets.precast.WS['Sanguine Blade'] = {ammo="Witchstone",
        head="Hagondes Hat",neck="Eddy Necklace",ear1="Friomisi Earring",ear2="Hecate's Earring",
        body="Hagondes Coat",hands="Yaoyotl Gloves",ring1="Strendu Ring",ring2="Acumen Ring",
        back="Toro Cape",legs="Hagondes Pants",feet="Hagondes Sabots"}

    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
		main="Bolelabunga",
		sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
		ammo="Impatiens",
		head="Atrophy Chapeau +1", --10%
		body="Zendik Robe",--13%
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs="Gyve Trousers",--4%
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},--5%
		neck="Voltsurge Torque",--4%
		waist="Witful Belt",--3%
		left_ear="Estq. Earring",--2%
		right_ear="Enchntr. Earring +1",--2%
		left_ring="Veneficium Ring",
		right_ring="Prolix Ring",--2%
		back="Swith Cape +1",--4$
	}

    sets.midcast.Cure = {
		main={ name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',}},
		sub="Clerisy Strap",
		ammo="Homiliary",
		head={ name="Vanya Hood", augments={'MP+50','"Cure" potency +7%','Enmity-6',}},
		body="Zendik Robe",
		hands="Atrophy Gloves +1",
		legs="Nares Trews",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Fucho-no-Obi",
		left_ear="Gwati Earring",
		right_ear="Mendi. Earring",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Perimede Cape",
	}
        
    sets.midcast.Curaga = sets.midcast.Cure
    --sets.midcast.CureSelf = {ring1="Kunaji Ring",ring2="Asklepian Ring"}

    sets.midcast['Enhancing Magic'] = {
    main="Bolelabunga",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Leth. Chappel +1",
    body="Lethargy Sayon +1",
    hands="Atrophy Gloves +1",
    legs="Estqr. Fuseau +2",
    feet="Leth. Houseaux +1",
    neck="Incanter's Torque",
    waist="Luminary Sash",
    left_ear="Gwati Earring",
    right_ear="Andoaa Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Sucellos's Cape", augments={'Mag. Acc+20 /Mag. Dmg.+20',}},
}

    sets.midcast.Refresh = {head="Almaric Coif", legs="Lethargy Fuseau +1"}
	sets.midcast.Regen = {main="Bolelabunga"}

    sets.midcast.Stoneskin = {head="Umuthi Hat", neck="Nordens Gorget", waist="Siegel Sash" , legs="Doyen pants"}
    
	sets.midcast['Enfeebling Magic'] = {
		main={ name="Grioavolr", augments={'Enfb.mag. skill +14','MP+22','Mag. Acc.+25','"Mag.Atk.Bns."+15','Magic Damage +1',}},
		sub="Mephitis Grip",
		ammo="Pemphredo Tathlum",
		head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
		body={ name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}},
		hands="Leth. Gantherots +1",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+28','Spell interruption rate down -4%','CHR+14',}},
		feet={ name="Medium's Sabots", augments={'MP+50','MND+8','"Conserve MP"+6','"Cure" potency +3%',}},
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Gwati Earring",
		right_ear="Hermetic Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}},
	}

    sets.midcast['Dia III'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +1"})
	
	sets.midcast['Paralyze II'] = set_combine(sets.midcast['Enfeebling Magic'], {feet="Vitivation boots +1",})
	
	sets.midcast['Blind II'] = (sets.midcast['Enfeebling Magic'])

    sets.midcast['Slow II'] = set_combine(sets.midcast['Enfeebling Magic'], {head="Vitivation Chapeau +1"})
    
    sets.midcast['Elemental Magic'] = {
    main={ name="Colada", augments={'INT+2','Mag. Acc.+25','"Mag.Atk.Bns."+24','DMG:+3',}},
    sub="Culminus",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst dmg.+10%','INT+4',}},
    body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+23','Magic burst dmg.+10%','MND+7','Mag. Acc.+12',}},
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Mizu. Kubikazari",
    waist="Yamabuki-no-Obi",
    left_ear="Halasz Earring",
    right_ear="Hecate's Earring",
    left_ring="Mujin Band",
    right_ring="Locus Ring",
    back="Seshaw Cape",
}
        
    sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'], {head=empty,body="Twilight Cloak"})

    sets.midcast['Dark Magic'] = {
    main={ name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Shango Robe",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs="Portent Pants",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Erra Pendant",
    waist="Casso Sash",
    right_ear="Hermetic Earring",
    left_ear="Gwati Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Perimede Cape",
}

    sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})

    sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
    sub="Culminus", ring1="Excelsis Ring", waist="Fucho-no-Obi"})

    sets.midcast.Aspir = sets.midcast.Drain


    -- Sets for special buff conditions on spells.

    sets.midcast.EnhancingDuration = {sub="Ammurapi Shield", hands="Atrophy Gloves +1",back="Sucellos's Cape",feet="Lethargy Houseaux +1"}
        
    sets.buff.ComposureOther = {head="Lethargy Chappel +1",
        body="Lethargy Sayon +1",hands="Lethargy Gantherots +1",
        legs="Lethargy Fuseau +1",feet="Lethargy Houseaux +1"}

    sets.buff.Saboteur = {hands="Lethargy Gantherots +1"}
    

    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {
    main="Bolelabunga",
    sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    ritht_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Altruistic Cape",
}
    

    -- Idle sets
    sets.idle = {
    main="Bolelabunga",
    sub="Culminus",
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Perimede Cape",
}

    sets.idle.Town = {
    main="Bolelabunga",
    sub="Culminus",
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Perimede Cape",
}
    
    sets.idle.Weak = {
    main="Bolelabunga",
    sub="Culminus",
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Perimede Cape",
}

    sets.idle.PDT = {
    main="Bolelabunga",
    sub="Culminus",
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Perimede Cape",
}

    sets.idle.MDT = {
    main="Bolelabunga",
    sub="Culminus",
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Perimede Cape",
}
    
    
    -- Defense sets
    sets.defense.PDT = {
    main="Bolelabunga",
    sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Altruistic Cape",
}

    sets.defense.MDT = {
    main="Bolelabunga",
    sub={ name="Genbu's Shield", augments={'"Cure" potency +2%','"Cure" spellcasting time -7%',}},
    ammo="Homiliary",
    head={ name="Viti. Chapeau +1", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}},
    body="Atrophy Tabard +1",
    hands="Atrophy Gloves +1",
    legs="Nares Trews",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
    neck="Nodens Gorget",
    waist="Fucho-no-Obi",
    left_ear="Gwati Earring",
    right_ear="Hermetic Earring",
    left_ring="Meridian Ring",
    right_ring="Persis Ring",
    back="Altruistic Cape",
}

    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}

    sets.engaged.Defense = {
		ammo="Homiliary",
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +1",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Combatant's Torque",
		waist="Kentarch Belt",
		left_ear="Telos Earring",
		right_ear="Cessance Earring",
		left_ring="Cacoethic Ring +1",
		right_ring="Chirich Ring",
		back="Agema Cape",
		}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Run after the default midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.skill == 'Enfeebling Magic' and state.Buff.Saboteur then
        equip(sets.buff.Saboteur)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingDuration)
        if buffactive.composure and spell.target.type == 'PLAYER' then
            equip(sets.buff.ComposureOther)
        end
    elseif spellMap == 'Cure' and spell.target.type == 'SELF' then
        equip(sets.midcast.CureSelf)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 7)
    else
        set_macro_page(1, 7)
    end
end
