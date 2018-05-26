-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'None')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'Acc', 'Att', 'Mod')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Refresh')

    gear.RAbullet = "Eminent Bullet"
    gear.WSbullet = "Eminent Bullet"
    gear.MAbullet = "Orichalc. Bullet"
    gear.QDbullet = "Animikii Bullet"
    options.ammo_warning_limit = 15

	gear.tp_jse_back = {name="Camulus's Mantle",augments={'DEX+19','Accuracy+12 Attack+12',}}
	gear.ranger_wsd_jse_back = {name="Camulus's Mantle",augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}}
	
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
    sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes"}
    sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
    sets.precast.FoldDoubleBust = {hands="Lanun Gants"}
    
    sets.precast.CorsairRoll = {range="Compensator",
        head="Lanun Tricorne",neck="Regal Necklace",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Lanun Frac",hands="Chasseur's Gants",ring1="Barataria Ring",ring2="Luzaf's Ring",
        back="Camulus's Mantle",waist="Flume Belt",legs="Desultor Tassets",feet=gear.herculean_dt_feet}
		
    sets.precast.LuzafRing = {ring2="Luzaf's Ring"}
    
    sets.precast.CorsairRoll["Caster's Roll"] = set_combine(sets.precast.CorsairRoll, {legs="Chas. Culottes"})
    sets.precast.CorsairRoll["Courser's Roll"] = set_combine(sets.precast.CorsairRoll, {feet="Chasseur's Bottes +1"})
    sets.precast.CorsairRoll["Blitzer's Roll"] = set_combine(sets.precast.CorsairRoll, {head="Chass. Tricorne"})
    sets.precast.CorsairRoll["Tactician's Roll"] = set_combine(sets.precast.CorsairRoll, {body="Chasseur's Frac +1"})
    sets.precast.CorsairRoll["Allies' Roll"] = set_combine(sets.precast.CorsairRoll, {hands="Chasseur's Gants +1"})
    
    sets.precast.CorsairShot = {}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Carmine Mask +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body=gear.herculean_waltz_body,hands=gear.herculean_waltz_hands,ring1="Defending Ring",ring2="Valseur's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Dashing Subligar",feet=gear.herculean_waltz_feet}
		
	sets.Self_Waltz = {head="Mummu Bonnet +1",body="Passion Jacket",ring1="Asklepian Ring"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    
    sets.precast.FC = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves +1"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket"})


    sets.precast.RA = {ammo=gear.RAbullet,
        head="Chass. Tricorne",
        hands="Lanun Gants +1",
        back="Camulus's Mantle",waist="Impulse Belt",legs="Adhemar Kecks",feet="Meg. Jam. +1"}

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Meghanada Visor +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs="Meg. Chausses +1",feet="Meg. Jam. +1"}


    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

    sets.precast.WS['Requiescat'] = set_combine(sets.precast.WS, {head="Carmine Mask +1",ring2="Rufescent Ring",back="Bleating Mantle",legs="Carmine Cuisses +1",feet="Carmine Greaves +1"})
	
	sets.precast.WS['Savage Blade'] = {ammo=gear.WSbullet,
        head="Lilitu Headpiece",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Rufescent Ring",ring2="Ifrit Ring +1",
        back="Bleating Mantle",waist="Grunfeld Rope",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet}

    sets.precast.WS['Savage Blade'].Acc = {ammo=gear.WSbullet,
        head="Carmine Mask +1",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Rufescent Ring",ring2="Karieyh Ring",
        back="Bleating Mantle",waist="Grunfeld Rope",legs="Carmine Cuisses +1",feet=gear.herculean_wsd_feet}
	
    sets.precast.WS['Last Stand'] = {ammo=gear.WSbullet,
        head="Meghanada Visor +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet}

    sets.precast.WS['Last Stand'].Acc = {ammo=gear.WSbullet,
        head="Meghanada Visor +1",neck="Fotia Gorget",ear1="Moonshade Earring",ear2="Telos Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Apate Ring",
        back=gear.ranger_wsd_jse_back,waist="Fotia Belt",legs=gear.herculean_wsd_legs,feet=gear.herculean_wsd_feet}

    sets.precast.WS['Leaden Salute'] = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Baetyl Pendant",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Archon Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet=gear.hercluean_nuke_feet}

    sets.precast.WS['Leaden Salute'].Acc = {ammo=gear.MAbullet,
        head="Pixie Hairpin +1",neck="Sanctity Necklace",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Archon Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet=gear.hercluean_nuke_feet}

    sets.precast.WS['Wildfire'] = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet=gear.hercluean_nuke_feet}

    sets.precast.WS['Wildfire'].Acc = {ammo=gear.MAbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Karieyh Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs=gear.herculean_wsd_legs,feet=gear.hercluean_nuke_feet}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {}
	sets.precast.AccMaxTP = {}
        
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Carmine Mask +1",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Lebeche Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet="Carmine Greaves +1"}
        
    -- Specific spells

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",hands="Buremte Gloves",ring2="Kunaji Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}	
	
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.CorsairShot = {ammo=gear.QDbullet,
        head=gear.herculean_nuke_head,neck="Sanctity Necklace",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Ilabrat Ring",ring2="Shiva Ring +1",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Mummu Kecks +1",feet="Chasseur's Bottes"}

    sets.midcast.CorsairShot['Light Shot'] = {ammo=gear.QDbullet,
        head="Carmine Mask +1",neck="Sanctity Necklace",ear1="Digni. Earring",ear2="Telos Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Stikini Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"}

    sets.midcast.CorsairShot['Dark Shot'] = set_combine(sets.midcast.CorsairShot['Light Shot'], {feet="Chasseur's Bottes"})

    -- Ranged gear
    sets.midcast.RA = {ammo=gear.RAbullet,
        head="Meghanada Visor +1",neck="Ocachi Gorget",ear1="Enervating Earring",ear2="Telos Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Apate Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Meg. Chausses +1",feet="Meg. Jam. +1"}

    sets.midcast.RA.Acc = {ammo=gear.RAbullet,
        head="Meghanada Visor +1",neck="Combatant's Torque",ear1="Enervating Earring",ear2="Telos Earring",
        body="Meg. Cuirie +1",hands="Meg. Gloves +1",ring1="Ilabrat Ring",ring2="Apate Ring",
        back=gear.ranger_wsd_jse_back,waist="Eschan Stone",legs="Meg. Chausses +1",feet="Meg. Jam. +1"}
		
	sets.buff['Triple Shot'] = {body="Chasseur's Frac +1"}
    
    -- Sets to return to when not performing an action.
	
	sets.DayIdle = {}
	sets.NightIdle = {}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
    
    -- Resting sets
    sets.resting = {}
    

    -- Idle sets
	sets.idle = {
		sub="Nusku Shield",
		head={ name="Lanun Tricorne", augments={'Enhances "Winning Streak" effect',}},
		body={ name="Lanun Frac", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+13','Accuracy+14','"Triple Atk."+1','Magic dmg. taken -2%',}},
		legs="Meg. Chausses +1",
		feet="Meg. Jam. +1",
		neck="Clotharius Torque",
		waist="Eschan Stone",
		left_ear="Enervating Earring",
		right_ear="Volley Earring",
		left_ring="Barataria Ring",
		right_ring="Warp Ring",
		back="Camulus's Mantle",
	}
	
    -- sets.idle = {ammo=gear.RAbullet,
        -- head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        -- body="Meg. Cuirie +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        -- back="Moonbeam Cape",waist="Flume Belt",legs="Carmine Cuisses +1",feet=gear.herculean_dt_feet}
		
    sets.idle.Refresh = {ammo=gear.RAbullet,
        head="Rawhide Mask",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Ethereal Earring",
        body="Mekosu. Harness",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Rawhide Trousers",feet=gear.herculean_dt_feet}
    
    -- Defense sets
    sets.defense.PDT = {ammo=gear.RAbullet,
        head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_dt_feet}

    sets.defense.MDT = {ammo=gear.RAbullet,
        head="Meghanada Visor +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Meg. Cuirie +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Meg. Chausses +1",feet=gear.herculean_dt_feet}
    

    sets.Kiting = {legs="Carmine Cuisses +1"}
	
	sets.Weapons = {main="Fettering Blade", sub="Nusku Shield"}
	sets.DualWeapons = {main="Fettering Blade", sub="Demersal Degen +1"}
	sets.DualRangedWeapons = {main="Fettering Blade", sub="Kustawi +1"}
	sets.DDGunWeapon = {range="Molybdosis"}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Meg. Cuirie +1",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
    sets.engaged.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Telos Earring",
		body="Meg. Cuirie +1",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_acc_feet}

    sets.engaged.DW = {
		head="Dampening Tam",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
		body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Epona's Ring",ring2="Petrov Ring",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    
    sets.engaged.DW.Acc = {
		head="Dampening Tam",neck="Combatant's Torque",ear1="Digni. Earring",ear2="Telos Earring",
		body="Meg. Cuirie +1",hands="Floral Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
		back=gear.tp_jse_back,waist="Reiki Yotai",legs="Meg. Chausses +1",feet=gear.herculean_acc_feet}

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(1, 2)
end