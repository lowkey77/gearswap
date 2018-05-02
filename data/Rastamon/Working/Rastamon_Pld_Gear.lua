function user_setup()

    -- Options: Override default values	
	state.OffenseMode:options('Normal', 'Acc')
    state.HybridMode:options('Tank', 'DDTank', 'BreathTank', 'NoShellTank', 'Reraise', 'Normal')
    state.WeaponskillMode:options('Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'PDT_HP', 'PDT_Reraise', 'Tank')
    state.MagicalDefenseMode:options('BDT','AegisMDT','AegisNoShellMDT','OchainMDT','OchainNoShellMDT','MDT_HP','MDT_Reraise')
	state.ResistDefenseMode:options('MEVA', 'Death','Charm')
	state.IdleMode:options('Normal', 'Tank', 'KiteTank', 'PDT', 'MDT', 'Refresh', 'Reraise')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Twilight'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')
	
	gear.fastcast_jse_back = { name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.enmity_jse_back = { name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}

	-- Additional local binds
	send_command('bind !` gs c SubJobEnmity')
	send_command('bind ^backspace input /ja "Shield Bash" <t>')
	send_command('bind @backspace input /ja "Cover" <stpt>')
	send_command('bind !backspace input /ja "Sentinel" <me>')
	send_command('bind @= input /ja "Chivalry" <me>')
	send_command('bind != input /ja "Palisade" <me>')
	send_command('bind ^delete input /ja "Provoke" <stnpc>')
	send_command('bind !delete input /ma "Cure IV" <stal>')
	send_command('bind @delete input /ma "Flash" <stnpc>')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
	send_command('bind @` gs c cycle RuneElement')
	send_command('bind @pause gs c toggle AutoRuneMode')
	send_command('bind @f8 gs c toggle AutoTankMode')
	send_command('bind ^@!` gs c cycle SkillchainMode')
	
    select_default_macro_book()
    update_defense_mode()
end

function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	
    sets.Enmity = {
		ammo="Iron Gobbet", -- 2 --
		head="Souveran Schaller +1", -- 9 --
		neck="Unmoving Collar +1", -- 10 --
		left_ear="Cryptic Earring", -- 4 -- 
		right_ear="Thureous Earring", -- 0 --
		body="Reverence Surcoat +2", -- 12 --
		hands="Cab. Gauntlets +1", -- 6 --
		left_ring="Petrov Ring", -- 4 --
		right_ring="Hercules' Ring", -- 3 --
		back="Agema Cape", -- 5 --
		waist="Creed Baudrier", -- 5 --
		legs="Souveran Diechlings +1", -- 9 --
		feet="Chevalier's Sabatons +1" -- 11 --
		}

    sets.Enmity.DT = {
		ammo="Iron Gobbet", -- 2 --
		head="Souveran Schaller +1", -- 9 --
		neck="Unmoving Collar +1", -- 10 --
		left_ear="Cryptic Earring", -- 4 -- 
		right_ear="Thureous Earring", -- 0 --
		body="Reverence Surcoat +2", -- 12 --
		hands="Cab. Gauntlets +1", -- 6 --
		left_ring="Petrov Ring", -- 4 --
		right_ring="Hercules' Ring", -- 3 --
		back="Agema Cape", -- 5 --
		waist="Creed Baudrier", -- 5 --
		legs="Souveran Diechlings +1", -- 9 --
		feet="Chevalier's Sabatons +1" -- 11 --
		}
		
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = set_combine(sets.Enmity,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'] = set_combine(sets.Enmity,{feet="Rev. Leggings +1"})
    sets.precast.JA['Sentinel'] = set_combine(sets.Enmity,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'] = set_combine(sets.Enmity,{})
    sets.precast.JA['Fealty'] = set_combine(sets.Enmity,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'] = set_combine(sets.Enmity,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'] = set_combine(sets.Enmity, {head="Rev. Coronet +1",body="Cab. Surcoat +1"})
	
    sets.precast.JA['Invincible'].DT = set_combine(sets.Enmity.DT,{legs="Cab. Breeches +1"})
    sets.precast.JA['Holy Circle'].DT = set_combine(sets.Enmity.DT,{feet="Rev. Leggings +1"})
    sets.precast.JA['Sentinel'].DT = set_combine(sets.Enmity.DT,{feet="Cab. Leggings +1"})
    sets.precast.JA['Rampart'].DT = set_combine(sets.Enmity.DT,{})
    sets.precast.JA['Fealty'].DT = set_combine(sets.Enmity.DT,{body="Cab. Surcoat +1"})
    sets.precast.JA['Divine Emblem'].DT = set_combine(sets.Enmity.DT,{feet="Chev. Sabatons +1"})
    sets.precast.JA['Cover'].DT = set_combine(sets.Enmity.DT, {head="Rev. Coronet +1",body="Cab. Surcoat +1"})
	
    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		head="Rev. Coronet +1",neck="Phalaina Locket",ear1="Nourish. Earring",ear2="Nourish. Earring +1",
		body="Sulevia's Plate. +1",hands="Cab. Gauntlets +1",ring1="Stikini Ring",ring2="Rufescent Ring",
		back=gear.enmity_jse_back,waist="Luminary Sash",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"}

	sets.precast.JA['Shield Bash'] = set_combine(sets.Enmity, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Warcry'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Palisade'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Intervene'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Defender'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Berserk'] = set_combine(sets.Enmity, {})
	sets.precast.JA['Aggressor'] = set_combine(sets.Enmity, {})
	
	sets.precast.JA['Shield Bash'].DT = set_combine(sets.Enmity.DT, {hands="Cab. Gauntlets +1"})		
    sets.precast.JA['Provoke'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Warcry'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Palisade'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Intervene'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Defender'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Berserk'].DT = set_combine(sets.Enmity.DT, {})
	sets.precast.JA['Aggressor'].DT = set_combine(sets.Enmity.DT, {})

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		head="Sulevia's Mask +1",
		body="Cab. Surcoat +1",ring1="Asklepian Ring",ring2="Valseur's Ring",
		waist="Chaac Belt",legs="Sulevi. Cuisses +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {ammo="Ginsen",
        head="Founder's Corona",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Tartarus Platemail",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Violent Flourish'] = {ammo="Ginsen",
        head="Founder's Corona",neck="Erra Pendant",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}
		
	sets.precast.JA['Animated Flourish'] = set_combine(sets.Enmity, {})

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		ammo="Impatiens",
		head="Carmine Mask",
		neck="Voltsurge Torque",
		ear1="Enchanter Earring +1",
		ear2="Loquac. Earring",
		body="Reverence Surcoat +2",
		hands="Sulevia's Gauntlets +2",
		ring1="Kishar Ring",
		ring2="Veneficium Ring",
		back="Repulse Mantle",
		waist="Goading Belt",
		legs="Rev. Breeches +1",
		feet="Carmine Greaves",
		}
		
    sets.precast.FC.DT = {
		ammo="Impatiens",
		head="Carmine Mask",
		neck="Voltsurge Torque",
		ear1="Enchanter Earring +1",
		ear2="Loquac. Earring",
		body="Reverence Surcoat +2",
		hands="Sulevia's Gauntlets +2",
		ring1="Kishar Ring",
		ring2="Veneficium Ring",
		back="Repulse Mantle",
		waist="Goading Belt",
		legs="Rev. Breeches +1",
		feet="Carmine Greaves",
		}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
	sets.precast.FC.Cure = set_combine(sets.precast.FC, {neck="Diemer Gorget",ear1="Nourish. Earring",ear2="Nourish. Earring +1",body="Jumalik Mail"})
  
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Dagon Breastplate",
		hands="Sulevia's Gauntlets +2",
		legs="Sulevia's Cuisses +2",
		feet="Reverence Leggings +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Pyrosoul Ring",
		right_ring="Patricius Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
		
    sets.precast.WS.DT = {ammo="Staunch Tathlum",
		head="Sulevia's Mask +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Defending Ring",ring2="Patricius Ring",
		back="Weard Mantle",waist="Fotia Belt",legs="Sulevi. Cuisses +1",feet="Sulevia's Leggings +1"}

    sets.precast.WS.Acc = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Dagon Breastplate",
		hands="Flamma Manopolas +1",
		legs="Sulevia's Cuisses +2",
		feet="Flamma GamBieras +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Enlivened Ring",
		right_ring="Karieyh Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Requiescat'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Moonshade Earring"})

	sets.precast.WS['Chant du Cygne'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring"})
    sets.precast.WS['Chant du Cygne'].Acc = set_combine(sets.precast.WS.Acc, {neck="Fotia Gorget",ear1="Zennaroi Earring",ear2="Moonshade Earring"})

	sets.precast.WS['Savage Blade'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",ear1="Ishvara Earring",ear2="Moonshade Earring",ring1="Karieyh Ring"})
    sets.precast.WS['Savage Blade'].Acc = set_combine(sets.precast.WS.Acc, {ear1="Zennaroi Earring",ear2="Telos Earring"})
	
	sets.precast.WS['Flat Blade'] = {ammo="Ginsen",
        head="Founder's Corona",neck="Voltsurge Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Sulevia's Plate. +1",hands="Leyline Gloves",ring1="Defending Ring",ring2="Stikini Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

	sets.precast.WS['Flat Blade'].Acc = {ammo="Ginsen",
        head="Founder's Corona",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Ramuh Ring +1",ring2="Patricius Ring",
        back="Ground. Mantle +1",waist="Olseni Belt",legs="Carmine Cuisses +1",feet="Founder's Greaves"}

    sets.precast.WS['Sanguine Blade'] = {ammo="Dosis Tathlum",
        head="Jumalik Helm",neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Jumalik Mail",hands="Founder's Gauntlets",ring1="Shiva Ring +1",ring2="Archon Ring",
        back="Toro Cape",waist="Fotia Belt",legs="Acro Breeches",feet="Founder's Greaves"}

	sets.precast.WS['Sanguine Blade'].Acc = sets.precast.WS['Sanguine Blade']

    sets.precast.WS['Atonement'] = {ammo="Paeapua",
		head="Loess Barbuta +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
		body="Phorcys Korazin",hands=gear.odyssean_wsd_hands,ring1="Defending Ring",ring2="Moonbeam Ring",
		back=gear.enmity_jse_back,waist="Fotia Belt",legs="Acro Breeches",feet="Eschite Greaves"}

    sets.precast.WS['Atonement'].Acc = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'] = sets.precast.WS['Atonement']
    sets.precast.WS['Spirits Within'].Acc = sets.precast.WS['Atonement']

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}


	--------------------------------------
	-- Midcast sets
	--------------------------------------

    sets.midcast.FastRecast = {ammo="Paeapua",
        head="Chev. Armet +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Odyss. Chestplate",hands="Leyline Gloves",ring1="Defending Ring",ring2="Kishar Ring",
        waist="Zoran's Belt",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
		
	sets.midcast.FastRecast.DT = {ammo="Staunch Tathlum",
		head="Souveran Schaller +1",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Thureous Earring",
		body="Tartarus Platemail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Founder's Hose",feet="Odyssean Greaves"}

    sets.midcast.Flash = set_combine(sets.Enmity, {})
    sets.midcast.Stun = set_combine(sets.Enmity, {})
	sets.midcast['Blue Magic'] = set_combine(sets.Enmity, {})

	-- sets.precast.Cure = {
		-- ammo="Sapience Orb",
		-- head="Carmine Mask",
		-- body="Jumalik Mail",
		-- legs="Souveran Diechlings +1",
		-- hands="Souveran Handschuhs +1",
		-- feet="Carmine Greaves",
		-- neck="Diemer Gorget",
		-- waist="zoran's Belt",
		-- left_ear="Cryptic Earring",
		-- right_ear="Nourish. Earring",
		-- left_ring="Moonbeam Ring",
		-- right_ring="Moonbeam Ring"
		-- }
	
    sets.midcast.Cure = {
		ammo="Sapience Orb",
		head="Souveran Schaller +1",
		body="Jumalik Mail",
		legs="Souveran Diechlings +1",
		hands="Souveran Handschuhs +1",
		feet="Souveran Schuhs +1",
		neck="Diemer Gorget",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Nourish. Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring"
		}
		
    sets.midcast.Cure.DT = {
		ammo="Sapience Orb",
		head="Souveran Schaller +1",
		body="Jumalik Mail",
		legs="Souveran Diechlings +1",
		hands="Souveran Handschuhs +1",
		feet="Souveran Schuhs +1",
		neck="Diemer Gorget",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Nourish. Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring"
		}
		
    sets.midcast.Reprisal = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Sanctity Necklace",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Souveran Cuirass",hands="Souv. Handsch. +1",ring1="Moonbeam Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Souv. Diechlings +1",feet="Souveran Schuhs +1"}

	sets.Self_Healing = {
		ammo="Sapience Orb",
		head="Souveran Schaller +1",
		body="Jumalik Mail",
		legs="Souveran Diechlings +1",
		hands="Souveran Handschuhs +1",
		feet="Souveran Schuhs +1",
		neck="Diemer Gorget",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Nourish. Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring"
		back="Moonbeam Cape",
		}
		
	sets.Self_Healing.DT = {
		ammo="Sapience Orb",
		head="Souveran Schaller +1",
		body="Jumalik Mail",
		legs="Souveran Diechlings +1",
		hands="Souveran Handschuhs +1",
		feet="Souveran Schuhs +1",
		neck="Diemer Gorget",
		waist="Creed Baudrier",
		left_ear="Cryptic Earring",
		right_ear="Nourish. Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring"
		back="Moonbeam Cape",
		}

	sets.Cure_Recieved = {hands="Souv. Handsch. +1",feet="Souveran Schuhs +1"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}

    sets.midcast['Enhancing Magic'] = {neck="Incanter's Torque",ear1="Andoaa Earring"}

	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})

    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Shell = {ring2="Sheltered Ring"}

	sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {back="Weard Mantle"})

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------

    sets.resting = {ammo="Homiliary",
		head="Jumalik Helm",neck="Coatl Gorget +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
		body="Jumalik Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Sheltered Ring",
		back="Moonbeam Cape",waist="Fucho-no-obi",legs="Sulevi. Cuisses +1",feet="Cab. Leggings +1"}

    -- Idle sets
    sets.idle = {
		ammo="Homiliary", 
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Arke Corazza",
		hands="Sulevia's Gauntlets +2",
		legs={ name="Souveran Diechlings +1", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet="Reverence Leggings +3",
		neck="Diemer Gorget",
		waist="Fucho-no-Obi",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Paguroidea Ring",
		right_ring="Karieyh Ring", 
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
		
    sets.idle.PDT = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
    sets.idle.MDT = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", 
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
	    		
	sets.idle.Refresh = {
		ammo="Homiliary", 
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Arke Corazza",
		hands="Sulevia's Gauntlets +2",
		legs={ name="Souveran Diechlings +1", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet="Reverence Leggings +3",
		neck="Diemer Gorget",
		waist="Fucho-no-Obi",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Paguroidea Ring",
		right_ring="Karieyh Ring", 
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}

	sets.idle.Tank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --4--DT
		right_ring="Moonbeam Ring", --4--
		back="Moonbeam Cape",--3--
		}
		
	sets.idle.KiteTank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --4--DT
		right_ring="Moonbeam Ring", --4--
		back="Moonbeam Cape",--3--
		}
		
    sets.idle.Reraise = set_combine(sets.idle.Tank, {head="Twilight Helm",neck="Loricate Torque +1",
		body="Twilight Mail",ring1="Defending Ring",ring2="Sheltered Ring",back="Moonbeam Cape"})	
		
    sets.idle.Weak = set_combine(sets.idle.Tank, {head="Twilight Helm",neck="Loricate Torque +1",
		body="Twilight Mail",ring1="Defending Ring",ring2="Sheltered Ring",back="Moonbeam Cape"})
		
	sets.Kiting = {legs="Carmine Cuisses +1"}

	sets.latent_refresh = {waist="Fucho-no-obi"}
	sets.latent_regen = {ring1="Apeile Ring +1",ring2="Apeile Ring"}
	sets.DayIdle = {}
	sets.NightIdle = {}

	--------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
	sets.Weapons = {main="Deacon Sword",sub="Aegis"}
    sets.Knockback = {}
    sets.MP = {head="Chev. Armet +1",neck="Coatl Gorget +1",ear2="Ethereal Earring",waist="Flume Belt"}
    sets.MP_Knockback = {}
    sets.Twilight = {head="Twilight Helm", body="Twilight Mail"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {sub="Ochain"}
    sets.MagicalShield = {sub="Aegis"}
	
    sets.defense.PDT = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
    sets.defense.PDT_HP = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
    sets.defense.MDT_HP = {ammo="Staunch Tathlum",
        head="Loess Barbuta +1",neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Odnowa Earring",
        body="Souveran Cuirass",hands="Souv. Handsch. +1",ring1="Moonbeam Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Creed Baudrier",legs="Chev. Cuisses +1",feet="Amm Greaves"}
		
    sets.defense.PDT_Reraise = {ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Thureous Earring",
        body="Twilight Mail",hands="Macabre Gaunt. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Moonbeam Cape",waist="Flume Belt",legs="Chev. Cuisses +1",feet="Souveran Schuhs +1"}
		
    sets.defense.MDT_Reraise = {ammo="Staunch Tathlum",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Twilight Mail",hands="Souv. Handsch. +1",ring1="Defending Ring",ring2="Moonbeam Ring",
		back="Engulfer Cape +1",waist="Flume Belt",legs=gear.odyssean_fc_legs,feet="Cab. Leggings +1"}

	sets.defense.BDT = {ammo="Staunch Tathlum",
		head="Loess Barbuta +1",neck="Warder's Charm +1",ear1="Odnowa Earring +1",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Sulev. Gauntlets +1",ring1="Defending Ring",ring2="Shadow Ring",
		back="Moonbeam Cape",waist="Asklepian Belt",legs="Sulevi. Cuisses +1",feet="Amm Greaves"}
		
	sets.defense.Tank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
	sets.defense.MEVA = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", 
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
	}
		
	sets.defense.Death = {ammo="Staunch Tathlum",
        head="Founder's Corona",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Tartarus Platemail",hands="Leyline Gloves",ring1="Warden's Ring",ring2="Shadow Ring",
        back=gear.fastcast_jse_back,waist="Asklepian Belt",legs=gear.odyssean_fc_legs,feet="Odyssean Greaves"}
		
	sets.defense.Charm = {
		ammo="Amar Cluster",
		head="Souveran Schaller +1",
		neck="Unmoving Collar +1",
		ear1="Zennaroi Earring",
		ear2="Ethereal Earring",
		body="Arke Corazza",--12--
		hands="Souv. Handschuhs", -- 4 DT 2/5 Souv. Set --
		ring1="Defending Ring", -- 10 DT --
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}, -- 3 DT --
		waist="Flume Belt +1", -- 4 --
		legs={ name="Souveran Diechlings +1", augments={'STR+10','VIT+10','Accuracy+15',}}, -- 15 --
		feet="Souveran Schuhs"
		} 
		
		-- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    sets.defense.OchainMDT = {
		sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", 
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
	}
		
    sets.defense.OchainNoShellMDT = {
		sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", 
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
	}
		
    sets.defense.AegisMDT = {
		sub="Aegis",
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", 
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
	}
		
    sets.defense.AegisNoShellMDT = {
		sub="Aegis",
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", 
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
	}		

	--------------------------------------
	-- Engaged sets
	--------------------------------------
    
	sets.engaged = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Arke Corazza",--12--
		hands="Sulevia's Gauntlets +2",--4--
		legs="Sulevia's Cuisses +2",--6--
		feet="Reverence Leggings +3",
		neck="Agitator's Collar",--4 PDT--
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",--1 MDT--
		right_ear="Odnowa Earring +1",--2 MDT--
		left_ring="Moonbeam Ring",--5 PDT--
		right_ring="Moonbeam Ring",--10--
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    sets.engaged.Acc = {		
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Arke Corazza",--12--
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet="Reverence Leggings +3",
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.DW = {ammo="Paeapua",
		head="Sulevia's Mask +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Rajas Ring",ring2="Petrov Ring",
		back="Bleating Mantle",waist="Windbuffet Belt +1",legs="Sulevi. Cuisses +1",feet="Founder's Greaves"}

    sets.engaged.DW.Acc = {ammo="Ginsen",
		head="Sulevia's Mask +1",neck="Asperity Necklace",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
		body="Sulevia's Plate. +1",hands="Sulev. Gauntlets +1",ring1="Rajas Ring",ring2="Ramuh Ring +1",
		back="Letalis Mantle",waist="Olseni Belt",legs="Sulevi. Cuisses +1",feet="Founder's Greaves"}

	sets.engaged.Tank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
	sets.engaged.BreathTank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
	sets.engaged.Acc.BreathTank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
	sets.engaged.DDTank = {		
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Arke Corazza",--12--
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet="Reverence Leggings +3",
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.engaged.Acc.DDTank = {		
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Arke Corazza",--12--
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet="Reverence Leggings +3",
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.engaged.NoShellTank = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Loricate Torque +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
		
    sets.engaged.Acc.Tank = {		
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Arke Corazza",--12--
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet="Reverence Leggings +3",
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
    sets.engaged.Reraise = set_combine(sets.engaged.Tank, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc.Tank, sets.Reraise)

    sets.engaged.DW.Tank = set_combine(sets.engaged.DW, {neck="Loricate Torque +1",ring1="Defending Ring",ring2="Patricius Ring"})
    sets.engaged.DW.Acc.Tank = set_combine(sets.engaged.DW.Acc, {neck="Loricate Torque +1",ring1="Defending Ring",ring2="Patricius Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)
		
	--------------------------------------
	-- Custom buff sets
	--------------------------------------
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
    sets.buff.Cover = {body="Cab. Surcoat +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'NIN' then
        set_macro_page(2, 4)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 4)
    elseif player.sub_job == 'RDM' then
        set_macro_page(6, 4)
    elseif player.sub_job == 'BLU' then
        set_macro_page(8, 4)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 4)
    else
        set_macro_page(1, 4) --War/Etc
    end
end