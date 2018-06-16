function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc', 'Fodder')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc','FullAcc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT','MDT')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise','PDTHP')
	state.MagicalDefenseMode:options('MDT', 'MDTReraise', 'BDT', 'MDTHP')
	state.ResistDefenseMode:options('MEVA', 'Death','Charm')
	state.IdleMode:options('Normal', 'PDT', 'MDT', 'Refresh', 'Regen', 'Reraise')

    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None', 'MP', 'Knockback', 'MP_Knockback','Twilight'}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
    send_command('bind !f11 gs c cycle ExtraMeleeMode')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {hands="Fallen's Finger Gauntlets +1"}
	sets.precast.JA['Arcane Circle'] = {feet="Ignominy Sollerets +1"}
	sets.precast.JA['Souleater'] = {head="Ignominy Burgeonet +1"}
	sets.precast.JA['Weapon Bash'] = {hands="Ignominy Gauntlets +1"}
	sets.precast.JA['Nether Void'] = {legs="Bale Flanchard +2"}
	sets.precast.JA['Blood Weapon'] = {body="Fallen's Cuirass +1"}     
	sets.precast.JA['Dark Seal'] = {body="Fallen's Burgeonet +1"}     
                   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {
	head="Flamma Zucchetto +2",
	body="Gorney Haubert +1",hands="Buremte Gloves",
	legs="Acro Breeches",feet="Flamma Gambieras +2"}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body={ name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+5','INT+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Sulev. Cuisses +2",
		feet="Odyssean Greaves",
		neck="Baetyl Pendant",
		waist="Ioskeha Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back="Moonbeam Cape",
	}			

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
		
	-- Midcast Sets
	sets.midcast.FastRecast = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask", augments={'Accuracy+15','Mag. Acc.+10','"Fast Cast"+3',}},
		body={ name="Odyss. Chestplate", augments={'"Mag.Atk.Bns."+13','"Fast Cast"+5','INT+5',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Baetyl Pendant",
		waist="Ioskeha Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Prolix Ring",
		right_ring="Kishar Ring",
		back="Moonbeam Cape",
	}
                   
	-- Specific spells
 
	sets.midcast['Dark Magic'] = {
		ammo="Seeth. Bomblet +1",
		head="Flamma Zucchetto +2",
		body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +2",
		neck="Erra Pendant",
		waist="Casso Sash",
		left_ear="Digni. Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring",
		back="Moonbeam Cape",
	}
           
	sets.midcast['Enfeebling Magic'] = {
		ammo="Seeth. Bomblet +1",
		head="Flamma Zucchetto +2",
		body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +2",
		neck="Incanter's Torque",
		waist="Casso Sash",
		left_ear="Digni. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Moonbeam Cape",
	}
		   
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {body="Bale Cuirass +2"})
	
	sets.midcast['Absorb-TP'] = set_combine(sets.midcast['Dark Magic'], {body="Bale Gauntlets +2"})
           
	sets.midcast.Stun = {
		ammo="Seeth. Bomblet +1",
		head="Flamma Zucchetto +2",
		body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Flamma Dirs +1",
		feet="Flamma Gambieras +2",
		neck="Erra Pendant",
		waist="Casso Sash",
		left_ear="Digni. Earring",
		right_ear="Hirudinea Earring",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring",
		back="Moonbeam Cape",
	}
                   
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {waist="Fucho-no-obi"})
                   
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Seeth. Bomblet +1",
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Dagon Breastplate",
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','AGI+9','Accuracy+15','Attack+11',}},
		feet="Sulevia's Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Ishvara Earring",
		left_ring="Karieyh Ring",
		right_ring="Regal Ring",
		back="Agema Cape",
	}
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
    sets.precast.WS['Catastrophe'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Fotia Gorget"})
    sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget"})
    sets.precast.WS['Catastrophe'].FullAcc = set_combine(sets.precast.WS.FullAcc, {neck="Fotia Gorget"})
    sets.precast.WS['Catastrophe'].Fodder = set_combine(sets.precast.WS.Fodder, {neck="Fotia Gorget"})

    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Entropy'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Entropy'].FullAcc = set_combine(sets.precast.WS.FullAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS.Fodder, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
	
	sets.precast.WS['Cross Reaper'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Cross Reaper'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Cross Reaper'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Cross Reaper'].FullAcc = set_combine(sets.precast.WS.FullAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Cross Reaper'].Fodder = set_combine(sets.precast.WS.Fodder, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
	
	sets.precast.WS['Guillotine'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Guillotine'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Guillotine'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Guillotine'].FullAcc = set_combine(sets.precast.WS.FullAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
    sets.precast.WS['Guillotine'].Fodder = set_combine(sets.precast.WS.Fodder, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", head="Ratri Sallet", hands="Ratri Gadlings"})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", })
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", })
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", })
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", })
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {neck="Fotia Gorget", left_ear="Moonshade Earring", waist="Fotia Belt", })
	
	sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {
		neck="Fotia Gorget", 
		left_ear="Moonshade Earring", 
		waist="Fotia Belt", 
		head="Flamma Zucchetto +2", 
		hands="Odyssean Gauntlets", 
		legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','AGI+9','Accuracy+15','Attack+11',}},
		feet="Sulev. Leggings +2",}
	)
    sets.precast.WS['Torcleaver'].SomeAcc = set_combine(sets.precast.WS, {
		neck="Fotia Gorget", 
		left_ear="Moonshade Earring", 
		waist="Fotia Belt", 
		head="Flamma Zucchetto +2", 
		hands="Odyssean Gauntlets", 
		legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','AGI+9','Accuracy+15','Attack+11',}},
		feet="Sulev. Leggings +2",}
	)
    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS, {
		neck="Fotia Gorget", 
		left_ear="Moonshade Earring", 
		waist="Fotia Belt", 
		head="Flamma Zucchetto +2", 
		hands="Odyssean Gauntlets", 
		legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','AGI+9','Accuracy+15','Attack+11',}},
		feet="Sulev. Leggings +2",}
	)
    sets.precast.WS['Torcleaver'].FullAcc = set_combine(sets.precast.WS, {
		neck="Fotia Gorget", 
		left_ear="Moonshade Earring", 
		waist="Fotia Belt", 
		head="Flamma Zucchetto +2", 
		hands="Odyssean Gauntlets", 
		legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','AGI+9','Accuracy+15','Attack+11',}},
		feet="Sulev. Leggings +2",}
	)
    sets.precast.WS['Torcleaver'].Fodder = set_combine(sets.precast.WS, {
		neck="Fotia Gorget", 
		left_ear="Moonshade Earring", 
		waist="Fotia Belt", 
		head="Flamma Zucchetto +2", 
		hands="Odyssean Gauntlets", 
		legs={ name="Valor. Hose", augments={'Weapon skill damage +5%','AGI+9','Accuracy+15','Attack+11',}},
		feet="Sulev. Leggings +2",}
	)
     
     
           
     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}
     
            -- Idle sets
           
    sets.idle = {
		ammo="Seeth. Bomblet +1",
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Dagon Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flamma Gambieras +2",
		neck="Ganesha's Mala",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Karieyh Ring",
		right_ring="Niqmaddu Ring",
		back="Agema Cape",
	}
		
    sets.idle.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}

	sets.idle.PDTHP = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	
    sets.idle.Refresh = {ammo="Staunch Tathlum",
		head="Wivre Hairpin",neck="Coatl Gorget +1",ear1="Sanare Earring",ear2="Ethereal Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Sheltered Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Blood Cuisses",feet="Flamma Gambieras +2"}

		
    sets.idle.Reraise = {ammo="Staunch Tathlum",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Ethereal Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Acro Breeches",feet="Flamma Gambieras +2"}
     
    sets.idle.Weak = {ammo="Staunch Tathlum",
		head="Twilight Helm",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Ethereal Earring",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Blood Cuisses",feet="Flamma Gambieras +2"}
           
    -- Defense sets
	sets.defense.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
     
    sets.defense.Reraise = {
		head="Twilight Helm",neck="Loricate Torque +1",
        body="Twilight Mail",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Acro Breeches",feet="Flamma Gambieras +2"}
     
	sets.defense.MDT = {ammo="Staunch Tathlum",
		head="Baghere Salade",neck="Loricate Torque +1",ear1="Sanare Earring",ear2="Ethereal Earring",
        body="Acro Surcoat",hands="Buremte Gloves",ring1="Defending Ring",ring2="Dark Ring",
        back="Engulfer Cape +1",waist="Flume Belt",legs="Acro Breeches",feet="Flamma Gambieras +2"}
		
	sets.defense.MDTHP = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise)
		
	sets.defense.BDT = {}
	
	sets.defense.MEVA = {}
	
	sets.defense.Death = {}
	
	sets.defense.Charm = {}
     
	sets.Kiting = {legs="Blood Cuisses",back="Solemnity Cape"}
     
    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
     
	-- Engaged sets
    sets.engaged = {
		ammo="Seeth. Bomblet +1",
		head="Flamma Zucchetto +2",
		body="Dagon Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flamma Gambieras +2",
		neck="Ganesha's Mala",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Regal Ring",
		right_ring="Niqmaddu Ring",
		back="Agema Cape",
	}
	sets.engaged.SomeAcc = {
			ammo="Seeth. Bomblet +1",
			head="Flamma Zucchetto +2",
			body="Dagon Breast.",
			hands="Sulev. Gauntlets +2",
			legs="Sulev. Cuisses +2",
			feet="Flamma Gambieras +2",
			neck="Combatant's Torque",
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Telos Earring",
			left_ring="Regal Ring",
			right_ring="Niqmaddu Ring",
			back="Agema Cape",
		}
	sets.engaged.Acc = {
		ammo="Seeth. Bomblet +1",
		head="Flamma Zucchetto +2",
		body="Dagon Breast.",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Flamma Gambieras +2",
		neck="Combatant's Torque",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Digni. Earring",
		left_ring="Chirich Ring",
		right_ring="Cacoethic Ring +1",
		back="Agema Cape",
	}
	sets.engaged.FullAcc = {
			ammo="Seeth. Bomblet +1",
			head="Flamma Zucchetto +2",
			body="Dagon Breast.",
			hands="Sulev. Gauntlets +2",
			legs="Sulev. Cuisses +2",
			feet="Flamma Gambieras +2",
			neck="Combatant's Torque",
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Telos Earring",
			left_ring="Chirich Ring",
			right_ring="Niqmaddu Ring",
			back="Agema Cape",
		}
	sets.engaged.Fodder = {
			ammo="Seeth. Bomblet +1",
			head="Flamma Zucchetto +2",
			body="Dagon Breast.",
			hands="Sulev. Gauntlets +2",
			legs="Sulev. Cuisses +2",
			feet="Flamma Gambieras +2",
			neck="Combatant's Torque",
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Telos Earring",
			left_ring="Chirich Ring",
			right_ring="Niqmaddu Ring",
			back="Agema Cape",
		}
	
    -- sets.engaged.Adoulin = {}
	-- sets.engaged.SomeAcc.Adoulin = {}
	-- sets.engaged.Acc.Adoulin = {}
	-- sets.engaged.FullAcc.Adoulin = {}
	-- sets.engaged.Fodder.Adoulin = {}
	
	sets.engaged.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	sets.engaged.SomeAcc.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	sets.engaged.Acc.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	sets.engaged.FullAcc.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	sets.engaged.Fodder.PDT = {
		ammo="Seeth. Bomblet +1",
		head="Sulevia's Mask +2",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulevia's Leggings +2",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Moonbeam Cape",
	}
	
	-- sets.engaged.PDT.Adoulin = {}
	-- sets.engaged.SomeAcc.PDT.Adoulin = {}
	-- sets.engaged.Acc.PDT.Adoulin = {}
	-- sets.engaged.FullAcc.PDT.Adoulin = {}
	-- sets.engaged.Fodder.PDT.Adoulin = {}
	
	-- sets.engaged.MDT = {}
	-- sets.engaged.SomeAcc.MDT = {}
	-- sets.engaged.Acc.MDT = {}
	-- sets.engaged.FullAcc.MDT = {}
	-- sets.engaged.Fodder.MDT = {}
	
	-- sets.engaged.MDT.Adoulin = {}
	-- sets.engaged.SomeAcc.MDT.Adoulin = {}
	-- sets.engaged.Acc.MDT.Adoulin = {}
	-- sets.engaged.FullAcc.MDT.Adoulin = {}
	-- sets.engaged.Fodder.MDT.Adoulin = {}
	
            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Liberator melee sets
    sets.engaged.Liberator = {}
	sets.engaged.Liberator.SomeAcc = {}
	sets.engaged.Liberator.Acc = {}
	sets.engaged.Liberator.FullAcc = {}
	sets.engaged.Liberator.Fodder = {}
	
    sets.engaged.Liberator.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.Adoulin = {}
	sets.engaged.Liberator.Acc.Adoulin = {}
	sets.engaged.Liberator.FullAcc.Adoulin = {}
	sets.engaged.Liberator.Fodder.Adoulin = {}
	
    sets.engaged.Liberator.AM = {}
	sets.engaged.Liberator.SomeAcc.AM = {}
	sets.engaged.Liberator.Acc.AM = {}
	sets.engaged.Liberator.FullAcc.AM = {}
	sets.engaged.Liberator.Fodder.AM = {}
	
    sets.engaged.Liberator.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.Adoulin.AM = {}

	sets.engaged.Liberator.PDT = {}
	sets.engaged.Liberator.SomeAcc.PDT = {}
	sets.engaged.Liberator.Acc.PDT = {}
	sets.engaged.Liberator.FullAcc.PDT = {}
	sets.engaged.Liberator.Fodder.PDT = {}
	
	sets.engaged.Liberator.PDT.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin = {}
	sets.engaged.Liberator.FullAcc.PDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Liberator.PDT.AM = {}
	sets.engaged.Liberator.SomeAcc.PDT.AM = {}
	sets.engaged.Liberator.Acc.PDT.AM = {}
	sets.engaged.Liberator.FullAcc.PDT.AM = {}
	sets.engaged.Liberator.Fodder.PDT.AM = {}
	
	sets.engaged.Liberator.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Liberator.MDT = {}
	sets.engaged.Liberator.SomeAcc.MDT = {}
	sets.engaged.Liberator.Acc.MDT = {}
	sets.engaged.Liberator.FullAcc.MDT = {}
	sets.engaged.Liberator.Fodder.MDT = {}
	
	sets.engaged.Liberator.MDT.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin = {}
	sets.engaged.Liberator.FullAcc.MDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Liberator.MDT.AM = {}
	sets.engaged.Liberator.SomeAcc.MDT.AM = {}
	sets.engaged.Liberator.Acc.MDT.AM = {}
	sets.engaged.Liberator.FullAcc.MDT.AM = {}
	sets.engaged.Liberator.Fodder.MDT.AM = {}
	
	sets.engaged.Liberator.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin.AM = {}
	
-- Apocalypse melee sets
    sets.engaged.Apocalypse = {
			sub="Utu Grip",
			ammo="Seeth. Bomblet +1",
			head="Flamma Zucchetto +2",
			body="Dagon Breast.",
			hands="Sulev. Gauntlets +2",
			legs="Sulev. Cuisses +2",
			feet="Flamma Gambieras +2",
			neck="Ganesha's Mala",
			waist="Ioskeha Belt",
			left_ear="Cessance Earring",
			right_ear="Telos Earring",
			left_ring="Karieyh Ring",
			right_ring="Niqmaddu Ring",
			back="Agema Cape",
		}
	sets.engaged.Apocalypse.SomeAcc = {}
	sets.engaged.Apocalypse.Acc = {}
	sets.engaged.Apocalypse.FullAcc = {}
	sets.engaged.Apocalypse.Fodder = {}
	
    sets.engaged.Apocalypse.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.Adoulin = {}
	sets.engaged.Apocalypse.Acc.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.Adoulin = {}
	
    sets.engaged.Apocalypse.AM = {}
	sets.engaged.Apocalypse.SomeAcc.AM = {}
	sets.engaged.Apocalypse.Acc.AM = {}
	sets.engaged.Apocalypse.FullAcc.AM = {}
	sets.engaged.Apocalypse.Fodder.AM = {}
	
    sets.engaged.Apocalypse.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.Adoulin.AM = {}

	sets.engaged.Apocalypse.PDT = {}
	sets.engaged.Apocalypse.SomeAcc.PDT = {}
	sets.engaged.Apocalypse.Acc.PDT = {}
	sets.engaged.Apocalypse.FullAcc.PDT = {}
	sets.engaged.Apocalypse.Fodder.PDT = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Apocalypse.PDT.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.AM = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Apocalypse.PDT.Charge = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Charge = {}
	sets.engaged.Apocalypse.Acc.PDT.Charge = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Charge = {}
	sets.engaged.Apocalypse.Fodder.PDT.Charge = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Apocalypse.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Apocalypse.MDT = {}
	sets.engaged.Apocalypse.SomeAcc.MDT = {}
	sets.engaged.Apocalypse.Acc.MDT = {}
	sets.engaged.Apocalypse.FullAcc.MDT = {}
	sets.engaged.Apocalypse.Fodder.MDT = {}
	
	sets.engaged.Apocalypse.MDT.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.Acc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Apocalypse.MDT.AM = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.AM = {}
	sets.engaged.Apocalypse.Acc.MDT.AM = {}
	sets.engaged.Apocalypse.FullAcc.MDT.AM = {}
	sets.engaged.Apocalypse.Fodder.MDT.AM = {}
	
	sets.engaged.Apocalypse.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.MDT.Adoulin.AM = {}
	
-- Ragnarok melee sets
    sets.engaged.Ragnarok = {}
	sets.engaged.Ragnarok.SomeAcc = {}
	sets.engaged.Ragnarok.Acc = {}
	sets.engaged.Ragnarok.FullAcc = {}
	sets.engaged.Ragnarok.Fodder = {}
	
    sets.engaged.Ragnarok.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin = {}
	sets.engaged.Ragnarok.Acc.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.Adoulin = {}
	
    sets.engaged.Ragnarok.AM = {}
	sets.engaged.Ragnarok.SomeAcc.AM = {}
	sets.engaged.Ragnarok.Acc.AM = {}
	sets.engaged.Ragnarok.FullAcc.AM = {}
	sets.engaged.Ragnarok.Fodder.AM = {}
	
    sets.engaged.Ragnarok.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.Adoulin.AM = {}

	sets.engaged.Ragnarok.PDT = {}
	sets.engaged.Ragnarok.SomeAcc.PDT = {}
	sets.engaged.Ragnarok.Acc.PDT = {}
	sets.engaged.Ragnarok.FullAcc.PDT = {}
	sets.engaged.Ragnarok.Fodder.PDT = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Ragnarok.PDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Ragnarok.PDT.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Ragnarok.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Ragnarok.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Ragnarok.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Ragnarok.MDT = {}
	sets.engaged.Ragnarok.SomeAcc.MDT = {}
	sets.engaged.Ragnarok.Acc.MDT = {}
	sets.engaged.Ragnarok.FullAcc.MDT = {}
	sets.engaged.Ragnarok.Fodder.MDT = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Ragnarok.MDT.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.AM = {}
	
	sets.engaged.Ragnarok.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Ragnarok.Fodder.MDT.Adoulin.AM = {}
	
	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.Weapons = {main="Mekosuchus Blade",sub="Bloodrain Strap"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
    end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'DNC' then
        set_macro_page(1, 3)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 3)
    else
        set_macro_page(1, 3)
    end
end