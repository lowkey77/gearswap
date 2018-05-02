-- Setup vars that are user-dependent.
function user_setup()
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal','DTLite','PDT','Reraise')
    state.WeaponskillMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.RangedMode:options('Normal', 'Acc')
    state.PhysicalDefenseMode:options('PDT','PDTReraise')
	state.MagicalDefenseMode:options('MDT','MDTReraise')
	state.ResistDefenseMode:options('MEVA')
    state.IdleMode:options('Normal', 'Reraise')
	
    update_combat_form()

	gear.ws_jse_back = {name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.stp_jse_back = {name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.valorous_wsd_head = { name="Valorous Mask", augments={'Accuracy+17 Attack+17','Weapon skill damage +5%','Accuracy+12','Attack+7',}}
	gear.valorous_wsd_hands = { name="Valorous Mitts", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','AGI+2','Accuracy+13','Attack+6',}}
	gear.valorous_wsd_feet = { name="Valorous Greaves", augments={'Accuracy+17','Weapon skill damage +4%','CHR+7',}}
    -- Additional local binds
    send_command('bind ^` input /ja "Hasso" <me>')
    send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons MultiWeapon;gs c update')
	send_command('bind ^q gs c weapons Bow;gs c update')

    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    -- Precast sets to enhance JAs
    sets.precast.JA.Meditate = {head="Wakido Kabuto +1",hands="Sakonji Kote +1",back=gear.ws_jse_back}
    sets.precast.JA['Warding Circle'] = {head="Wakido Kabuto +1"}
    sets.precast.JA['Blade Bash'] = {hands="Sakonji Kote +1"}
	sets.precast.JA['Sekkanoki'] = {hands="Kasuga Kote +1"}
	sets.precast.JA['Sengikori'] = {feet="Kas. Sune-Ate +1"}
	
    sets.precast.Step = {
        head="Flam. Zucchetto +1",neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Tartarus Platemail",hands="Acro Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Acro Breeches",feet="Founder's Greaves"}
    sets.precast.JA['Violent Flourish'] = {
        head="Founder's Corona",neck="Sanctity Necklace",ear1="Gwati Earring",ear2="Telos Earring",
        body="Found. Breastplate",hands="Leyline Gloves",ring1="Stikini Ring",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Acro Breeches",feet="Founder's Greaves"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Flam. Zucchetto +1",
        body="Tartarus Platemail",hands="Acro Gauntlets",ring1="Asklepian Ring",ring2="Valseur's Ring",
        waist="Chaac Belt",legs="Acro Breeches",feet="Sak. Sune-Ate +1"}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Fast cast sets for spells
    sets.precast.FC = {neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Prolix Ring"}
	   
    -- Ranged snapshot gear
    sets.precast.RA = {}
	   
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Knobkierrie",
        head=gear.valorous_wsd_head,
		neck="Fotia Gorget",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
        body="Dagon breastplate",
		hands=gear.valorous_wsd_hands,
		right_ring="Niqmaddu Ring",
		left_ring="Karieyh Ring",
        back=gear.ws_jse_back,
		waist="Fotia Belt",
		legs="Hiza. Hizayoroi +1",
		feet=gear.valorous_wsd_feet
		}
		
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {ear1="Cessance Earring"})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {ear1="Cessance Earring", ring2="Rufescent Ring"})
    sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",body="Hiza. Haramaki +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",})
    sets.precast.WS.Fodder = set_combine(sets.precast.WS, {ring2="Karieyh Ring"})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Tachi: Fudo'] = set_combine(sets.precast.WS, {left_ear="Moonshade Earring"})
    sets.precast.WS['Tachi: Fudo'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Fudo'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Fudo'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Fudo'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Tachi: Shoha'] = set_combine(sets.precast.WS, {left_ear="Moonshade Earring"})
    sets.precast.WS['Tachi: Shoha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Shoha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Shoha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Shoha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Rana'] = set_combine(sets.precast.WS, {ear1="Telos Earring",ear2="Cessance Earring"})
    sets.precast.WS['Tachi: Rana'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Rana'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Rana'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Rana'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Kasha'] = set_combine(sets.precast.WS, {left_ear="Ishvara Earring"})
    sets.precast.WS['Tachi: Kasha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Kasha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Kasha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Kasha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Gekko'] = set_combine(sets.precast.WS, {left_ear="Ishvara Earring"})
    sets.precast.WS['Tachi: Gekko'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Gekko'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Gekko'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Gekko'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Yukikaze'] = set_combine(sets.precast.WS, left_ear="Ishvara Earring"{})
    sets.precast.WS['Tachi: Yukikaze'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Yukikaze'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Yukikaze'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Ageha'] = set_combine(sets.precast.WS, {left_ear="Moonshade Earring"})
    sets.precast.WS['Tachi: Ageha'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Ageha'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Ageha'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Ageha'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Tachi: Jinpu'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Tachi: Jinpu'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Tachi: Jinpu'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Tachi: Jinpu'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Tachi: Jinpu'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Apex Arrow'] = {
        head="Gavialis Helm",neck="Fotia Gorget",ear1="Clearview Earring",ear2="Moonshade Earring",
        body="Kyujutsugi",hands="Buremte Gloves",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.ws_jse_back,waist="Fotia Belt",legs="Acro Breeches",feet="Waki. Sune-Ate +1"}
		
    sets.precast.WS['Apex Arrow'].SomeAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Acc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].FullAcc = set_combine(sets.precast.WS['Apex Arrow'], {})
    sets.precast.WS['Apex Arrow'].Fodder = set_combine(sets.precast.WS['Apex Arrow'], {ring1="Apate Ring",ring2="Ilabrat Ring",back="Buquwik Cape"})

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}
	
    -- Midcast Sets
    sets.midcast.FastRecast = {
        head="Loess Barbuta +1",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Tartarus Platemail",hands="Leyline Gloves",ring1="Defending Ring",ring2="Prolix Ring",
        back="Moonbeam Cape",waist="Tempus Fugit",legs="Hiza. Hizayoroi +1",feet="Amm Greaves"}
		
    -- Specific spells
    sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	
		
    -- Ranged gear
    sets.midcast.RA = {
        head="Flam. Zucchetto +1",neck="Ocachi Gorget",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Kyujutsugi",hands="Buremte Gloves",ring1="Apate Ring",ring2="Ilabrat Ring",
        back="Buquwik Cape",waist="Flax Sash",legs="Acro Breeches",feet="Waki. Sune-Ate +1"}

    sets.midcast.RA.Acc = {
        head="Flam. Zucchetto +1",neck="Combatant's Torque",ear1="Clearview Earring",ear2="Neritic Earring",
        body="Kyujutsugi",hands="Buremte Gloves",ring1="Apate Ring",ring2="Ilabrat Ring",
        back="Buquwik Cape",waist="Flax Sash",legs="Acro Breeches",feet="Waki. Sune-Ate +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {ammo="Staunch Tathlum",
        head=gear.valorous_wsd_head,neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Hiza. Haramaki +1",hands="Sakonji Kote +1",ring1="Defending Ring",ring2="Karieyh Ring",
        back="Solemnity Cape",waist="Flume Belt",legs="Hiza. Hizayoroi +1",feet="Flam. Gambieras +1"}
    

    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
	
	sets.Kiting = {feet="Danzo Sune-ate"}

    sets.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	
	sets.Weapons = {main="Dojikiri Yasutsuna",sub="Utu Grip"}
	sets.MultiWeapon = {main="Norifusa +1",sub="Utu Grip"}
	sets.Bow = {range="Cibitshavore"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {}
	
    sets.idle = {
		sub="Utu Grip",
		ammo="Ginsen",
        head=gear.valorous_wsd_head,
		neck="Moonbeam Nodowa",
		body="Dagon breastplate",
		ear1="Telos Earring",
		ear2="Cessance Earring",
		hands="Wakido Kote +2",
		ring1="Chirich Ring",
		ring2="Karieyh Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		waist="Ioskeha Belt",legs="Flamma Dirs +1",
		legs="Wakido Haidate +2",
		feet="Wakido sune-ate +3"
		}
		
    sets.idle.Reraise = set_combine(sets.idle, sets.Reraise)

    sets.idle.Weak = {
		head="Twilight Helm",
        body="Twilight Mail",
		ammo="Ginsen",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}
		
    sets.idle.Weak.Reraise = set_combine(sets.idle.Weak, sets.Reraise)
	
	sets.DayIdle = {}
	sets.NightIdle = {}
    
    -- Defense sets
    sets.defense.PDT = {
		head=gear.valorous_wsd_head,
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring",
		back="Agema Cape",
		}

    sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.Reraise)
		
    sets.defense.MDT = {
		head=gear.valorous_wsd_head,
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring",
		back="Agema Cape",
		}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.Reraise)
	
    sets.defense.MEVA = {
		head=gear.valorous_wsd_head,
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Loricate Torque +1",
		waist="Ioskeha Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Odnowa Earring",
		left_ring="Defending Ring",
		right_ring="Karieyh Ring",
		back="Agema Cape",
		}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    -- Delay 450 GK, 25 Save TP => 65 Store TP for a 5-hit (25 Store TP in gear)
    sets.engaged = {
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body="Dagon breastplate",
		hands="Wakido Kote +2",
		legs="Wakido Haidate +2",
		feet="Wakido Sune. +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=equip.stp_jse_back,
		}
    sets.engaged.SomeAcc = {
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body="Dagon breastplate",
		hands="Wakido Kote +2",
		legs="Wakido Haidate +2",
		feet="Wakido Sune. +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=equip.stp_jse_back,
			}
    sets.engaged.Acc = {
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body="Dagon breastplate",
		hands="Wakido Kote +2",
		legs="Wakido Haidate +2",
		feet="Wakido Sune. +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=equip.stp_jse_back,
		}
    sets.engaged.FullAcc = {
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body="Dagon breastplate",
		hands="Wakido Kote +2",
		legs="Wakido Haidate +2",
		feet="Wakido Sune. +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=equip.stp_jse_back,
		}
    sets.engaged.Fodder = {
		sub="Utu Grip",
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body="Dagon breastplate",
		hands="Wakido Kote +2",
		legs="Wakido Haidate +2",
		feet="Wakido Sune. +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Brutal Earring",
		right_ear="Cessance Earring",
		left_ring="Hetairoi Ring",
		right_ring="Niqmaddu Ring",
		back=equip.stp_jse_back,
		}
    sets.engaged.PDT = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}
    sets.engaged.SomeAcc.PDT = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}
    sets.engaged.Acc.PDT = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}
    sets.engaged.FullAcc.PDT = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}
    sets.engaged.Fodder.PDT = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}
	sets.engaged.DTLite = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}	
    sets.engaged.SomeAcc.DTLite = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}		
    sets.engaged.Acc.DTLite = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}	
    sets.engaged.FullAcc.DTLite = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}	
    sets.engaged.Fodder.DTLite = {
		ammo="Ginsen",
		head="Genmei Kabuto",
		body="Wakido Domaru +2",
		hands="Wakido Kote +2",
		legs="Flamma Dirs +1",
		feet="Wakido Sune. +3",
		neck="Moonbeam Nodowa",
		waist="Anguinus Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Cessance Earring",
		left_ring="Patricius Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
		}	

    sets.engaged.Reraise = set_combine(sets.engaged, sets.Reraise)		
    sets.engaged.SomeAcc.Reraise = set_combine(sets.engaged.SomeAcc, sets.Reraise)		
    sets.engaged.Acc.Reraise = set_combine(sets.engaged.Acc, sets.Reraise)		
    sets.engaged.FullAcc.Reraise = set_combine(sets.engaged.FullAcc, sets.Reraise)		
    sets.engaged.Fodder.Reraise = set_combine(sets.engaged.Fodder, sets.Reraise)		
        
    -- Melee sets for in Adoulin, which has an extra 10 Save TP for weaponskills.
    -- Delay 450 GK, 35 Save TP => 89 Store TP for a 4-hit (49 Store TP in gear), 2 Store TP for a 5-hit
