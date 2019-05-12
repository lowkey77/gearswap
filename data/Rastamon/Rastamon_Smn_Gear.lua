-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal', 'Acc')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'TPEat', 'Regain')

    gear.perp_staff = {name="Nirvana"}
	
	gear.magic_jse_back = {name="Campestres's Cape",augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
	gear.phys_jse_back = {name="Campestres's Cape",augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Eva.+20 /Mag. Eva.+20','Pet: Haste+10',}}
	
    send_command('bind !` input /ja "Release" <me>')
	send_command('bind @` gs c cycle MagicBurst')
	send_command('bind ^` gs c toggle PactSpamMode')
	send_command('bind @f10 gs c cycle RecoverMode')
	send_command('bind !pause gs c toggle AutoSubMode') --Automatically uses sublimation.
	
    select_default_macro_book()
	set_lockstyle()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Precast Sets
    --------------------------------------
    
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {feet=gear.merlinic_treasure_feet})
	
    -- Precast sets to enhance JAs
    sets.precast.JA['Astral Flow'] = {head="Glyphic Horn +1"}
    
    sets.precast.JA['Elemental Siphon'] = {
		main="Nirvana",
        head="Convoker's Horn +3",
		neck="Incanter's Torque", 
		ear2="Andoaa Earring",
        body="Beckoner's Doublet +1",
		hands="Glyphic Bracers +1",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
        legs="Tatsumaki Sitagoromo",
		feet="Beckoner's Pigaches +1", 
		waist="Kobo Obi", 
		back="Conveyance Cape"
		}

    sets.precast.JA['Mana Cede'] = {hands="Beckoner's Bracers +1"}

    -- Pact delay reduction gear
    sets.precast.BloodPactWard = {
		main= {name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},-- II -2
		neck="Incanter's Torque" ,
		ammo="Sancus Sachet +1", -- II -7
		head="Beckoner's Horn +1", 
		body="Convoker's Doublet +3", -- I -15
		hands="Beckoner's Bracers +1", 
		ring1="Evoker's Ring", 
		ring2="Stikini Ring +1",
		ear2="Andoaa Earring", -- I -1
		ear1="Evans Earring", -- I -2
		waist="Kobo Obi", 
		legs="Beckoner's Spats +1", 
		back="Conveyance Cape", -- II -3
		feet="Glyphic Pigaches +1" --II -1
		}

    sets.precast.BloodPactRage = sets.precast.BloodPactWard

    -- Fast cast sets for spells
    
    sets.precast.FC = {
		main=gear.grioavolr_fc_staff,sub="Clerisy Strap",
		head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		ammo="Impatiens",
		neck="Baetyl Pendant", 
		ear1="Enchanter Earring +1", 
		ear2="Loquacious Earring",
        body="Zendik Robe",
		ring1="Kishar Ring", 
		ring2="Veneficium ring",
        back="Swith Cape +1",
		waist="Witful Belt",
		legs="Gyve Trousers",
		feet="Amalric Nails",
		}

    sets.precast.FC.Cure = set_combine(sets.precast.FC, {main="Serenity",sub="Clerisy Strap"})
		
    sets.precast.FC['Enhancing Magic'] = set_combine(sets.precast.FC, {waist="Siegel Sash"})
	
    sets.precast.FC.Stoneskin = set_combine(sets.precast.FC['Enhancing Magic'], {})

       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
		ammo="Amar Cluster",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst dmg.+10%','INT+4',}},
		body="Count's Garb",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear="Novio Earring",
		left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",
		back="Seshaw Cape",
	}

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Myrkr'] = {
		ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",
		neck="Sanctity Necklace",
		ear1="Etiolation Earring",
		ear2="Gifted Earring",
        body="Convoker's Doublet +3",
		hands="Asteria Mitts +1",
		ring1="Mephitas's Ring +1",
		ring2="Mephitas's Ring",
        back="Conveyance Cape",
		waist="Luminary Sash",
		legs="Beck. Spats +1",
		feet="Beck. Pigaches +1"
		}

	sets.precast.WS['Graland of Bliss'] = {
		ammo="Amar Cluster",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst dmg.+10%','INT+4',}},
		body="Count's Garb",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic Damage +9','MND+5','Mag. Acc.+7',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Friomisi Earring",
		right_ear="Novio Earring",
		left_ring="Karieyh Ring",
		right_ring="Rufescent Ring",
		back="Seshaw Cape",
		}
    
    --------------------------------------
    -- Midcast sets
    --------------------------------------

    sets.midcast.FastRecast = {
		main=gear.grioavolr_fc_staff,
		sub="Clerisy Strap",
		ammo="Sancus Sachet +1",
		head={ name="Merlinic Hood", augments={'"Mag.Atk.Bns."+20','Magic burst dmg.+10%','INT+4',}},
		body="Zendik Robe",
		hands={ name="Glyphic Bracers +1", augments={'Inc. Sp. "Blood Pact" magic burst dmg.',}},
		legs="Gyve Trousers",
		feet="Convoker's Pigaches +3",
		neck="Baetyl Pendant",
		waist="Witful Belt",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Prolix Ring",
		right_ring="Veneficium Ring",
		back="Swith Cape +1",
		}
	
    sets.midcast.Cure = {
		main="Serenity",
		sub="Elan Strap",
        head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		neck="Incanter's Torque",
		ear2="Loquacious Earring",
        body="Heka's Kalasiris",
		hands="Telchine Gloves",
		ring1="Ephedra Ring",
		ring2="Sirona's Ring",
        back="Swith Cape +1",
		waist=gear.ElementalObi,
		legs="Nares Trews",
		feet="Hagondes Sabots"
		}
		
	sets.Self_Healing = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Cure_Recieved = {neck="Phalaina Locket",ring1="Kunaji Ring",ring2="Asklepian Ring",waist="Gishdubar Sash"}
	sets.Self_Refresh = {back="Grapevine Cape",waist="Gishdubar Sash"}
		
	sets.midcast.Cursna =  set_combine(sets.midcast.Cure, {neck="Debilis Medallion",hands="Hieros Mittens",
		ring1="Haoma's Ring",ring2="Haoma's Ring", back="Tempered Cape +1",waist="Witful Belt"})
		
	sets.midcast.StatusRemoval = set_combine(sets.midcast.FastRecast, {main="Oranyan",sub="Clemency Grip"})

    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {neck="Nodens Gorget",ear2="Earthcry Earring",waist="Siegel Sash",legs="Shedir Seraweels"})

	sets.midcast['Elemental Magic'] = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
	sets.midcast['Elemental Magic'].Resistant = {main=gear.grioavolr_nuke_staff,sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}

    sets.midcast['Divine Magic'] = {main="Oranyan",sub="Zuuxowu Grip",ammo="Dosis Tathlum",
        head=gear.merlinic_nuke_head,neck="Baetyl Pendant",ear1="Crematio Earring",ear2="Friomisi Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Shiva Ring +1",ring2="Shiva Ring +1",
		back="Toro Cape",waist="Sekhmet Corset",legs="Merlinic Shalwar",feet=gear.merlinic_nuke_feet}
		
    sets.midcast['Dark Magic'] = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head=gear.merlinic_nuke_head,neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
        back="Aurist's Cape +1",waist="Yamabuki-no-Obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
	
	sets.midcast.Drain = {main="Rubicundity",sub="Culminus",ammo="Pemphredo Tathlum",
        head="Pixie Hairpin +1",neck="Incanter's Torque",ear1="Digni. Earring",ear2="Gwati Earring",
        body="Merlinic Jubbah",hands="Amalric Gages",ring1="Archon Ring",ring2="Evanescence Ring",
        back="Aurist's Cape +1",waist="Fucho-no-obi",legs="Merlinic Shalwar",feet=gear.merlinic_aspir_feet}
    
    sets.midcast.Aspir = sets.midcast.Drain
		
    sets.midcast.Stun = {main="Oranyan",sub="Clerisy Strap",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
		body="Inyanga Jubbah +1",hands="Helios Gloves",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Swith Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
    sets.midcast.Stun.Resistant = {main="Oranyan",sub="Clerisy Strap",ammo="Hasty Pinion +1",
		head="Amalric Coif",neck="Baetyl Pendant",ear1="Enchntr. Earring +1",ear2="Gwati Earring",
		body="Inyanga Jubbah +1",hands="Helios Gloves",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Witful Belt",legs="Psycloth Lappas",feet="Regal Pumps +1"}
		
	sets.midcast['Enfeebling Magic'] = {main="Oranyan",sub="Enki Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Kishar Ring",ring2="Stikini Ring +1",
		back="Aurist's Cape +1",waist="Luminary Sash",legs="Psycloth Lappas",feet="Uk'uxkaj Boots"}
		
	sets.midcast['Enfeebling Magic'].Resistant = {main="Oranyan",sub="Clerisy Strap",ammo="Pemphredo Tathlum",
		head="Befouled Crown",neck="Erra Pendant",ear1="Digni. Earring",ear2="Gwati Earring",
		body="Merlinic Jubbah",hands="Lurid Mitts",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back=gear.nuke_jse_back,waist="Luminary Sash",legs="Psycloth Lappas",feet="Medium's Sabots"}
		
	sets.midcast.Dia = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Diaga = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Dia II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast.Bio = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
	sets.midcast['Bio II'] = set_combine(sets.midcast['Enfeebling Magic'], sets.TreasureHunter)
		
	sets.midcast['Enhancing Magic'] = {main="Oranyan",sub="Fulcio Grip",ammo="Hasty Pinion +1",
		head="Telchine Cap",neck="Incanter's Torque",ear1="Andoaa Earring",ear2="Gifted Earring",
		body="Telchine Chas.",hands="Telchine Gloves",ring1="Stikini Ring +1",ring2="Stikini Ring +1",
		back="Perimede Cape",waist="Olympus Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
	sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif"})
	
	sets.midcast.Aquaveil = set_combine(sets.midcast['Enhancing Magic'], {head="Amalric Coif",waist="Emphatikos Rope",legs="Shedir Seraweels"})
	
	sets.midcast.BarElement = set_combine(sets.precast.FC['Enhancing Magic'], {legs="Shedir Seraweels"})


    -- Avatar pact sets.  All pacts are Ability type.
    
    sets.midcast.Pet.BloodPactWard = {
		main={ name="Espiritus", augments={'Summoning magic skill +15','Pet: Mag. Acc.+30','Pet: Damage taken -4%',}},
		sub="Vox Grip",
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		body="Beck. Doublet +1",
		hands="Lamassu Mitts +1",
		legs="Beck. Spats +1",
		feet="Baayami Sabots",
		neck="Incanter's Torque",
		waist="Kobo Obi",
		left_ear="Evans Earring",
		right_ear="Andoaa Earring",
		left_ring="Evoker's Ring",
		right_ring="Stikini Ring +1",
		back={ name="Conveyance Cape", augments={'Summoning magic skill +4','Pet: Enmity+11','Blood Pact Dmg.+3','Blood Pact ab. del. II -3',}},
		}

    sets.midcast.Pet.DebuffBloodPactWard = {
		main="Nirvana",
		ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",
		neck="Incanter's Torque",
        body="Beckoner's Doublet +1",
		hands="Lamassu Mitts +1",
		right_ear="Andoaa Earring",
		ring1="Evoker's Ring",
		ring2="Stikini Ring +1",
        waist="Kobo Obi",
		legs="Beckoner's Spats +1", 
		feet="Beckoner's Pigaches +1", 
		back="Conveyance Cape"
		}
        
    sets.midcast.Pet.DebuffBloodPactWard.Acc = sets.midcast.Pet.DebuffBloodPactWard
    
    sets.midcast.Pet.PhysicalBloodPactRage = {
		main="Nirvana",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'Pet: Attack+25','Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+8',}},
		left_ring="Varar Ring",
		body="Convoker's Doublet +3",
		hands="Convoker's Bracers +3",
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",		
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}
		
    sets.midcast.Pet.PhysicalBloodPactRage.Acc = sets.midcast.Pet.PhysicalBloodPactRage

    sets.midcast.Pet.MagicalBloodPactRage = {
		main={ name="Grioavolr", augments={'Pet: INT+10','Pet: Mag. Acc.+30','Pet: "Mag.Atk.Bns."+30',}},
        ammo="Sancus Sachet +1",
		head={ name="Apogee Crown", augments={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',}},
		neck="Adad Amulet", 
		ring1="Varar Ring",
        body="Convoker's Doublet +3",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: Mag. Acc.+9',}},
		ring2="Varar Ring",
        waist="Regal Belt",
		legs="Enticer's Pants", 
		feet="Convoker's Pigaches +3", 
		back={ name="Campestres's Cape", augments={'Pet: M.Acc.+20 Pet: M.Dmg.+20','Accuracy+20 Attack+20','Pet: Magic Damage+10','Pet: Haste+10',}},
		}

    sets.midcast.Pet.MagicalBloodPactRage.Acc = sets.midcast.Pet.MagicalBloodPactRage

    -- Spirits cast magic spells, which can be identified in standard ways.
    
    sets.midcast.Pet.WhiteMagic = {legs="Beckoner's Spats +1"} --legs="Summoner's Spats"
    
    sets.midcast.Pet['Elemental Magic'] = set_combine(sets.midcast.Pet.MagicalBloodPactRage, {}) --legs="Summoner's Spats"

    sets.midcast.Pet['Elemental Magic'].Resistant = {}
    
	sets.midcast.Pet['Flaming Crush'] = {
		main="Nirvana",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head={ name="Apogee Crown +1", augments={'Pet: Attack+25','Pet: "Mag.Atk.Bns."+25','Blood Pact Dmg.+8',}},
		body="Con. Doublet +3",
		hands={ name="Merlinic Dastanas", augments={'Pet: "Mag.Atk.Bns."+22','Blood Pact Dmg.+10','Pet: Mag. Acc.+9',}},
		legs={ name="Apogee Slacks +1", augments={'Pet: STR+20','Blood Pact Dmg.+14','Pet: "Dbl. Atk."+4',}},
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Regal Belt",
		left_ear="Gelos Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}

    --------------------------------------
    -- Idle/resting/defense/etc sets
    --------------------------------------
    
    -- Resting sets
    sets.resting = {main="Nirvana",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Nodens Gorget",ear1="Evans Earring",ear2="Loquacious Earring",
        body="Witching Robe",hands="Beckoner's Bracers +1",ring1="Evoker's Ring",ring2="Varar Ring",
        back="Campestres's Cape",waist="Fucho-no-obi",legs="Assiduity pants +1",feet="Baayami Sabots"}
    
    -- Idle sets
    sets.idle = {main="Nirvana",sub="Elan Strap",ammo="Sancus Sachet +1",
        head="Convoker's Horn +3",neck="Shulmanu Collar",ear1="Gelos Earring",ear2="Lugalbanda Earring",
        body="Witching Robe", hands="Asteria Mitts +1",ring1="Evoker's Ring",ring2="Varar Ring",
        back="Campestres's Cape",waist="Regal Belt",legs="Assiduity pants +1",feet="Baayami Sabots",}

    sets.idle.PDT = {main="Nirvana",sub="Elan Strap",ammo="Sancus Sachet +1",
        head="Beckoner's Horn +1",neck="Twilight Torque",ear1="Evans Earring",ear2="Loquacious Earring",
        body="Witching Robe", hands="Yaoyotl Gloves",ring1="Defending Ring",ring2="Varar Ring",
        back="Campestres's Cape",waist="Convoker's Pigaches +2",legs="Hagondes Pants",feet="Baayami Sabots",}
		
	sets.idle.TPEat = set_combine(sets.idle, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain = set_combine(sets.idle, {ring2="Karieyh Ring"})

    -- perp costs:
    -- spirits: 7
    -- carby: 11 (5 with mitts)
    -- fenrir: 13
    -- others: 15
    -- avatar's favor: -4/tick
    
    -- Max useful -perp gear is 1 less than the perp cost (can't be reduced below 1)
    -- Aim for -14 perp, and refresh in other slots.
    
    -- -perp gear:
    -- Gridarvor: -5
    -- Glyphic Horn: -4
    -- Caller's Doublet +2/Glyphic Doublet: -4
    -- Evoker's Ring: -1
    -- Con. Pigaches +1: -4
    -- total: -18
    
    -- Can make due without either the head or the body, and use +refresh items in those slots.
    
    sets.idle.Avatar = {
		main="Nirvana",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Convoker's Doublet +3",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Regal Belt",
		left_ear="Enmerkar Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Speaker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}
		
    sets.idle.PDT.Avatar = {
		main="Nirvana",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Convoker's Doublet +3",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Regal Belt",
		left_ear="Enmerkar Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Speaker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}

    sets.idle.Spirit = {
		main="Nirvana",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Convoker's Doublet +3",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Regal Belt",
		left_ear="Enmerkar Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Speaker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}
		
    sets.idle.PDT.Spirit = {
		main="Nirvana",
		sub="Elan Strap",
		ammo="Sancus Sachet +1",
		head="Beckoner's Horn +1",
		body="Convoker's Doublet +3",
		hands="Asteria Mitts +1",
		legs="Assid. Pants +1",
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Regal Belt",
		left_ear="Enmerkar Earring",
		right_ear="Lugalbanda Earring",
		left_ring="Varar Ring",
		right_ring="Speaker's Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}
		
	sets.idle.TPEat.Avatar = set_combine(sets.idle.Avatar, {neck="Chrys. Torque",ring2="Karieyh Ring"})
	sets.idle.Regain.Avatar = set_combine(sets.idle.Avatar, {ring2="Karieyh Ring"})
		
	--Favor always up and head is best in slot idle so no specific items here at the moment.
    sets.idle.Avatar.Favor = {}
    sets.idle.Avatar.Melee = {}
	
	sets.idle.Avatar.Melee.Carbuncle = {}
	sets.idle.Avatar.Melee['Cait Sith'] = {hands="Lamassu Mitts +1"}
        
    sets.perp = {}
    -- Caller's Bracer's halve the perp cost after other costs are accounted for.
    -- Using -10 (Gridavor, ring, Conv.feet), standard avatars would then cost 5, halved to 2.
    -- We can then use Hagondes Coat and end up with the same net MP cost, but significantly better defense.
    -- Weather is the same, but we can also use the latent on the pendant to negate the last point lost.
    sets.perp.Day = {}
    sets.perp.Weather = {}
	
	sets.perp.Carbuncle = {hands="Asteria Mitts +1"}
    sets.perp.Diabolos = {}
    sets.perp.Alexander = sets.midcast.Pet.BloodPactWard

	-- Not really used anymore, was for the days of specific staves for specific avatars.
    sets.perp.staff_and_grip = {}
    
    -- Defense sets
    sets.defense.PDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Handler's Earring +1",ear2="Enmerkar Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MDT = {main="Terra's Staff",sub="Umbra Strap",ammo="Sancus Sachet +1",
        head="Hagondes Hat +1",neck="Loricate Torque +1",ear1="Etiolation Earring",ear2="Lugalbanda Earring",
        body="Vrikodara Jupon",hands="Hagondes Cuffs +1",ring1="Defending Ring",ring2="Dark Ring",
        back="Umbra Cape",waist="Flax Sash",legs="Hagondes Pants +1",feet="Battlecast Gaiters"}

    sets.defense.MEVA = {main="Terra's Staff",sub="Enki Strap",ammo="Sancus Sachet +1",
        head="Amalric Coif",neck="Warder's Charm +1",ear1="Sanare Earring",ear2="Lugalbanda Earring",
		body="Inyanga Jubbah +1",hands="Telchine Gloves",ring1="Vengeful Ring",Ring2="Purity Ring",
        back="Aurist's Cape +1",waist="Luminary Sash",legs="Telchine Braconi",feet="Telchine Pigaches"}
		
    sets.Kiting = {}
    sets.latent_refresh = {}
	sets.DayIdle = {}
	sets.NightIdle = {}

	sets.HPDown = {head="Apogee Crown",ear1="Mendicant's Earring",ear2="Evans Earring",
		body="Convoker's Doublet +3",hands=empty,ring1="Mephitas's Ring +1",ring2="Mephitas's Ring",
		back="Swith Cape +1",legs="Shedir Seraweels",feet="Apogee Pumps"}
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Sacrifice Torque"}
	sets.Weapons = {main="Nirvana", sub="Elan Strap"}
    --------------------------------------
    -- Engaged sets
    --------------------------------------
    
    -- Normal melee group
    sets.engaged = {
		ammo="Sancus Sachet +1",
		head="Convoker's Horn +3",
		body="Convoker's Doublet +3",
		hands="Convoker's bracers +3",
		legs="Assid. Pants +1",
		feet="Convoker's Pigaches +3",
		neck="Shulmanu Collar",
		waist="Regal Belt",
		left_ear="Enmerkar Earring",
		right_ear="Telos Earring",
		left_ring="Varar Ring",
		right_ring="Varar Ring",
		back={ name="Campestres's Cape", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Attack+10 Pet: Rng.Atk.+10','Pet: "Regen"+10',}},
		}
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book(reset)
    if reset == 'reset' then
        -- lost pet, or tried to use pact when pet is gone
    end
    
    -- Default macro set/book
    set_macro_page(1, 4)
end

-- Lockstyle
function set_lockstyle()
	send_command('wait 6;input /lockstyleset 7')
end