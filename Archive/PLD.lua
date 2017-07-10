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
    state.OffenseMode:options('Normal', 'Acc', 'PDT', 'MDT', 'DT')
    state.HybridMode:options('Normal', 'PDT', 'Reraise')
    state.WeaponskillMode:options('Normal', 'Acc')
	state.IdleMode:options('Town', 'DT', 'PDT', 'MDT')
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
    sets.precast.JA['Holy Circle'] = {feet="Rev. Leggings +1"}
    sets.precast.JA['Shield Bash'] = {hands="Cab. Gauntlets"}
    sets.precast.JA['Sentinel'] = {feet="Chevalier's Sabatons"}
    sets.precast.JA['Rampart'] = {head="Cab. Coronet +1"}
    sets.precast.JA['Fealty'] = {body="Cab. Surcoat +1"}
    sets.precast.JA['Divine Emblem'] = {feet="Chev. Sabatons"}
    sets.precast.JA['Cover'] = {head="Rev. Coronet +1"}

    -- add mnd for Chivalry
    sets.precast.JA['Chivalry'] = {ammo="Quartz Tathlum +1",
		head="Rev. Coronet +1",
		body="Cab. Surcoat +1",
		hands="Umuthi Gloves",
		ring1="Levia. Ring +1",
		legs="Rev. Breeches +1",
		feet="Rev Leggings +1"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {ammo="Impatiens",
		head="Chevalier's Armet",
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
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},} 
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Step = {waist="Chaac Belt"}
    sets.precast.Flourish1 = {waist="Chaac Belt"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head="Chevalier's Armet",
		neck="Voltsurge Torque",
		ear1="Nourishing Earring",
		ear2="Loquac. Earring",
		body={ name="Jumalik Mail", augments={'HP+15','Attack+5','Enmity+2',}},
		hands="Sulevia's Gauntlets +1",
		ring1="Prolix Ring",
		ring2="Veneficium Ring",
		back="Repulse Mantle",
		waist="Goading Belt",
		legs="Rev. Breeches +1",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},}

    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS['Savage Blade'] = {ammo="Amar Cluster",
		head="Yaoyotl Helm",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's Leggings +1",
		neck="Fotia Gorget",
		waist="Dynamic Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Pyrosoul Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}

    sets.precast.WS['Savage Blade'].MidAcc = {ammo="Ginsen",}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Requiescat'] = {head={ name="Jumalik Helm", augments={'MND+5','"Mag.Atk.Bns."+10','Magic burst mdg.+6%',}},
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Levia. Ring +1",
		right_ring="Levia. Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
    
    sets.precast.WS['Chant du Cygne'] =  {ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's Leggings +1",
		neck="Fotia Gorget",
		waist="Dynamic Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Pyrosoul Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}}
    
	sets.precast.WS.Resolution = {
		ammo="Cheruski Needle",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's Leggings +1",
		neck="Fotia Gorget",
		waist="Prosilio Belt +1",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Ifrit Ring +1",
		right_ring="Ifrit Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
	
    sets.precast.WS['Sanguine Blade'] = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Pyrosoul Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    
    sets.precast.WS['Atonement'] = {ammo="Paeapua",
		head="Sulevia's Mask +1",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Attack+4','TP Bonus +25',}},
		left_ring="Petrov Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.precast.WS["Knights of Round"] = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Sulevia's Leggings +1",
		neck="Fotia Gorget",
		waist="Dynamic Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Moonshade Earring", augments={'Accuracy +4','TP Bonus +250',}},
		left_ring="Pyrosoul Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {ammo="Incantor Stone",
		head="Chevalier's Armet",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs={ name="Odyssean Cuisses", augments={'"Mag.Atk.Bns."+23','"Fast Cast"+5','INT+4','Mag. Acc.+9',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck={ name="Jeweled Collar", augments={'"Fast Cast"+3','INT+2','MND+2',}},
		waist="Goading Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring",
		back="Repulse Mantle",}
                
    sets.midcast.Enmity = {ammo="Iron Gobbet", -- 2 --
		head="Hero's Galea", -- 7 --
		neck="Ritter Gorget", -- 10 --
		right_ear="Knightly Earring", -- 5 --
		body="Chevalier's Cuirass +1", -- 12 --
		hands="Cab. Gauntlets", -- 12 --
		left_ring="Petrov Ring", -- 4 --
		right_ring="Vocane Ring", -- 5 --
		back="Weard Mantle", -- 4 --
		waist="Creed Baudrier", -- 5 --
		legs="Rev. Breeches +1", -- 10 --
		feet="Chevalier's Sabatons",} -- 13 --
									-- Total Enmity+ = 113~117 --

    sets.midcast.Flash =  {ammo="Iron Gobbet", -- 2 --
		head="Hero's Galea", -- 8 --
		neck="Ritter Gorget", -- 3 --
		right_ear="Loquac. Earring", -- 0 --
		body="Chevalier's Cuirass +1", -- 0 --
		hands="Cab. Gauntlets", -- 6 --
		left_ring="Petrov Ring", -- 4 --
		right_ring="Vocane Ring", -- 0 --
		back="Weard Mantle", -- 4 --
		waist="Creed Baudrier", -- 5 --
		legs="Rev. Breeches +1", -- 5 --
		feet="Chevalier's Sabatons",} -- 5 --
					-- Total Enmity+ = 107~111 --
    
    sets.midcast.Stun = sets.midcast.Flash
    
    sets.midcast.Cure = {ammo="Impatiens",
		head="Rev. Coronet +1",
		body="Jumalik Mail",
		legs="Rev. Breeches +1",
		hands="Souveran Handschuhs",
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Diemer Gorget",
		waist="zoran's Belt",
		left_ear="Hospitaler Earring",
		right_ear="Nourish. Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring",}

    sets.midcast['Enhancing Magic'] = {ammo="Impatiens",
		neck="Colossus's Torque",
		ear1="Andoaa Earring",
		ear2="Augment. Earring",
		body="Shab. Cuirass +1",
		back={ name="Weard Mantle", augments={'VIT+4','DEX+3','Phalanx +3',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		waist="Olympus Sash",
		legs="Rev. Breeches +1"
		}
    
    sets.midcast.Protect = {ring1="Sheltered Ring"}
    sets.midcast.Shell = {ring1="Sheltered Ring"}
    
    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------

    sets.Reraise = {head="Twilight Helm", body="Twilight Mail"}
    
    sets.resting = {neck="Creed Collar",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    

    -- Idle sets
    sets.idle = {ammo="Homiliary", head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Fucho-no-Obi",
		left_ear="Infused Earring",
		left_ring="Paguroidea Ring",
		right_ring="Sheltered Ring", 
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.idle.Town = {main={name="Brilliance", augments={'Shield skill +7','Divine magic skill +10','Enmity+4','DMG:+10',}},
		sub="Ochain",
		ammo="Homiliary",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Fucho-no-Obi",
		left_ear="Steelflash Earring",
		right_ear="Ethereal Earring",
		left_ring="Paguroidea Ring",
		right_ring="Hercules' Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.idle.DT = {sub="Ochain",
		ammo="Brigantia Pebble",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Twilight Torque",
		waist="Fucho-no-Obi",
		left_ear="Ethereal Earring",
		right_ear="Steelflash Earring",
		left_ring="Paguroidea Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
    
    sets.idle.PDT = {sub="Ochain",
		ammo="Brigantia Pebble",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Nierenschutz",
		left_ear="Ethereal Earring",
		right_ear="Steelflash Earring",
		left_ring="Gelatinous Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
									
	sets.idle.MDT = {sub="Aegis",
		head="Rev. Coronet +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Rev. Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Chevalier's Sabatons",
		neck="Twilight Torque",
		waist="Nierenschutz",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring="Fortified Ring",
		right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%', 'Breath dmg. taken -3%', 'Magic dmg. taken -4%',}},
		back="Engulfer Cape",}
    
       
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
    sets.PhysicalShield = {main="Excalibur",sub="Ochain"} -- Ochain
    sets.MagicalShield = {main="Excalibur",sub="Aegis"} -- Aegis

    -- Basic defense sets.
        
    sets.defense.PDT = {sub="Ochain",
		ammo="Brigantia Pebble",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Nierenschutz",
		left_ear="Ethereal Earring",
		right_ear="Steelflash Earring",
		left_ring="Gelatinous Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
									
	sets.defense.Aegis = {sub="Aegis",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Chevalier's Sabatons",
		neck="Twilight Torque",
		waist="Nierenschutz",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring="Fortified Ring",
		right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%', 'Breath dmg. taken -3%', 'Magic dmg. taken -4%',}},
		back="Engulfer Cape",}
		
    sets.defense.Reraise = {ammo="Iron Gobbet",
        head="Twilight Helm",neck="Twilight Torque",ear1="Creed Earring",ear2="Bloodgem Earring",
        body="Twilight Mail",hands="Reverence Gauntlets +1",ring1="Defending Ring",ring2=gear.DarkRing.physical,
        back="Weard Mantle",waist="Nierenschutz",legs="Reverence Breeches +1",feet="Reverence Leggings +1"}
    
	sets.defense.PDT.DT = {sub="Ochain",
		ammo="Brigantia Pebble",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Nierenschutz",
		left_ear="Ethereal Earring",
		right_ear="Steelflash Earring",
		left_ring="Gelatinous Ring",
		right_ring="Vocane Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

	
	sets.defense.Charm = {ammo="Hasty Pinion +1",
		head={name="Yorium Barbuta",augments={"Accuracy+21","Dbl. Atk. +2","Damage taken -1%"}}, -- 1 DT -- [Upgrade: Yorium Barbuta -3% DT]
		neck="Subtlety Spec.",
		ear1="Zennaroi Earring",
		ear2="Ethereal Earring",
		body="Cab. Surcoat +1", -- 10 DT [Upgrade: Tartarus Platemail -10% DT] --
		hands="Souv. Handschuhs", -- 4 DT 2/5 Souv. Set --
		ring1="Defending Ring", -- 10 DT --
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}, -- 3 DT --
		waist="Flume Belt +1", -- 4 --
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}}, -- 15 --
		feet="Souveran Schuhs"} 
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
		
    -- To cap MDT with Shell IV (52/256), need 76/256 in gear.
    -- Shellra V can provide 75/256, which would need another 53/256 in gear.
    
	sets.defense.MDT = {sub="Aegis",
		ammo="Incantor Stone",
		head="Rev. Coronet +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Rev. Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Chevalier's Sabatons",
		neck="Twilight Torque",
		waist="Nierenschutz",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring="Fortified Ring",
		right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%', 'Breath dmg. taken -3%', 'Magic dmg. taken -4%',}},
		back="Engulfer Cape",}
		
	--------------------------------------
    -- Engaged sets
    --------------------------------------
    
    sets.engaged = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Enlivened Ring",
		right_ring="Fortified Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.Acc = {
		main="Excalibur",
		sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulev. Gauntlets +1",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet="Sulev. Leggings +1",
		neck="Agitator's Collar",
		waist="Kentarch Belt",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Patricius Ring",
		right_ring="Enlivened Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.engaged.PDT = {sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Agitator's Collar",
		waist="Nierenshutz",
		left_ear="Steelflash Earring",
		right_ear="Colossus's Earring",
		left_ring="Vocane Ring",
		right_ring="Gelatinous Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
									
	sets.engaged.DT = {sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Twilight Torque",
		waist="Nierenshutz",
		left_ear="Steelflash Earring",
		right_ear="Colossus's Earring",
		left_ring="Vocane Ring",
		right_ring="Gelatinous Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
									
	sets.engaged.MDT = {sub="Aegis",
		ammo="Incantor Stone",
		head="Rev. Coronet +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Chevalier's Sabatons",
		neck="Twilight Torque",
		waist="Nierenschutz",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring="Fortified Ring",
		right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%', 'Breath dmg. taken -3%', 'Magic dmg. taken -4%',}},
		back="Engulfer Cape",}
				
    sets.engaged.DW = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet="Yorium Sabatons",
		neck="Asperity Necklace",
		waist="Kentarch Belt",
		left_ear="Steelflash Earring",
		right_ear="Brutal Earring",
		left_ring="Enlivened Ring",
		right_ring="Fortified Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.DW.Acc = {ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body="Sulevia's Platemail +1",
		hands="Sulevia's Gauntlets +1",
		legs={ name="Souveran Diechlings", augments={'STR+10','VIT+10','Accuracy+15',}},
		feet={ name="Odyssean Greaves", augments={'Accuracy+28','Weapon skill damage +3%','DEX+10',}},
		neck="Subtlety Spectacles",
		waist="Dynamic Belt",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Enlivened Ring",
		right_ring="Fortified Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}

    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT), {sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Nierenshutz",
		left_ear="Steelflash Earring",
		right_ear="Colossus's Earring",
		left_ring="Vocane Ring",
		right_ring="Gelatinous Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
									
	sets.engaged.DW.DT = set_combine(sets.engaged.DT), {sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Agitator's Collar",
		waist="Nierenshutz",
		left_ear="Steelflash Earring",
		right_ear="Colossus's Earring",
		left_ring="Vocane Ring",
		right_ring="Gelatinous Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
	sets.engaged.DW.MDT = set_combine(sets.engaged.MDT), {sub="Aegis",
		ammo="Incantor Stone",
		head="Rev. Coronet +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet="Chevalier's Sabatons",
		neck="Twilight Torque",
		waist="Nierenschutz",
		left_ear="Merman's Earring",
		right_ear="Merman's Earring",
		left_ring="Fortified Ring",
		right_ring={ name="Dark Ring", augments={'Phys. dmg. taken -5%', 'Breath dmg. taken -3%', 'Magic dmg. taken -4%',}},
		back="Engulfer Cape",}
									
    sets.engaged.Acc.PDT = set_combine(sets.engaged.Acc, {body="Chevalier's Cuirass +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)

    sets.engaged.DW.PDT = set_combine(sets.engaged.PDT), {sub="Ochain",
		ammo="Amar Cluster",
		head="Sulevia's Mask +1",
		body={ name="Souveran Cuirass", augments={'HP+50','STR+10','Accuracy+10',}},
		hands="Sulevia's Gauntlets +1",
		legs="Sulevia's Cuisses +1",
		feet={ name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}},
		neck="Diemer Gorget",
		waist="Nierenshutz",
		left_ear="Steelflash Earring",
		right_ear="Colossus's Earring",
		left_ring="Vocane Ring",
		right_ring="Gelatinous Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},}
		
    sets.engaged.DW.Acc.PDT = set_combine(sets.engaged.DW.Acc, {body="Chevalier's Cuirass +1",neck="Twilight Torque",ring1="Defending Ring"})
    sets.engaged.DW.Reraise = set_combine(sets.engaged.DW, sets.Reraise)
    sets.engaged.DW.Acc.Reraise = set_combine(sets.engaged.DW.Acc, sets.Reraise)


    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Doom = {ring2="Saida Ring"}
    sets.buff.Cover = {head="Reverence Coronet +1", body="Caballarius Surcoat"}
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