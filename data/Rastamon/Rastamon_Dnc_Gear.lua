-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('Evasion', 'PDT')
	
    -- Additional local binds
    send_command('bind ^= gs c cycle mainstep')
    send_command('bind != gs c cycle altstep')
    send_command('bind ^- gs c toggle selectsteptarget')
    send_command('bind !- gs c toggle usealtstep')
    send_command('bind ^` input /ja "Chocobo Jig" <me>')
    send_command('bind !` input /ja "Chocobo Jig II" <me>')
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

    sets.precast.JA['No Foot Rise'] = {body="Horos Casaque"}

    sets.precast.JA['Trance'] = {head="Horos Tiara"}
    

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
		ammo="Yamarang",
        head="Mummu Bonnet +1",
		neck="Unmoving Collar +1",
		ear1="Enchntr. Earring +1",
		ear2="Handler's Earring +1",
        body="Passion Jacket",
		hands=gear.herculean_waltz_hands,
		ring1="Defending Ring",
		ring2="Valseur's Ring",
        back="Moonbeam Cape",
		waist="Chaac Belt",
		legs="Dashing Subligar",
		feet="Rawhide Boots"
		}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
    
    sets.precast.Samba = {head="Maxixi Tiara"}

    sets.precast.Jig = {legs="Horos Tights", feet="Maxixi Toe Shoes"}

    sets.precast.Steps = {waist="Chaac Belt"}
    sets.precast['Feather Step'] = {feet="Charis Shoes +2"}

    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {ear1="Gwati Earring",ear2="Digni. Earring",
        body="Horos Casaque",hands="Buremte Gloves",ring2="Mephitas's Ring +1",
        waist="Chaac Belt",legs="Iuitl Tights",feet="Iuitl Gaiters +1"} -- magic accuracy
    sets.precast.Flourish1['Desperate Flourish'] = {ammo="Charis Feather",
        head="Whirlpool Mask",neck="Combatant's Torque",
        body="Horos Casaque",hands="Buremte Gloves",ring1="Beeline Ring",
        back="Toetapper Mantle",waist="Hurch'lan Sash",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"} -- acc gear

    sets.precast.Flourish2 = {}
    sets.precast.Flourish2['Reverse Flourish'] = {hands="Charis Bangles +2", back="Toetapper Mantle"}

    sets.precast.Flourish3 = {}
    sets.precast.Flourish3['Striking Flourish'] = {body="Charis Casaque +2"}
    sets.precast.Flourish3['Climactic Flourish'] = {head="Charis Tiara +2"}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",head=gear.herculean_fc_head,neck="Baetyl Pendant",ear2="Loquacious Earring",hands="Thaumas Gloves",ring1="Prolix Ring"}

    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Yamarang",
		head="Mummu Bonnet +1",
		body="Meg. Cuirie +2",
		hands="Mummu Wrists +1",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Illbrat Ring",
		right_ring="Cacoethic Ring +1",
		--back=gear.da_jse_back,
		}
		
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Falcon Eye", back="Toetapper Mantle"})
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Exenterator'].Acc = set_combine(sets.precast.WS['Exenterator'], {ammo="Falcon Eye", back="Toetapper Mantle"})
    sets.precast.WS['Exenterator'].Fodder = set_combine(sets.precast.WS['Exenterator'], {waist=gear.ElementalBelt})

    sets.precast.WS['Pyrrhic Kleos'] = set_combine(sets.precast.WS, {hands="Iuitl Wristbands"})
    sets.precast.WS['Pyrrhic Kleos'].Acc = set_combine(sets.precast.WS.Acc, {hands="Iuitl Wristbands"})

    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Evisceration'].Acc = set_combine(sets.precast.WS['Evisceration'], {ammo="Falcon Eye", back="Toetapper Mantle"})

    sets.precast.WS["Rudra's Storm"] = set_combine(sets.precast.WS, {ammo="Charis Feather",neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",body="Adhemar Jacket",hands="Meg. Gloves +2",ring1="Ilabrat Ring"})
    sets.precast.WS["Rudra's Storm"].Acc = set_combine(sets.precast.WS["Rudra's Storm"], {ammo="Falcon Eye", back="Toetapper Mantle"})

    sets.precast.WS['Aeolian Edge'] = {ammo="Charis Feather",
        head="Wayfarer Circlet",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Moonshade Earring",
        body="Wayfarer Robe",hands="Wayfarer Cuffs",ring1="Shiva Ring +1",ring2="Demon's Ring",
        back="Toro Cape",waist="Chaac Belt",legs="Shneddick Tights +1",feet="Wayfarer Clogs"}
    
    sets.Skillchain = {hands="Charis Bangles +2"}
    
    
    -- Midcast Sets
    
    sets.midcast.FastRecast = {
        head="Felistris Mask",ear2="Loquacious Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",
        legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}
        
    -- Specific spells
    sets.midcast.Utsusemi = {
        head="Felistris Mask",neck="Combatant's Torque",ear2="Loquacious Earring",
        body="Iuitl Vest",hands="Iuitl Wristbands",ring1="Beeline Ring",
        back="Toetapper Mantle",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    
    -- Sets to return to when not performing an action.
    
    -- Resting sets
    sets.resting = {head="Ocelomeh Headpiece +1",neck="Wiglen Gorget",
        ring1="Sheltered Ring",ring2="Paguroidea Ring"}
    sets.ExtraRegen = {head="Ocelomeh Headpiece +1"}
    

    -- Idle sets

    sets.idle = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Meg. Cuirie +2",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back="Toetapper Mantle",
		}
    
    sets.idle.Weak = {ammo="Iron Gobbet",
        head="Felistris Mask",neck="Wiglen Gorget",ear1="Dudgeon Earring",ear2="Heartseeker Earring",
        body="Adhemar Jacket",hands="Buremte Gloves",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Skadi's Jambeaux +1"}
    
    -- Defense sets

    sets.defense.Evasion = {
        head="Felistris Mask",neck="Combatant's Torque",
        body="Adhemar Jacket",hands="Iuitl Wristbands",ring1="Beeline Ring",ring2="Dark Ring",
        back="Toetapper Mantle",waist="Flume Belt",legs="Kaabnax Trousers",feet="Iuitl Gaiters +1"}

    sets.defense.PDT = {ammo="Iron Gobbet",
        head="Felistris Mask",neck="Loricate Torque +1",
        body="Adhemar Jacket",hands="Iuitl Wristbands",ring1="Defending Ring",ring2="Dark Ring",
        back="Shadow Mantle",waist="Flume Belt",legs="Nahtirah Trousers",feet="Iuitl Gaiters +1"}

    sets.defense.MDT = {ammo="Demonry Stone",
        head="Wayfarer Circlet",neck="Loricate Torque +1",
        body="Adhemar Jacket",hands="Wayfarer Cuffs",ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape",waist="Flume Belt",legs="Wayfarer Slops",feet="Wayfarer Clogs"}

    sets.Kiting = {feet="Skadi's Jambeaux +1"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    sets.engaged.Fodder = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Fodder.Evasion = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    sets.engaged.Acc = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Evasion = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.PDT = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Acc.Evasion = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Acc.PDT = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    -- Custom melee group: High Haste (2x March or Haste)
    sets.engaged.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    sets.engaged.Fodder.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Fodder.Evasion.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    sets.engaged.Acc.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Evasion.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Acc.Evasion.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.PDT.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Acc.PDT.HighHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    -- Custom melee group: Max Haste (2x March + Haste)
    sets.engaged.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    -- Getting Marches+Haste from Trust NPCs, doesn't cap delay.
    sets.engaged.Fodder.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Fodder.Evasion.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

    sets.engaged.Acc.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Evasion.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Acc.Evasion.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.PDT.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}
		
    sets.engaged.Acc.PDT.MaxHaste = {
		ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Adhemar Jacket",
		hands="Meghanada Gloves +2",
		legs="Mummu Kecks +1",
		feet="Mummu Gamash. +1",
		neck="Lissome Necklace",
		waist="Kentarch Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Hetairoi Ring",
		right_ring="Epona's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
		}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Bladeborn Earring",ear2="Steelflash Earring"}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Steelflash Earring"}

    -- Buff sets: Gear that needs to be worn to actively enhance a current player buff.
    sets.buff['Saber Dance'] = {legs="Horos Tights"}
    sets.buff['Climactic Flourish'] = {head="Charis Tiara +2"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 5)
    elseif player.sub_job == 'SAM' then
        set_macro_page(1, 5)
    else
        set_macro_page(1, 5)
    end
end