function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

	brd_daggers = S{'Izhiikoh', 'Atoyac', 'Aphotic Kukri'}
	pick_tp_weapon()
	
	gear.mabstaff = {name="Serenity",augments={"DMG:+18", "CHR+1", "Mag.Atk.Bns+27"}}
	gear.maccstaff = {name="Serenity",augments={"DMG:+12", "MND+2", "Mag. Acc.+22"}}
	
	-- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Daurdabla'
	-- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
	
	-- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
	
	-- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
	send_command('bind !` input /ma "Chocobo Mazurka" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind @f8 gs c toggle AutoNukeMode')

	select_default_macro_book()
end

function init_gear_sets()

	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets

	-- Fast cast sets for spells
	sets.precast.FC = {
		main="Carnwenhan",
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

	sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

	sets.precast.FC.BardSong = {
		main="Felibre's Dague",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		neck="Voltsurge Torque",
		ear1="Loquacious Earring",
		ear2="Aoidos' Earring",
		body="Brioso Justau. +3",
		--body="Brioso Justau. +3",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Kishar Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		waist="Channeler's Stone",
		legs="Artsieq Hose",
		feet="Telchine Pigaches"
		}

	-- Honor March
	sets.precast.FC['Honor March'] = set_combine(sets.precast.FC.BardSong,{range="Marsyas"})
	
	--4 Song Weapon
	sets.precast.FC.Daurdabla = set_combine(sets.precast.FC.BardSong, {range=info.ExtraSongInstrument})
		
	
	-- Precast sets to enhance JAs
	
	sets.precast.JA.Nightingale = {feet="Bihu Slippers +1"}
	sets.precast.JA.Troubadour = {body="Bihu Jstcorps +1"}
	sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions +1"}

	-- Waltz set (chr and vit)
	sets.precast.Waltz = {range="Gjallarhorn",
		head="Nahtirah Hat",
		legs="Gendewitha Spats +1",feet="Gende. Galosh. +1"}
	
       
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {ammo="Ginsen",
		head="Brioso Roundlet +2",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Bihu Jstcorps +1",hands="Brioso Cuffs +3",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Atheling Mantle",waist="Fotia Belt",legs="Bihu Cannions +1",feet="Gende. Galosh. +1"}
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	
	
	-- Midcast Sets

	-- General set for recast times.
	sets.midcast.FastRecast = {
		main="Carnwenhan",
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
	sets.midcast.Ballad = {legs="Aoidos' Rhing. +2", legs="Fili Rhingrave +1"}
	--sets.midcast.Lullaby = {hands="Brioso Cuffs +3"}
	sets.midcast.Madrigal = {head="Fili Calot +1", back="Intarabus's Cape"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {}
    sets.midcast.Paeon = {head="Brioso Roundlet +2"}
	sets.midcast.Prelude = {back="Intarabus's Cape"}
	sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
	sets.midcast['Honor March'] = set_combine(sets.midcast.SongEffect,{range="Marsyas",hands="Fili Manchettes +1"})	
    sets.midcast['Magic Finale'] = {neck="Wind Torque",waist="Corvax Sash",legs="Fili Rhingrave +1"}
	
	sets.midcast.Carol = {head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Fili Rhingrave +1",
		feet="Fili Cothurnes +1",}
	
	sets.midcast.Lullaby = {
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +2",
		body="Brioso Justau. +3",
		hands="Brioso Cuffs +3",
		legs="Brioso Cannions +2",
		feet="Brioso Slippers +3",
		neck="Moonbow Whistle +1",
		waist="Luminary Sash",
		left_ear="Dignitary's Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		}

	sets.midcast.Mazurka = {range="Marsyas"}
	

	-- For song buffs (duration and AF3 set bonus)
	sets.midcast.SongEffect = {
		main="Carnwenhan",
	    sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs="Inyanga Shalwar +2",
		feet="Brioso Slippers +3",
		neck="Moonbow Whistle +1",
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
		main="Carnwenhan",
		sub="Ammurapi Shield",
		range="Gjallarhorn",
		head="Brioso Roundlet +2",
		body="Brioso Justaucorps +3",
		hands="Brioso Cuffs +3",
		legs="Brioso Cannions +2",
		feet="Brioso Slippers +3",
		neck="Moonbow Whistle +1",
		waist="Luminary Sash",
		left_ear="Dignitary's Earring",
		right_ear="Gwati Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		back={ name="Intarabus's Cape", augments={'CHR+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}},
		}

	-- For song defbuffs (accuracy primary, duration secondary)
	sets.midcast.ResistantSongDebuff = {main="Kaja Knife",sub="Mephitis Grip",range="Gjallarhorn",
        head="Brioso Roundlet +2",neck="Wind Torque",ear1="Psystorm Earring",ear2="Lifestorm Earring",
        body="Brioso Justaucorps +3",hands="Aoidos' Manchettes +2",ring1="Prolix Ring",ring2="Sangoma Ring",
        back="Kumbira Cape",waist="Demonry Sash",legs="Brioso Cannions +2",feet="Bokwus Boots"}

	-- Song-specific recast reduction
	sets.midcast.SongRecast = {ear2="Loquacious Earring",
        ring1="Prolix Ring",
        back="Harmony Cape",waist="Corvax Sash",legs="Aoidos' Rhing. +2"}

	-- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

	-- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = set_combine(sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

	-- Other general spells and classes.
	sets.midcast.Cure = {main="Arka IV",sub='Achaq Grip',
		head="Gendewitha Caubeen +1",neck="Erra Pendant",ear1="Gifted Earring",ear2="Etiolation Earring",
		body="Gende. Bilaut +1",hands="Telchine Gloves",ring1="Haoma's Ring",ring2="Haoma's Ring",
		back="Tempered Cape +1",waist=gear.ElementalObi,legs="Gyve Trousers",feet="Gende. Galosh. +1"}
		
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast['Enhancing Magic'] = {main="Serenity",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Prolix Ring",
		back="Swith Cape +1",waist="Witful Belt",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})
		
	sets.midcast['Elemental Magic'] = {main="Marin Staff +1",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Vanir Cotehardie",hands="Helios Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Artsieq Hose",feet="Helios Boots"}
		
	sets.midcast['Elemental Magic'].Resistant = {main="Marin Staff +1",sub="Clerisy Strap +1",ammo="Dosis Tathlum",
		head="Buremte Hat",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
		body="Vanir Cotehardie",hands="Helios Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Yamabuki-no-Obi",legs="Artsieq Hose",feet="Helios Boots"}
		
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.Resistant = sets.midcast['Elemental Magic'].Fodder
		
	sets.midcast.Cursna = {
		neck="Debilis Medallion",
		ring1="Haoma's Ring",ring2="Haoma's Ring",
		feet="Gende. Galosh. +1"}
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Marin Staff +1",sub="Clemency Grip"})

	
	-- Sets to return to when not performing an action.
	
	sets.Capacity = {back="Mecisto. Mantle"}
	sets.Warp = {ring2="Warp Ring"}
	sets.RREar = {ear2="Reraise Earring"}
	
	-- Resting sets
	sets.resting = {legs="Assid. Pants +1",feet="Chelona Boots +1"}
	
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Jupiter's Pearl",ear2="Kuwunga Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}	
	
	-- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	sets.idle = {
		main="Mafic Cudgel",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head={ name="Chironic Hat", augments={'Accuracy+1 Attack+1','"Blood Boon"+4','"Refresh"+2',}},
		body="Inyanga Jubbah +2",
		hands="Inyan. Dastanas +2",
		legs="Inyanga Shalwar +2",
		feet={ name="Chironic Slippers", augments={'DEX+4','MND+1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		neck="Mnbw. Whistle +1",
		waist="Fucho-no-Obi",
		left_ear="Loquac. Earring",
		right_ear="Genmei Earring",
		left_ring="Defending Ring",
		right_ring="Inyanga Ring",
		back="Perimede Cape",
		}

	sets.idle.Weak = {main="Terra's Staff", sub="Oneiros Grip",range="Gjallarhorn",
		head=empty,neck="Loricate Torque +1",ear1="Moonshade Earring",ear2="Ethereal Earring",
		body="Respite Cloak",hands=gear.chironic_refresh_hands,ring1="Defending Ring",ring2="Dark Ring",
		back="Umbra Cape",waist="Flume Belt",legs="Assiduity Pants",feet="Serpentes Sabots"}
	
	sets.idle.PDT = {
			main="Mafic Cudgel",
			sub="Genbu's Shield",
			range="Gjallarhorn",
			head="Fili Calot +1",
			body="Fili Hongreline +1",
			hands="Inyan. Dastanas +2",
			legs="Inyanga Shalwar +2",
			feet="Inyan. Crackows +2",
			neck="Loricate Torque +1",
			waist="Fucho-no-Obi",
			left_ear="Odnowa Earring",
			right_ear="Genmei Earring",
			left_ring="Defending Ring",
			right_ring="Inyanga Ring",
			back="Perimede Cape",
			}
	
		sets.idle.Town = {
			main="Mafic Cudgel",
			sub="Genbu's Shield",
			range="Gjallarhorn",
			head={ name="Chironic Hat", augments={'Accuracy+1 Attack+1','"Blood Boon"+4','"Refresh"+2',}},
			body="Inyanga Jubbah +2",
			hands="Inyan. Dastanas +2",
			legs="Inyanga Shalwar +2",
			feet={ name="Chironic Slippers", augments={'DEX+4','MND+1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
			neck="Mnbw. Whistle +1",
			waist="Fucho-no-Obi",
			left_ear="Odnowa Earring",
			right_ear="Genmei Earring",
			left_ring="Defending Ring",
			right_ring="Inyanga Ring",
			back="Perimede Cape",
			}
		
	-- Defense sets

	sets.defense.PDT = {
		main="Kaja Knife",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Bihu Slippers +1", augments={'Enhances "Nightingale" effect',}},
		neck="Loricate Torque +1",
		waist="Flume Belt",
		left_ear="Odnowa Earring",
		right_ear="Genmei Earring",
		left_ring="Defending Ring",
		right_ring="Warp Ring",
		back="Solemnity Cape",
		}

	sets.defense.MDT = {
		main="Kaja Knife",
		sub="Genbu's Shield",
		range="Gjallarhorn",
		head="Fili Calot +1",
		body="Fili Hongreline +1",
		hands="Fili Manchettes +1",
		legs={ name="Bihu Cannions +1", augments={'Enhances "Soul Voice" effect',}},
		feet={ name="Bihu Slippers +1", augments={'Enhances "Nightingale" effect',}},
		neck="Warder's Charm",
		waist="Flume Belt",
		left_ear="Odnowa Earring",
		right_ear="Genmei Earring",
		left_ring="Defending Ring",
		right_ring="Warp Ring",
		back="Solemnity Cape",
		}

	sets.Kiting = {feet="Aoidos' Cothurnes +2"}

	-- Gear for specific elemental nukes.
	sets.WindNuke = {main="Marin Staff +1"}
	sets.IceNuke = {main="Ngqoqwanb"}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Basic set for if no TP weapon is defined.
	sets.engaged = {ammo="Ginsen",
		head="Brioso Roundlet +2",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Bihu Jstcorps +1",hands="Brioso Cuffs +3",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Atheling Mantle",waist="Ninurta's Sash",legs="Bihu Cannions +1",feet="Gende. Galosh. +1"}

	-- Sets with weapons defined.
	sets.engaged.Dagger = {ammo="Ginsen",
		head="Brioso Roundlet +2",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Bihu Jstcorps +1",hands="Brioso Cuffs +3",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Atheling Mantle",waist="Ninurta's Sash",legs="Bihu Cannions +1",feet="Gende. Galosh. +1"}

	-- Set if dual-wielding
	sets.engaged.DualWield = {ammo="Ginsen",
		head="Brioso Roundlet +2",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
		body="Bihu Jstcorps +1",hands="Brioso Cuffs +3",ring1="Rajas Ring",ring2="Patricius Ring",
		back="Atheling Mantle",waist="Ninurta's Sash",legs="Bihu Cannions +1",feet="Gende. Galosh. +1"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong'  then
        -- if spell.english == "Ice Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'	
        -- elseif spell.english == "Wind Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		--elseif spell.english == "Fire Carol" then 
			--state.ExtraSongsMode.value = 'Dummy'
		--elseif spell.english == "Earth Carol" then
			--state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Lightning Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Ice Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Fire Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Wind Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Water Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Dark Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		-- elseif spell.english == "Light Carol" then
			-- state.ExtraSongsMode.value = 'Dummy'
		if spell.english == "Army's Paeon" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Army's Paeon II" then
			state.ExtraSongsMode.value = 'Dummy'
		elseif spell.english == "Knight's Minne" then
			state.ExtraSongsMode.value = 'Dummy'
			elseif spell.english == "Knight's Minne II" then
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

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	set_macro_page(3, 5)
end