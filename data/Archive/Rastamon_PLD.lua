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
    state.Buff.Sentinel = buffactive.sentinel or false
    state.Buff.Cover = buffactive.cover or false
    state.Buff.Doom = buffactive.Doom or false
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'PDT', 'MDT', 'DT', 'HP')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
	state.IdleMode:options('Town', 'DT', 'PDT', 'MDT', 'HP')
    state.CastingMode:options('Normal', 'Resistant')
    state.PhysicalDefenseMode:options('PDT', 'Aegis', 'Reraise', 'DT', 'Charm', 'None')
    state.MagicalDefenseMode:options('MDT', 'Ochain', 'Reraise', 'DT', 'Charm', 'None')
    
    state.ExtraDefenseMode = M{['description']='Extra Defense Mode', 'None', 'MP', 'Knockback', 'MP_Knockback'}
    state.EquipShield = M(false, 'Equip Shield w/Defense')

    update_defense_mode()
    
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')
    send_command('bind !f11 gs c cycle ExtraDefenseMode')
    send_command('bind @f10 gs c toggle EquipShield')
    send_command('bind @f11 gs c toggle EquipShield')

    select_default_macro_book()
end

function user_unload()
    send_command('unbind ^f11')
    send_command('unbind !f11')
    send_command('unbind @f10')
    send_command('unbind @f11')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------
    
    -- Precast sets to enhance JAs
    sets.precast.JA['Invincible'] = {legs="Cab. Breeches +1"}
    sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings +2"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets +1"}
    sets.precast.JA['Sentinel'] = {feet="Caballarius Leggings +1"}
    sets.precast.JA['Rampart'] = {head="Cab. Coronet +1"}
    sets.precast.JA['Fealty'] = {body="Cab. Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons +1"}
    sets.precast.JA['Cover'] = {head="Rev. Coronet +1", body="Caballarius Surcoat +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {
		ammo="Quartz Tathlum +1",
		head="Rev. Coronet +1",
		body="Cab. Surcoat +1",
		hands="Umuthi Gloves",
		ring1="Levia. Ring +1",
		legs="Rev. Breeches +1",
		feet="Rev Leggings +1"
		}
		
	sets.precast.Cure = {
		ammo="Impatiens",
		head="Carmine Mask",
		body="Jumalik Mail",
		legs="Rev. Breeches +1",
		hands="Souveran Handschuhs",
		feet="Carmine Greaves",
		neck="Diemer Gorget",
		waist="zoran's Belt",
		left_ear="Mendicant's Earring",
		right_ear="Nourish. Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring"
		}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Impatiens",
		head="Souveran Schaller",
		neck={ name="Jeweled Collar", augments={'"Fast Cast"+3','INT+2','MND+2',}},
		ear1="Enchntr. Earring +1",
		ear2="Loquac. Earring",
		body="Jumalik Mail",
		hands="Leyline Gloves",
		ring1="Prolix Ring",
		ring2="Veneficium Ring",
		back="Repulse Mantle",
		waist="Goading Belt",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+25 Attack+25','Magic dmg. taken -1%','VIT+10','Accuracy+6',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}}
		} 
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

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
		feet="Carmine Greaves",}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Savage Blade'] = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Sulevia's Platemail +1",
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

    sets.precast.WS['Savage Blade'].MidAcc = {ammo="Ginsen",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Dagon Breastplate",
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet="Flamma GamBieras +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Levia. Ring +1",
		right_ring="Levia. Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
    
    sets.precast.WS['Chant du Cygne'] =  {
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
    
	sets.precast.WS.Resolution = {
		ammo="Cheruski Needle",
		head="Flamma Zucchetto +1",
		body="Dagon Breastplate",
		hands="Sulevia's Gauntlets +2",
		legs="Sulevia's Cuisses +2",
		feet="Flamma GamBieras +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Ifrit Ring +1",
		right_ring="Ifrit Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
	
    sets.precast.WS['Sanguine Blade'] = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Dagon Breastplate",
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Pyrosoul Ring",
		right_ring="Patricius Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
    
    sets.precast.WS['Atonement'] = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		--head="Flamma Zucchetto +1",
		body="Dagon Breastplate",
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Petrov Ring",
		right_ring="Karieyh Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
		
	sets.precast.WS["Knights of Round"] = {
		ammo="Amar Cluster",
		head="Flamma Zucchetto +1",
		body="Dagon Breastplate",
		hands={ name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}},
		legs="Sulevia's Cuisses +2",
		feet="Flamma GamBieras +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Karieyh Ring",
		right_ring="Patricius Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		ammo="Incantor Stone",
		head="Carmine Mask",
		body="Arke Corazza",
		hands="Sulevia's Gauntlets +2",
		legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+23','"Fast Cast"+5','INT+4','Mag. Acc.+9',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck={ name="Jeweled Collar", augments={'"Fast Cast"+3','INT+2','MND+2',}},
		waist="Goading Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring",
		back="Repulse Mantle"
		}
                
    sets.midcast.Enmity = {
		ammo="Iron Gobbet", -- 2 --
		head="Hero's Galea", -- 7 --
		neck="Unmoving Collar +1", -- 10 --
		left_ear="Cryptic Earring", -- 4 -- 
		right_ear="Thureous Earring", -- 0 --
		body="Reverence Surcoat +2", -- 12 --
		hands="Cab. Gauntlets +1", -- 6 --
		left_ring="Petrov Ring", -- 4 --
		right_ring="Hercules' Ring", -- 3 --
		back="Agema Cape", -- 5 --
		waist="Creed Baudrier", -- 5 --
		legs="Rev. Breeches +1", -- 5 --
		feet="Chevalier's Sabatons +1" -- 9 --
		} -- 9 --
									-- Total Enmity+ = 113~117 --

    sets.midcast.Flash =  {
		ammo="Iron Gobbet", -- 2 --
		head="Hero's Galea", -- 8 --
		neck="Unmoving collar +1", -- 10 --
		left_ear="Cryptic Earring", -- 4 -- 
		right_ear="Thureous Earring", -- 0 --
		body="Reverence Surcoat +2", -- 0 --
		hands="Cab. Gauntlets +1", -- 6 --
		left_ring="Petrov Ring", -- 4 --
		right_ring="Hercules' Ring", -- 0 --
		back="Moonbeam Cape", -- 4 --
		waist="Creed Baudrier", -- 5 --
		legs="Rev. Breeches +1", -- 5 --
		feet="Chevalier's Sabatons +1" -- 5 --
		} 
					-- Total Enmity+ = 107~111 --
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {
		ammo="Impatiens",
		head="Souveran Schaller",
		body="Jumalik Mail",
		legs="Rev. Breeches +1",
		hands="Souveran Handschuhs",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Diemer Gorget",
		waist="Creed Baudrier",
		left_ear="Thureous Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring"
		}

    sets.midcast['Enhancing Magic'] = {ammo="Impatiens",
		neck="Incanter's Torque",
		ear1="Andoaa Earring",
		ear2="Augment. Earring",
		body="Shab. Cuirass +1",
		back={ name="Moonbeam Cape", augments={'VIT+4','DEX+3','Phalanx +3',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		waist="Siegel Sash",
		legs="Rev. Breeches +1"
		}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",ring1="Sheltered Ring",ring2="Paguroidea Ring"}    

    -- Idle sets
    sets.idle = {
		ammo="Homiliary", 
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Arke Corazza",
		hands="Sulevia's Gauntlets +2",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet="Reverence Leggings +3",
		neck="Diemer Gorget",
		waist="Fucho-no-Obi",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Paguroidea Ring",
		right_ring="Karieyh Ring", 
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	}

    sets.idle.Town = {
		ammo="Amar Cluster",
		head={ name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}},
		body="Arke Corazza",
		hands="Sulevia's Gauntlets +2",
		legs="Sulevia's Cuisses +2",
		feet="Reverence Leggings +3",
		neck="Loricate Torque +1",
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.idle.HP={
		ammo="Amar Cluster",
		head={ name="Souveran Schaller", augments={'HP+80','VIT+10','Phys. dmg. taken -3',}},
		body="Rev. Surcoat +2",
		hands={ name="Souv. Handschuhs", augments={'HP+50','Shield skill +10','Phys. dmg. taken -3',}},
		legs="Sulevi. Cuisses +1",
		feet="Rev. Leggings +3",
		neck="Agitator's Collar",
		waist="Creed Baudrier",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
		}
		
	sets.idle.DT = { --47 DT, 23 PDT--
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
    
    sets.idle.PDT = {sub="Ochain",
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
    
       
    sets.Kiting = {legs="Crimson Cuisses"}

    sets.latent_refresh = {waist="Fucho-no-obi"}


    --------------------------------------
    -- Defense sets
    --------------------------------------
    
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.Knockback = {back="Repulse Mantle"}
    sets.MP = {neck="Creed Collar",waist="Flume Belt +1"}
    sets.MP_Knockback = {neck="Creed Collar",waist="Flume Belt +1",back="Repulse Mantle"}
    
    -- If EquipShield toggle is on (Win+F10 or Win+F11), equip the weapon/shield combos here
    -- when activating or changing defense mode:
    sets.PhysicalShield = {main="Burtgang",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Burtgang",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {sub="Ochain",
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
									
	sets.defense.Aegis = {sub="Aegis",
		head="Sulevia's Mask +2",
		body="Arke Corazza",--12--
		hands="Sulevia's Gauntlets +2",
		legs="Sulevia's Cuisses +2",
		feet="Chevalier's Sabatons +1",
		neck="Loricate Torque +1",
		waist="Nierenschutz",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Engulfer Cape"
		}
		
    sets.defense.Reraise = {ammo="Iron Gobbet",
        head="Twilight Helm",neck="Loricate Torque +1",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Twilight Mail",hands="Reverence Gauntlets +1",ring1="Moonbeam Ring",ring2="Moonbeam Ring",
        back="Moonbeam Cape",waist="Nierenschutz",legs="Reverence Breeches +1",feet="Reverence Leggings +1"}
    
	sets.defense.PDT.DT = {sub="Ochain",
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

	
	sets.defense.Charm = {
		ammo="Amar Cluster",
		head={name="Yorium Barbuta",augments={"Accuracy+21","Dbl. Atk. +2","Damage taken -1%"}}, -- 1 DT -- [Upgrade: Yorium Barbuta -3% DT]
		neck="Subtlety Spec.",
		ear1="Zennaroi Earring",
		ear2="Ethereal Earring",
		body="Arke Corazza",--12--
		hands="Souv. Handschuhs", -- 4 DT 2/5 Souv. Set --
		ring1="Defending Ring", -- 10 DT --
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}, -- 3 DT --
		waist="Flume Belt +1", -- 4 --
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}}, -- 15 --
		feet="Souveran Schuhs"
		} 
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
		
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    
	sets.defense.MDT = {
		sub="Aegis",
		ammo="Amar Cluster",
		head="Sulevia's Mask +2",
		body="Arke Corazza",--12--
		hands="Rev. Gauntlets +1",
		legs="Sulevi. Cuisses +1",
		feet="Sulev. Leggings +1",
		neck="Warder's Charm +1",
		waist="Nierenschutz",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back="Engulfer Cape"
	}
		
	--------------------------------------
    -- Engaged sets
    --------------------------------------
    
	--DT = 26 PDT = 27 MDT = 3--
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
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.engaged.HP={
		ammo="Amar Cluster",
		head={ name="Souveran Schaller", augments={'HP+80','VIT+10','Phys. dmg. taken -3',}},
		body="Rev. Surcoat +2",
		hands={ name="Souv. Handschuhs", augments={'HP+50','Shield skill +10','Phys. dmg. taken -3',}},
		legs="Sulevi. Cuisses +1",
		feet="Rev. Leggings +3",
		neck="Agitator's Collar",
		waist="Creed Baudrier",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
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
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.engaged.PDT = {sub="Ochain",
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
									
	sets.engaged.DT = {sub="Ochain",
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
									
	sets.engaged.MDT = { 
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
				
    sets.engaged.DW = {
		ammo="Amar Cluster",
		head="Sulevia's Mask +2",
		body="Arke Corazza",--12--
		hands="Sulevia's Gauntlets +2",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet="Yorium Sabatons",
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Odnowa Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Enlivened Ring",
		right_ring="Fortified Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.DW.Acc = {ammo="Amar Cluster",
		head="Sulevia's Mask +2",
		body="Arke Corazza",--12--
		hands="Sulevia's Gauntlets +2",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Subtlety Spectacles",
		waist="Dynamic Belt",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Moonbeam Ring",
		right_ring="Moonbeam Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT), {sub="Ochain",
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
									
	sets.engaged.DW.DT = set_combine(sets.engaged.DT), {sub="Ochain",
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
		
	sets.engaged.DW.MDT = set_combine(sets.engaged.MDT), {sub="Aegis",
		ammo="Amar Cluster",
		head="Sulevia's Mask +2", --5--
		body="Arke Corazza", --12--
		hands="Sulevia's Gauntlets +2", --5--
		legs="Sulevia's Cuisses +2", --7--
		feet="Reverence Leggings +3", --0--
		neck="Warder's Charm +1", --6--
		waist="Creed Baudrier",
		left_ear="Odnowa Earring", 
		right_ear="Odnowa Earring +1", 
		left_ring="Moonbeam Ring", --3--DT
		right_ring="Moonbeam Ring", --10--
		back="Moonbeam Cape",--3--
		}
									
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Arke Corazza",neck="Loricate Torque +1",ring1="Moonbeam Ring"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT), {sub="Ochain",
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
		
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Arke Corazza",neck="Loricate Torque +1",ring1="Defending Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Cab. Surcoat +1"}
end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_midcast(spell, action, spellMap, eventArgs)
    -- If DefenseMode is active, apply that gear over midcast
    -- choices.  Precast is allowed through for fast cast on
    -- spells, but we want to return to def gear before there's
    -- time for anything to hit us.
    -- Exclude Job Abilities from this restriction, as we probably want
    -- the enhanced effect of whatever item of gear applies to them,
    -- and only one item should be swapped out.
    if state.DefenseMode.value ~= 'None' and spell.type ~= 'JobAbility' then
        handle_equipping_gear(player.status)
        eventArgs.handled = true
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when the player's status changes.
function job_state_change(field, new_value, old_value)
    classes.CustomDefenseGroups:clear()
    classes.CustomDefenseGroups:append(state.ExtraDefenseMode.current)
    if state.EquipShield.value == true then
        classes.CustomDefenseGroups:append(state.DefenseMode.current .. 'Shield')
    end

    classes.CustomMeleeGroups:clear()
    classes.CustomMeleeGroups:append(state.ExtraDefenseMode.current)
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_defense_mode()
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    if state.Buff.Doom then
        idleSet = set_combine(idleSet, sets.buff.Doom)
    end
    
    return idleSet
end

-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
    if state.Buff.Doom then
        meleeSet = set_combine(meleeSet, sets.buff.Doom)
    end
    
    return meleeSet
end

function customize_defense_set(defenseSet)
    if state.ExtraDefenseMode.value ~= 'None' then
        defenseSet = set_combine(defenseSet, sets[state.ExtraDefenseMode.value])
    end
    
    if state.EquipShield.value == true then
        defenseSet = set_combine(defenseSet, sets[state.DefenseMode.current .. 'Shield'])
    end
    
    if state.Buff.Doom then
        defenseSet = set_combine(defenseSet, sets.buff.Doom)
    end
    
    return defenseSet
end


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
        msg = msg .. ', Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end

    if state.ExtraDefenseMode.value ~= 'None' then
        msg = msg .. ', Extra: ' .. state.ExtraDefenseMode.value
    end
    
    if state.EquipShield.value == true then
        msg = msg .. ', Force Equip Shield'
    end
    
    if state.Kiting.value == true then
        msg = msg .. ', Kiting'
    end

    if state.PCTargetMode.value ~= 'default' then
        msg = msg .. ', Target PC: '..state.PCTargetMode.value
    end

    if state.SelectNPCTargets.value == true then
        msg = msg .. ', Target NPCs'
    end

    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_defense_mode()
    if player.equipment.main == 'Kheshig Blade' and not classes.CustomDefenseGroups:contains('Kheshig Blade') then
        classes.CustomDefenseGroups:append('Kheshig Blade')
    end
    
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
        if player.equipment.sub and not player.equipment.sub:contains('Shield') and
           player.equipment.sub ~= 'Aegis' and player.equipment.sub ~= 'Ochain' then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    set_macro_page(1, 6)
end