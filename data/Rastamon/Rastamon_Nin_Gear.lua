-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal', 'Evasion', 'PDT')
    state.RangedMode:options('Normal', 'Acc')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'FullAcc', 'Fodder')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'Sphere')
    state.PhysicalDefenseMode:options('PDT')
	state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	
    gear.KanariaMain ={name="Kanaria",augments={'"Subtle Blow"+5','DEX+11','Accuracy+11','Attack+20','DMG:+17',}}
    gear.KanariaSub ={name="Kanaria",augments={'Weapon skill damage +1%','DEX+13','Accuracy+13','Attack+15','DMG:+14',}}
	
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode', 'None','Knockback','SuppaBrutal','DWEarrings','DWMax'}
	
	send_command('bind ^` input /ja "Innin" <me>')
    send_command('bind !` input /ja "Yonin" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
    select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast sets
    --------------------------------------

    sets.Enmity = {ammo="Paeapua",
        head="Genmei Kabuto",neck="Unmoving Collar +1",ear1="Friomisi Earring",ear2="Trux Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Petrov Ring",ring2="Vengeful Ring",
        back="Solemnity Cape",waist="Goading Belt",legs="Mummu Kecks +1",feet="Amm Greaves"}
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Mijin Gakure'] = {} --legs="Mochizuki Hakama"
    sets.precast.JA['Futae'] = {legs="Hattori Tekko"}
    sets.precast.JA['Sange'] = {} --legs="Mochizuki Chainmail"
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
	
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

    -- Set for acc on steps, since Yonin drops acc a fair bit
    sets.precast.Step = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}

    sets.precast.Flourish1 = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Mekosu. Harness",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Hattori Hakama +1",feet=gear.herculean_acc_feet}

    -- Fast cast sets for spells
    
    sets.precast.FC = {ammo="Impatiens",
		head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Dread Jupon",hands="Leyline Gloves",ring1="Lebeche Ring",ring2="Kishar Ring",
		legs="Rawhide Trousers",feet="Mochi. Kyahan +1"}
		
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads",body="Passion Jacket",feet="Hattori Kyahan +1"})

    -- Snapshot for ranged
    sets.precast.RA = {legs="Nahtirah Trousers"}
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {ammo="Seeth. Bomblet +1",
       ammo="Yamarang",
		head={ name="Herculean Helm", augments={'Mag. Acc.+8','AGI+10','Damage taken-4%','Accuracy+3 Attack+3','Mag. Acc.+18 "Mag.Atk.Bns."+18',}},
		body={ name="Herculean Vest", augments={'Pet: DEX+1','"Mag.Atk.Bns."+17','Weapon skill damage +7%','Accuracy+4 Attack+4',}},
		hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Weapon skill damage +2%','CHR+9',}},
		legs={ name="Herculean Trousers", augments={'Pet: "Mag.Atk.Bns."+22','STR+9','Weapon skill damage +6%','Accuracy+15 Attack+15','Mag. Acc.+8 "Mag.Atk.Bns."+8',}},
		feet="Hiza. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear="Moonshade Earring",
		left_ring="Regal Ring",
		right_ring="Karieyh Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','HP+25','Accuracy+2','DEF+15',}},
		}
		
    sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {head="Dampening Tam",legs="Hiza. Hizayoroi +1",ear2="Telos Earring"})
    sets.precast.WS.Acc = set_combine(sets.precast.WS, {head="Dampening Tam",neck="Combatant's Torque",ear2="Telos Earring",body="Mummu Jacket +1",hands="Mummu Wrists +1",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +1",feet=gear.herculean_acc_feet})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",waist="Olseni Belt",legs="Hiza. Hizayoroi +1",feet=gear.herculean_acc_feet})
	
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",body="Abnoba Kaftan",hands="Ryuo Tekko",ring1="Begrudging Ring",waist="Grunfeld Rope",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Jin'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Qirmiz Tathlum",head="Mummu Bonnet +1",body="Abnoba Kaftan",hands="Ryuo Tekko",waist="Grunfeld Rope",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Jin'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +1",body="Mummu Jacket +1",hands="Ryuo Tekko",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Jin'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +1",body="Mummu Jacket +1",hands="Ryuo Tekko",legs="Mummu Kecks +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Jin'].Fodder = set_combine(sets.precast.WS['Blade: Jin'], {})
	
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {ammo="Qirmiz Tathlum",head="Adhemar Bonnet",ear1="Moonshade Earring",ear2="Brutal Earring",body="Abnoba Kaftan",hands="Ryuo Tekko",ring1="Begrudging Ring",legs="Hiza. Hizayoroi +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Hi'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {ammo="Qirmiz Tathlum",head="Mummu Bonnet +1",ear1="Moonshade Earring",ear2="Trux Earring",body="Mummu Jacket +1",hands="Ryuo Tekko",ring1="Begrudging Ring",legs="Hiza. Hizayoroi +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Hi'].Acc = set_combine(sets.precast.WS.Acc, {head="Mummu Bonnet +1",ear1="Moonshade Earring",ear2="Telos Earring",body="Mummu Jacket +1",hands="Ryuo Tekko",legs="Hiza. Hizayoroi +1",feet="Mummu Gamash. +1"})
    sets.precast.WS['Blade: Hi'].FullAcc = set_combine(sets.precast.WS.FullAcc, {head="Mummu Bonnet +1",hands="Ryuo Tekko",legs="Hiza. Hizayoroi +1"})
    sets.precast.WS['Blade: Hi'].Fodder = set_combine(sets.precast.WS['Blade: Hi'], {})

    sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {feet=gear.herculean_acc_feet})
    sets.precast.WS['Blade: Shun'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {feet=gear.herculean_acc_feet})
    sets.precast.WS['Blade: Shun'].Acc = set_combine(sets.precast.WS.Acc, {legs="Adhemar Kecks"})
    sets.precast.WS['Blade: Shun'].FullAcc = set_combine(sets.precast.WS.FullAcc, {legs="Adhemar Kecks"})
    sets.precast.WS['Blade: Shun'].Fodder = set_combine(sets.precast.WS['Blade: Shun'], {})

    sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {neck="Caro Necklace",ear1="Moonshade Earring",ear2="Ishvara Earring",ring1="Ilabrat Ring",ring2="Karieyh Ring",waist="Grunfeld Rope",legs="Hiza. Hizayoroi +1",feet=gear.herculean_wsd_feet})
    sets.precast.WS['Blade: Ten'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {neck="Caro Necklace",ear1="Moonshade Earring", ring1="Ilabrat Ring",ring2="Karieyh Ring",waist="Grunfeld Rope",legs="Hiza. Hizayoroi +1",feet=gear.herculean_wsd_feet})
    sets.precast.WS['Blade: Ten'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Blade: Ten'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Blade: Ten'].Fodder = set_combine(sets.precast.WS['Blade: Ten'], {})
	
    sets.precast.WS['Aeolian Edge'] = {ammo="Dosis Tathlum",
        head="Dampening Tam",neck="Baetyl Pendant",ear1="Friomisi Earring",ear2="Crematio Earring",
        body="Adhemar Jacket",hands="Adhemar Wristbands",ring1="Shiva Ring +1",ring2="Stikini Ring",
        back="Toro Cape",waist="Chaac Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_acc_feet}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.precast.MaxTP = {ear1="Cessance Earring",ear2="Brutal Earring",}
	sets.precast.AccMaxTP = {ear1="Zennaroi Earring",ear2="Telos Earring"}

    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
        head=gear.herculean_fc_head,neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
        body="Dread Jupon",hands="Mochizuki Tekko +1",ring1="Defending Ring",ring2="Kishar Ring",
        legs="Rawhide Trousers",feet=gear.herculean_acc_feet}

    sets.midcast.ElementalNinjutsu = {ammo="Pemphredo Tathlum",
        head=gear.herculean_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Samnuha Coat",hands="Leyline Gloves",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
        back="Toro Cape",waist="Eschan Stone",legs="Gyve Trousers",feet=gear.hercluean_nuke_feet}
		
    sets.midcast.ElementalNinjutsu.Resistant = set_combine(sets.midcast.ElementalNinjutsu, {})
	
	sets.MagicBurst = {ring1="Mujin Band",ring2="Locus Ring"}

    sets.midcast.NinjutsuDebuff = {ammo="Dosis Tathlum",
        head="Dampening Tam",neck="Incanter's Torque",ear1="Gwati Earring",ear2="Digni. Earring",
        body="Mekosu. Harness",hands="Mochizuki Tekko +1",ring1="Stikini Ring",ring2="Stikini Ring",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Rawhide Trousers",feet="Mochi. Kyahan +1"}

    sets.midcast.NinjutsuBuff = set_combine(sets.midcast.FastRecast, {back="Mujin Mantle"})
	
    sets.midcast.Utsusemi = set_combine(sets.midcast.NinjutsuBuff, {back="Andartia's Mantle",feet="Hattori Kyahan +1"})

    sets.midcast.RA = {
        head="Dampening Tam",neck="Combatant's Torque",ear1="Clearview Earring",
        body="Mekosu. Harness",hands="Manibozho Gloves",ring1="Apate Ring",ring2="Rajas Ring",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Mummu Gamash. +1"}
		
    sets.midcast.RA.Acc = {
        head="Dampening Tam",neck="Combatant's Torque",ear1="Clearview Earring",
        body="Mekosu. Harness",hands="Manibozho Gloves",ring1="Apate Ring",ring2="Rajas Ring",
        back="Andartia's Mantle",waist="Chaac Belt",legs="Nahtirah Trousers",feet="Mummu Gamash. +1"}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {}
    
    -- Idle sets
    sets.idle = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Hiza. Haramaki +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Solemnity Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}

    sets.idle.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Solemnity Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
    sets.idle.Sphere = set_combine(sets.idle, {body="Mekosu. Harness"})
		
    sets.idle.Weak = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Solemnity Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
    
    -- Defense sets
    sets.defense.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Apate Ring",
        back="Andartia's Mantle",waist="Shetal Stone",legs="Nahtirah Trousers",feet=gear.herculean_dt_feet}

    sets.defense.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Dark Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}

    sets.defense.MDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Sanare Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Shadow Ring",
        back="Engulfer Cape +1",waist="Engraved Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		
	sets.defense.MEVA = {ammo="Ginsen",
		head="Dampening Tam",neck="Warder's Charm +1",ear1="Etiolation Earring",ear2="Sanare Earring",
		body="Mekosu. Harness",hands="Leyline Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
		back="Toro Cape",waist="Engraved Belt",legs="Samnuha Tights",feet=gear.herculean_dt_feet}


    sets.Kiting = {feet="Danzo Sune-Ate"}
	sets.DuskKiting = {}
	sets.DuskIdle = {}
	sets.DayIdle = {}
	sets.NightIdle = {}


    --------------------------------------
    -- Engaged sets
    --------------------------------------

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee group
    sets.engaged = {ammo="Togakushi Shuriken",
        ammo="Yamarang",
		head={ name="Dampening Tam", augments={'DEX+10','Accuracy+15','Mag. Acc.+15','Quadruple Attack +3',}},
		body="Hiza. Haramaki +2",
		hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
		legs="Jokushu Haidate",
		feet="Hiza. Sune-Ate +1",
		neck="Combatant's Torque",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Cessance Earring",
		left_ring="Chirich Ring",
		right_ring="Hetairoi Ring",
		back={ name="Mecisto. Mantle", augments={'Cap. Point+50%','HP+25','Accuracy+2','DEF+15',}},
		}
    sets.engaged.SomeAcc = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ilabrat Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    sets.engaged.Acc = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Digni. Earring",ear2="Telos Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ilabrat Ring",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
    sets.engaged.FullAcc = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Ramuh Ring +1",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Adhemar Kecks",feet=gear.herculean_acc_feet}
    sets.engaged.Fodder = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Moonbeam Nodowa",ear1="Dedition Earring",ear2="Brutal Earring",
        body="Mummu Jacket +1",hands="Adhemar Wristbands",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Windbuffet Belt +1",legs="Samnuha Tights",feet=gear.herculean_ta_feet}
    sets.engaged.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands="Adhemar Wristbands",ring1="Apate Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Shetal Stone",legs="Nahtirah Trousers",feet=gear.herculean_acc_feet}
		sets.engaged.SomeAcc.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands="Buremte Gloves",ring1="Apate Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Shetal Stone",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.Acc.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Mekosu. Harness",hands="Buremte Gloves",ring1="Apate Ring",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.FullAcc.Evasion = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Combatant's Torque",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Mekosu. Harness",hands="Buremte Gloves",ring1="Apate Ring",ring2="Ramuh Ring +1",
        back="Andartia's Mantle",waist="Olseni Belt",legs="Samnuha Tights",feet=gear.herculean_acc_feet}
    sets.engaged.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Epona's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
		sets.engaged.SomeAcc.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Epona's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_dt_feet}
	sets.engaged.Acc.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Epona's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_acc_feet}
	sets.engaged.FullAcc.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Zennaroi Earring",ear2="Telos Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Epona's Ring",
        back="Andartia's Mantle",waist="Olseni Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_acc_feet}
	sets.engaged.Fodder.PDT = {ammo="Togakushi Shuriken",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Cessance Earring",ear2="Brutal Earring",
        body="Emet Harness +1",hands=gear.herculean_dt_hands,ring1="Defending Ring",ring2="Epona's Ring",
        back="Moonbeam Cape",waist="Flume Belt",legs=gear.herculean_dt_legs,feet=gear.herculean_acc_feet}
		
    --------------------------------------
    -- Custom buff sets
    --------------------------------------

    sets.buff.Migawari = {body="Hattori Ningi +1"}
    sets.buff.Doom = set_combine(sets.buff.Doom, {})
    sets.buff.Yonin = {legs="Hattori Hakama +1"} --
    sets.buff.Innin = {} --head="Hattori Zukin +1"
	
    -- Extra Melee sets.  Apply these on top of melee sets.
    sets.Knockback = {}
	sets.SuppaBrutal = {ear1="Suppanomimi", ear2="Brutal Earring"}
	sets.DWEarrings = {ear1="Dudgeon Earring",ear2="Heartseeker Earring"}
	sets.DWMax = {ear1="Dudgeon Earring",ear2="Heartseeker Earring",body="Adhemar Jacket",hands="Floral Gauntlets",waist="Shetal Stone"}
	sets.Weapons = {main=gear.KanariaMain,sub=gear.KanariaSub}
	sets.MagicWeapons = {main="Ochu",sub="Ochu"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	sets.Skillchain = {legs="Ryuo Hakama"}
	
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 12)
    elseif player.sub_job == 'RNG' then
        set_macro_page(7, 5)
    elseif player.sub_job == 'RDM' then
        set_macro_page(10, 5)
    else
        set_macro_page(10, 12)
    end
end