--[[Right now Adoulin sets are the same as non-Adoulin.
	sets.engaged.Adoulin = {ammo="Ginsen",
        head="Flam. Zucchetto +1",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands=gear.valorous_wsd_hands,ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Ioskeha Belt",legs="Acro Breeches",feet="Flam. Gambieras +1"}
    sets.engaged.Adoulin.SomeAcc = {ammo="Ginsen",
        head="Flam. Zucchetto +1",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Acro Breeches",feet="Amm Greaves"}
	sets.engaged.Adoulin.Acc = {ammo="Ginsen",
        head="Flam. Zucchetto +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Acro Breeches",feet="Amm Greaves"}
    sets.engaged.Adoulin.FullAcc = {ammo="Ginsen",
        head="Flam. Zucchetto +1",neck="Combatant's Torque",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back=gear.stp_jse_back,waist="Olseni Belt",legs="Acro Breeches",feet="Flam. Gambieras +1"}
    sets.engaged.Adoulin.Fodder = {ammo="Ginsen",
        head="Flam. Zucchetto +1",neck="Asperity Necklace",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Kasuga Domaru +1",hands="Acro Gauntlets",ring1="Niqmaddu Ring",ring2="Ilabrat Ring",
        back=gear.stp_jse_back,waist="Windbuffet Belt +1",legs="Acro Breeches",feet="Flam. Gambieras +1"}
    sets.engaged.Adoulin.PDT = {ammo="Staunch Tathlum",
        head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Hiza. Hizayoroi +1",feet="Amm Greaves"}
    sets.engaged.Adoulin.SomeAcc.PDT = {ammo="Staunch Tathlum",
        head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Hiza. Hizayoroi +1",feet="Amm Greaves"}	
		sets.engaged.Adoulin.Acc.PDT = {ammo="Staunch Tathlum",
        head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Moonbeam Cape",waist="Olseni Belt",legs="Hiza. Hizayoroi +1",feet="Amm Greaves"}
    sets.engaged.Adoulin.FullAcc.PDT = {ammo="Staunch Tathlum",
        head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Patricius Ring",
        back="Letalis Mantle",waist="Olseni Belt",legs="Hiza. Hizayoroi +1",feet="Amm Greaves"}
    sets.engaged.Adoulin.Fodder.PDT = {ammo="Staunch Tathlum",
        head="Flam. Zucchetto +1",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Tartarus Platemail",hands=gear.valorous_wsd_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs="Hiza. Hizayoroi +1",feet="Amm Greaves"}
		
	sets.engaged.Adoulin.DTLite = sets.engaged.DTLite
    sets.engaged.Adoulin.SomeAcc.DTLite = sets.engaged.SomeAcc.DTLite
    sets.engaged.Adoulin.Acc.DTLite = sets.engaged.Acc.DTLite
    sets.engaged.Adoulin.FullAcc.DTLite = sets.engaged.FullAcc.DTLite
    sets.engaged.Adoulin.Fodder.DTLite = sets.engaged.Fodder.DTLite
    sets.engaged.Adoulin.Reraise = set_combine(sets.engaged.Adoulin, sets.Reraise)		
    sets.engaged.Adoulin.SomeAcc.Reraise = set_combine(sets.engaged.Adoulin.SomeAcc, sets.Reraise)		
    sets.engaged.Adoulin.Acc.Reraise = set_combine(sets.engaged.Adoulin.Acc, sets.Reraise)		
    sets.engaged.Adoulin.FullAcc.Reraise = set_combine(sets.engaged.Adoulin.FullAcc, sets.Reraise)		
    sets.engaged.Adoulin.Fodder.Reraise = set_combine(sets.engaged.Adoulin.Fodder, sets.Reraise)
]]--Right now Adoulin sets are the same as non-Adoulin.

	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque +1"}
	sets.buff.Hasso = {legs="Kasuga Haidate +1"}
    sets.buff.Sekkanoki = {hands="Kasuga Kote +1"}
    sets.buff.Sengikori = {feet="Kas. Sune-Ate +1"}
    sets.buff['Meikyo Shisui'] = {feet="Sak. Sune-Ate +1"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'WAR' then
        set_macro_page(1, 2)
    elseif player.sub_job == 'NIN' then
        set_macro_page(10, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(2, 1)
    else
        set_macro_page(1, 2)
    end
end