-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'None')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Chrono Bullet"
    gear.WSbullet = "Chrono Bullet"
    gear.MAbullet = "Living Bullet"
    gear.QDbullet = "Living Bullet"
    options.ammo_warning_limit = 15

	gear.tp_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Store TP"+10',}}
	gear.snap_jse_back = { name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','"Snapshot"+10',}}
	gear.herculean_nuke_head = { name="Herculean Helm", augments={'Mag. Acc.+8','AGI+10','Damage taken-4%','Accuracy+3 Attack+3','Mag. Acc.+18 "Mag.Atk.Bns."+18',}}
	gear.herculean_wsd_legs={ name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+22','STR+9','Weapon skill damage +6%','Accuracy+15 Attack+15','Mag. Acc.+8 "Mag.Atk.Bns."+8',}}
	gear.ranger_wsd_jse_back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}}
	gear.herculean_wsd_hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +2%','CHR+9',}}
	
    -- Additional local binds
	send_command('bind ^` gs c cycle ElementalMode')
	send_command('bind !` gs c elemental quickdraw')
	
	send_command('bind ^backspace input /ja "Double-up" <me>')
	send_command('bind @backspace input /ja "Snake Eye" <me>')
	send_command('bind !backspace input /ja "Fold" <me>')
	send_command('bind ^@!backspace input /ja "Crooked Cards" <me>')
	
	send_command('bind ^\\\\ input /ja "Random Deal" <me>')
    send_command('bind !\\\\ input /ja "Bolter\'s Roll" <me>')
	send_command('bind ^@!\\\\ gs c toggle LuzafRing')
	send_command('bind @f7 gs c toggle AutoShootMode')
	
	--require('rnghelper')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Precast sets to enhance JAs
	
	sets.precast.JA['Triple Shot'] = {body="Chasseur's Frac +1"}
    sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes +1"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
	sets.Obi = {waist="Hachirin-no-Obi"}
    
    sets.precast.CorsairRoll = {range="Compensator",
        head="Lanun Tricorne +1",neck="Regal Necklace",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Lanun Frac +3",hands="Chasseur's Gants",ring1="Barataria Ring",ring2="Defending Ring",
        back=gear.tp_jse_back,waist="Flume Belt",legs="Desultor Tassets",feet=gear.herculean_dt_feet}
		
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants"})
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	sets.Self_Waltz = {head="Mummu Bonnet +2",body="Passion Jacket",ring1="Asklepian Ring"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    sets.precast.RA = {
		ammo=gear.RAbullet,
        head="Meghanada Visor +2",
		neck="Iskur Gorget",
		ear1="Enervating Earring",
		ear2="Telos Earring",
        body="Laksamana's frac +3",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		ring1="Ilabrat Ring",
		ring2="Apate Ring",
        back=gear.snap_jse_back,
		waist="Yemaya Belt",
		legs="Adhemar Kecks",
		feet="Malignance Boots"
		}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Meghanada Gloves +2",ring1="Ilabrat Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs="Carmine Cuisses +1",feet="Malignance Boots"}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head="Carmine Mask +1",ring2="Rufescent Ring",back="Bleating Mantle",legs="Carmine Cuisses +1",feet="Carmine Greaves"})
	
	sets.precast.WS['Savage Blade'] = {
		ammo=gear.WSbullet,
        head="Meghanada Visor +2",
		neck="Fotia Gorget",
		ear1="Moonshade Earring",
		ear2="Ishvara Earring",
        body={ name="Herculean Vest", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','DEX+8','Accuracy+3',}},
		hands="Meghanada Gloves +2",
		ring1="Regal Ring",
		ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,
		waist="Fotia Belt",
		legs=gear.herculean_wsd_legs,
		feet=gear.herculean_wsd_feet
		}

    sets.precast.WS['Savage Blade'].Acc = {ammo=gear.WSbullet,
        head="Carmine Mask +1",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Malignance Tabard",hands="Meghanada Gloves +2",ring1="Regal Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet="Mummu Gamashes +2"}
	
    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Laksamana's frac +3",hands="Meghanada Gloves +2",ring1="Ilabrat Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Meghanada Visor +2",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Laksamana's frac +3",hands="Meghanada Gloves +2",ring1="Ilabrat Ring",ring2="Apate Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Lanun Frac +3",hands=gear.herculean_wsd_hands,ring1="Dingir Ring",ring2="Archon Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

    sets.precast.WS['Leaden Salute'].Acc = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Baetyl Pendante",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Lanun Frac +3",hands=gear.herculean_wsd_hands,ring1="Dingir Ring",ring2="Archon Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

    sets.precast.WS['Wildfire'] = {--ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Novio Earring",ear2="Friomisi Earring",
        body="Lanun Frac +3",hands=gear.herculean_wsd_hands,ring1="Dingir Ring",ring2="Ilabrat Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

    sets.precast.WS['Wildfire'].Acc = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Novio Earring",ear2="Friomisi Earring",
        body="Lanun Frac +3",hands=gear.herculean_wsd_hands,ring1="Dingir Ring",ring2="Ilabrat Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {}
	sets.precast.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves"}
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}	
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Novio Earring",
        body="Lanun Frac +3",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Shiva Ring +1",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet="Lanun Bottes +3"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Digni. Earring",ear2="Telos Earring",
        body="Lanun Frac +3",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Mummu Kecks +2",feet="Lanun Bottes +3"}

    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot['Light Shot'], {feet="Lanun Bottes +3"})

    -- Ranged gear
    sets.midcast.RA = {
		ammo=gear.RAbullet,
        head="Meghanada Visor +2",
		neck="Iskur Gorget",
		ear1="Enervating Earring",
		ear2="Telos Earring",
        body="Malignance Tabard",
		hands="Meghanada Gloves +2",
		ring1="Ilabrat Ring",
		ring2="Apate Ring",
        back=gear.ranger_wsd_jse_back,
		waist="Eschan Stone",
		legs="Malignance Tights",
		feet="Malignance Boots",
		}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Meghanada Visor +2",neck="Combatant's Torque",ear1="Enervating Earring",ear2="Telos Earring",
        body="Malignance Tabard",hands="Meghanada Gloves +2",ring1="Ilabrat Ring",ring2="Apate Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Carmine Cuisses +1",feet="Malignance Boots"}
		
	sets.buff['Triple Shot'] = {head="Oshosi Mask", body="Chasseur's Frac +1", legs="Oshosi Trousers"}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
    sets.idle = {
			ammo=gear.RAbullet,
			head="Meghanada Visor +2",
			body="Malignance Tabard",
			hands="Meg. Gloves +2",
			legs="Malignance Tights",
			feet="Malignance Boots",
			neck="Loricate Torque +1",
			waist="Reiki Yotai",
			left_ear="Etiolation Earring",
			right_ear="Telos Earring",
			left_ring="Karieyh Ring",
			right_ring="Defending Ring",
			back="Moonbeam Cape",
		}
		
    sets.idle.Refresh = {ammo=gear.RAbullet,
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Mekosu. Harness",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet=gear.herculean_dt_feet}
    
    -- Defense sets
    sets.defense.PDT = {
			ammo=gear.RAbullet,
			head="Meghanada Visor +2",
			body="Malignance Tabard",
			hands="Meg. Gloves +2",
			legs="Malignance Tights",
			feet="Malignance Boots",
			neck="Loricate Torque +1",
			waist="Reiki Yotai",
			left_ear="Etiolation Earring",
			right_ear="Telos Earring",
			left_ring="Ilabrat Ring",
			right_ring="Defending Ring",
			back="Moonbeam Cape",
		}

    sets.defense.MDT = {
			ammo=gear.RAbullet,
			head="Meghanada Visor +2",
			body="Malignance Tabard",
			hands="Meg. Gloves +2",
			legs="Malignance Tights",
			feet="Malignance Boots",
			neck="Loricate Torque +1",
			waist="Reiki Yotai",
			left_ear="Etiolation Earring",
			right_ear="Telos Earring",
			left_ring="Ilabrat Ring",
			right_ring="Defending Ring",
			back="Moonbeam Cape",
		}
    

    sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.Weapons = {main="Fettering Blade", sub="Nusku Shield"}
	sets.DualWeapons = {main="Fettering Blade", sub="Demersal Degen"}
	sets.DualRangedWeapons = {main="Fettering Blade", sub="Kustawi +1"}
	sets.DDGunWeapon = {range="Fomalhaut"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body="Malignance Tabard",
		hands="Floral Gauntlets",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.tp_jse_back,waist="Reiki Yotai",
		legs="Samnuha Tights",
		feet="Malignance Boots"
		}
    
    sets.engaged.Acc = {
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Brutal Earring",
		body="Malignance Tabard",
		hands="Floral Gauntlets",
		ring1="Ilabrat Ring",
		ring2="Regal Ring",
		back=gear.tp_jse_back,waist="Reiki Yotai",
		legs="Samnuha Tights",
		feet="Malignance Boots"
		}

    sets.engaged.DW = {
		head="Dampening Tam",
		neck="Combatant's Torque",
		ear1="Cessance Earring",
		ear2="Suppanomimi",
		body="Adhemar Jacket",
		hands="Floral Gauntlets",
		ring1="Chirich Ring +1",
		ring2="Regal Ring",
		back=gear.tp_jse_back,
		waist="Reiki Yotai",
		legs="Carmine Cuisses +1",
		feet="Malignance Boots"
		}
    
    sets.engaged.DW.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body="Malignance Tabard",hands="Floral Gauntlets",ring1="Ilabrat Ring",ring2="Regal Ring",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Carmine Cuisses +1",feet=gear.herculean_acc_feet}

end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 14)
end