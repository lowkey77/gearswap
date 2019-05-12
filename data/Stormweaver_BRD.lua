-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('organizer-lib')	
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'Dummy', 'FullLength'}

    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false

    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'fishing')

    brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
    pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

    select_default_macro_book()
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FC = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub="Genbu Shield",
		range="Gjallarhorn",
		head="Nares Cap",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves",
		legs="Artsieq Hose",
		feet="Navon Crackows",
		neck="Voltsurge Torque",
		waist="Channeler's Stone",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
	}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		right_ear="Mendi. Earring",
		back="Pahtli Cape",})

    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC, {
		head="Umuthi Hat",
		main="Pukulatmuj",
		sub="Culminus",})

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC)

    sets.precast.FC.BardSong = {
		main="Felibre's Dague",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Aoidos' Earring",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		waist="Channeler's Stone",
		legs="Artsieq Hose",
		feet="Telchine Pigaches"
		}
	
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Gjallarhorn"})	

    sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet={ name="Bihu Slippers +1", augments={'Enhances "Nightingale" effect',}}}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps +1"}
    sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {range="Gjallarhorn",
        head="Nahtirah Hat",
        body="Gendewitha Bliaut",hands="Buremte Gloves",
        back="Kumbira Cape",legs="Gendewitha Spats",feet="Gendewitha Galoshes"}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {range="Gjallarhorn",
        head="Nahtirah Hat",neck="Fotia Gorget",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Bihu Justaucorps +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Caudata Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS)

    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS)

    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub="Genbu Shield",
		range="Gjallarhorn",
		head="Nares Cap",
		body="Inyanga Jubbah +2",
		hands="Leyline Gloves",
		legs="Artsieq Hose",
		feet="Navon Crackows",
		neck="Voltsurge Torque",
		waist="Channeler's Stone",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back="Perimede Cape",
		}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Gjallarhorn is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
	sets.midcast.Prelude = {back="Intarabus's Cape"}	
    sets.midcast.Lullaby = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Inyanga Tiara +2",
		body="Fili Hongreline +1",
		hands="Inyanga Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +2",
		neck="Moonbow Whistle",
		waist="Luminary Sash",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		}
    sets.midcast.Madrigal = {head="Fili Calot +1", back="Intarabus's Cape"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {}
    sets.midcast.Paeon = {head="Brioso Roundlet +2"}
    sets.midcast.Carol = {head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Fili Rhingrave +1",
		feet="Fili Cothurnes +1",}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.SongEffect,{range="Gjallarhorn",hands="Fili Manchettes +1"})	
    sets.midcast['Magic Finale'] = {neck="Wind Torque",waist="Corvax Sash",legs="Fili Rhingrave +1"}

    sets.midcast.Mazurka = {range=info.ExtraSongInstrument}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
	    sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +2",
		neck="Moonbow Whistle",
		--waist="Aoidos' Matinee",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
		main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +2",
		body="Brioso Justau. +2",
		hands="Brioso Cuffs +2",
		legs="Brioso Cannions +2",
		feet="Brioso Slippers +2",
		neck="Moonbow Whistle",
		waist="Luminary Sash",
		left_ear="Hermetic Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {main="Kaja Knife",sub="Mephitis Grip",range="Gjallarhorn",
        head="Brioso Roundlet +2",neck="Wind Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Brioso Justaucorps +3",hands="Aoidos' Manchettes +2",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Kumbira Cape",waist="Demonry Sash",legs="Brioso Cannions +1",feet="Bokwus Boots"}

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",
        ring1="Prolix Ring",
        back="Harmony Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {
		main="Felibre's Dague",
	    sub={ name="Genbu's Shield", augments={'"Cure" potency +3%','HP+30','"Cure" spellcasting time -8%',}},
		range=info.ExtraSongInstrument,
		head="Nahtirah Hat",
		body="Vanya Robe",
		hands={ name="Leyline Gloves", augments={'Accuracy+10','Mag. Acc.+7','"Fast Cast"+1',}},
		legs={ name="Lengo Pants", augments={'INT+7','Mag. Acc.+7','"Mag.Atk.Bns."+3','"Refresh"+1',}},
		feet="Telchine Pigaches",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Prolix Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		}

    -- Other general spells and classes.
    sets.midcast.Cure = {name="Serenity", augments={'MP+50','Enha.mag. skill +10','"Cure" potency +5%','"Cure" spellcasting time -10%',},
		range="Gjallarhorn",
		head={ name="Gende. Caubeen +1", augments={'Phys. dmg. taken -1%','"Cure" potency +4%',}},
		body={ name="Vanya Robe", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -1%','"Cure" potency +1%',}},
		legs={ name="Vanya Slops", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}},
		feet={ name="Medium's Sabots", augments={'MP+45','MND+9','"Conserve MP"+5','"Cure" potency +4%',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Lifestorm Earring",
		right_ear="Mendi. Earring",
		left_ring="Levia. Ring",
		right_ring="Stikini Ring",
		back="Pahtli Cape",}
        
    sets.midcast.Curaga = sets.midcast.Cure
        
    sets.midcast.Stoneskin = {
        head="Umuthi Hat",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +6',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +8',}},
		legs="Portent Pants",
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
		neck="Voltsurge Torque",
		waist="Siegel Sash",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back="Fi Follet Cape +1",}
        
    sets.midcast.Cursna = {
        neck="Malison Medallion",
        hands="Hieros Mittens",ring1="Ephedra Ring"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {main=gear.Staff.HMP, 
        body="Gendewitha Bliaut",
        legs="Lengo Pants",feet="Chelona Boots +1"}
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
		main="Mafic Cudgel",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Incanter's Torque",
		waist="Fucho-no-Obi",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Meridian Ring",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
		}

    sets.idle.PDT = {
		main="Mafic Cudgel",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Incanter's Torque",
		waist="Fucho-no-Obi",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Meridian Ring",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
		}

    sets.idle.Town = {
		main="Mafic Cudgel",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Incanter's Torque",
		waist="Fucho-no-Obi",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Meridian Ring",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
		}
    
    sets.idle.Weak = {
		main="Mafic Cudgel",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet="Inyan. Crackows +2",
		neck="Incanter's Torque",
		waist="Fucho-no-Obi",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Meridian Ring",
		right_ring="Stikini Ring +1",
		back="Perimede Cape",
		}
	
	sets.idle.fishing = {main="Kaja Knife",
    sub="Genbu's Shield",
    range="Ebisu Fishing Rod",
    ammo="Meatball",
    head="Fili Calot +1",
    body="Fisherman's Apron",
    hands="Angler's Gloves",
    legs="Fisherman's Hose",
    feet="Waders",
    neck="Sanctity Necklace",
    waist="Flume Belt",
    left_ear="Infused Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Paguroidea Ring",
    right_ring="Sheltered Ring",
    back="Kumbira Cape",}
    
    
    -- Defense sets

    sets.defense.PDT = {main="Kaja Knife",
	sub="Genbu's Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +1", augments={'Enhances "Nightingale" effect',}},
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Infused Earring",
    right_ear="Genmei Earring",
    left_ring="Paguroidea Ring",
    right_ring="Warp Ring",
    back="Solemnity Cape",}

    sets.defense.MDT = {main="Kaja Knife",
	sub="Genbu's Shield",
    range="Gjallarhorn",
    head="Fili Calot +1",
    body="Fili Hongreline +1",
    hands="Fili Manchettes +1",
    legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
    feet={ name="Bihu Slippers +1", augments={'Enhances "Nightingale" effect',}},
    neck="Loricate Torque +1",
    waist="Flume Belt",
    left_ear="Infused Earring",
    right_ear="Genmei Earring",
    left_ring="Paguroidea Ring",
    right_ring="Warp Ring",
    back="Solemnity Cape",}

    sets.Kiting = {feet="Aoidos' Cothurnes +2"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Basic set for if no TP weapon is defined.
    sets.engaged = {		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Witful Belt",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Mephitas's Ring",
		right_ring="Inyanga Ring",
		back="Shadow Mantle",}

    -- Sets with weapons defined.
    sets.engaged.Dagger = {range="Angel Lyre",
        head="Nahtirah Hat",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Bihu Justaucorps +1",hands="Buremte Gloves",ring1="Rajas Ring",ring2="K'ayres Ring",
        back="Atheling Mantle",waist="Goading Belt",legs="Brioso Cannions +1",feet="Gendewitha Galoshes"}

    -- Set if dual-wielding
    sets.engaged.DW = {
		head="Aya. Zucchetto +1",
		body="Ayanmo Corazza +2",
		hands="Aya. Manopolas +1",
		legs="Aya. Cosciales +1",
		feet="Aya. Gambieras +1",
		neck="Sanctity Necklace",
		waist="Witful Belt",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		left_ring="Mephitas's Ring",
		right_ring="Inyanga Ring",
		back="Shadow Mantle",}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if spell.english == "Ice Carol" then
			state.ExtraSongsMode.value = 'Dummy'	
        elseif spell.english == "Wind Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		--elseif spell.english == "Fire Carol" then 
			state.ExtraSongsMode.value = 'Dummy'
		--elseif spell.english == "Earth Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Lightning Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Ice Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Fire Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Wind Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Water Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Dark Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Light Carol" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == 'Honor March' then
			equip(sets.precast.FC.BardSong.HonorMarch)
		end
		-- Auto-Pianissimo
        if ((spell.target.type == 'PLAYER' and not spell.target.charmed) or (spell.target.type == 'NPC' and spell.target.in_party)) and
            not state.Buff['Pianissimo'] then
            
            local spell_recasts = windower.ffxi.get_spell_recasts()
            if spell_recasts[spell.recast_id] < 2 then
                send_command('@input /ja "Pianissimo" <me>; wait 1.5; input /ma "'..spell.name..'" '..spell.target.name)
                eventArgs.cancel = true
                return
            end
        end
		
    end

end

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
		if spell.english == 'Honor March' then
			equip(sets.midcast.HonorMarch)
		end	
    end
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end

        state.ExtraSongsMode:reset()
    end
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' and not spell.interrupted then
        if spell.target and spell.target.type == 'SELF' then
            adjust_timers(spell, spellMap)
        end
	end	
	if spell.type == 'BardSong' and not spell.interrupted then
		if state.ExtraSongsMode.value == 'Dummy' then	
			state.ExtraSongsMode.value = 'None'
		end	
	end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    pick_tp_weapon()
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

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end


-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell.name, spellMap)
    if custom_timers[spell.name] then
        -- Songs always overwrite themselves now, unless the new song has
        -- less duration than the old one (ie: old one was NT version, new
        -- one has less duration than what's remaining).
        
        -- If new song will outlast the one in our list, replace it.
        if custom_timers[spell.name] < (current_time + dur) then
            send_command('timers delete "'..spell.name..'"')
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.name..'" '..dur..' down')
            end
        end
    end
end

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spellName, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
    
    if player.equipment.main == "Kaja Knife" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
    if player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if player.equipment.legs == "Mdk. Shalwar +1" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.11 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Aoidos' Calot +2" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Aoidos' Hngrln. +2" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Ad. Mnchtte. +2' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Aoidos' Rhing. +2" then mult = mult + 0.1 end
    if spellName == "Sentinel's Scherzo" and player.equipment.feet == "Aoidos' Cothrn. +2" then mult = mult + 0.1 end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spellName == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
    
    local totalDuration = math.floor(mult*120)

    return totalDuration
end


-- Examine equipment to determine what our current TP weapon is.
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(5, 3)
end


windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)

